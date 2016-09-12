package com.asiainfo.dacp.dp.server.scheduler.command;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.asiainfo.dacp.dp.common.MapKeys;
import com.asiainfo.dacp.dp.server.DpServerContext;
import com.asiainfo.dacp.dp.server.scheduler.bean.TaskLog;
import com.asiainfo.dacp.dp.server.scheduler.cache.MemCache;
import com.asiainfo.dacp.dp.server.scheduler.utils.DpExecutorUtils;
/**
 * 北京电信执行命令拼接类
 * @author Silence
 *
 */
public class BJCTCmdLineBuilder extends ScheduleCmdLineBuilder{
	
	@Autowired
	private DpServerContext dpcontext;
	@Override
	public HashMap buildCmdLine(TaskLog runInfo) {
		HashMap<String, String> map = new HashMap<String, String>();
		String  cmdLine = null;
		String dateArgs = this.formatDateArgs(runInfo);
		String runpara   = dpcontext.getDbDao().queryRunpara(runInfo,dateArgs);
		Map<String, String> template = new HashMap<String, String>();
		template.put("taskid", dateArgs);
		String runPara = DpExecutorUtils.variableSubstitution(runpara, template);//替换参数列表的参数变量
//		if(StringUtils.equals(runPara, ""))//如果参数列表为空，则默认追加日期批次
//		runPara=dateArgs;
		String user=dpcontext.getDbDao().getProcUser(runInfo.getXmlid());
		cmdLine=runInfo.getPath().endsWith("/")?
				runInfo.getPath()+runInfo.getProcName():
				runInfo.getPath()+"/"+runInfo.getProcName()//拼接全路径程序名
			   +" "+user+" "+runPara;//拼接用户名和执行参数
		map.put(MapKeys.CMD_LINE, cmdLine);//完整命令通过个性化命令拼接类执行，直接拼接，agent只需要获取该命令执行即可
//		map.put(MapKeys.PROC_NAME, "exec_shell_programs.sh");//传递真正的程序名
		map.put(MapKeys.PROC_NAME,MemCache.PROC_MAP.get(runInfo.getXmlid())==null?"exec_shell_programs.sh":MemCache.PROC_MAP.get(runInfo.getXmlid()).getExecProc());//传递真正的程序名
		return map;
	}

}
