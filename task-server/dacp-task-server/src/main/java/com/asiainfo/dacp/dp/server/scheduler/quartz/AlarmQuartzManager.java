package com.asiainfo.dacp.dp.server.scheduler.quartz;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.CronExpression;
import org.quartz.CronScheduleBuilder;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Component;

import com.asiainfo.dacp.dp.server.scheduler.dao.DatabaseDao;

@Component
public class AlarmQuartzManager implements DpQuartz {
	@Autowired
	private SchedulerFactoryBean schedulerFactory;
	@Autowired
	private DatabaseDao databaseDao;
	private static Logger LOG = LoggerFactory.getLogger(AlarmQuartzManager.class);

	@Override
	public boolean createCronSchdJob(String name, String group, String cronExp, Class<? extends Job> jobClass,
			Object jobData) {
		try {
			Scheduler scheduler = schedulerFactory.getScheduler();
			JobKey jobKey = JobKey.jobKey(name, group);
			// 如果存在，删除！
			if (scheduler.checkExists(jobKey)) {
				scheduler.deleteJob(jobKey);
			}
			JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(name, group).build();
			jobDetail.getJobDataMap().put(DpQuartz.ALARM_KEY, jobData);
			Trigger trigger = null;
			if (CronExpression.isValidExpression(cronExp)) {
				CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cronExp);
				trigger = TriggerBuilder.newTrigger().withIdentity(name, group).withSchedule(scheduleBuilder)
						.build();
			} else {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				try {
					Date startTime = sdf.parse(cronExp);
					if (startTime.after(new Date())) {
						trigger = TriggerBuilder.newTrigger().withIdentity(name, group).startAt(startTime).build();
					}
				} catch (Exception e) {
					LOG.info("create schdule job [{}.{},{}] fail！", name, group, cronExp);
					LOG.error("", e);
					return false;
				}
			}
			if (trigger != null) {
				scheduler.scheduleJob(jobDetail, trigger);
				LOG.info("create schdule job [{}.{},{}] success！", name, group, cronExp);
			} else {
				// 记录错误日志信息
				databaseDao.insertErrorLog("1002", name, "group: " + name + " 时间:" + cronExp + "创建定时调度告警触发器失败");
			}

			if (!scheduler.isStarted()) {
				scheduler.start();
			}
			return true;
		} catch (Exception e) {
			LOG.error("", e);
			databaseDao.insertErrorLog("1002", name,
					"group: " + name + " 时间:" + cronExp + "创建定时调度告警触发器失败，异常新息为:" + e.getMessage());
			return false;
		}
	}

	@Override
	public boolean modifyCronSchdJob(String key, String group, String cronExp, Class<? extends Job> jobClass,
			Object jobData) {
		if (deleteCronSchdJob(key, group)) {
			return createCronSchdJob(key, group, cronExp, jobClass, jobData);
		} else {
			return false;
		}
	}

	@Override
	public boolean shutdown() {
		Scheduler scheduler = schedulerFactory.getScheduler();
		try {
			scheduler.shutdown();
			return scheduler.isShutdown();
		} catch (SchedulerException e) {
			LOG.error("", e);
			return false;
		}
	}

	@Override
	public boolean deleteCronSchdJob(String name, String group) {
		try {
			JobKey jobKey = JobKey.jobKey(name, group);
			Scheduler scheduler = schedulerFactory.getScheduler();
			if (scheduler.checkExists(jobKey)) {
				return scheduler.deleteJob(jobKey);
			} else {
				return true;
			}
		} catch (SchedulerException e) {
			LOG.error("", e);
			return false;
		}
	}

}
