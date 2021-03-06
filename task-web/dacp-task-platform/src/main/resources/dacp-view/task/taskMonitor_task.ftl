﻿﻿<!DOCTYPE html> 
<html lang="zh" class="app"> 
<head>      
	<meta charset="utf-8" />         
	<title>大数据开放平台</title>     
	<meta http-equiv="X-UA-Compatible" content="chrome=1,ie=edge"/>
	<link href="${mvcPath}/dacp-lib/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet" media="screen"/>
	<link href="${mvcPath}/dacp-lib/datepicker/datepicker.css" type="text/css" rel="stylesheet" media="screen"/>
	<link href="${mvcPath}/dacp-lib/datepicker/jquery.simpledate.css" type="text/css" rel="stylesheet" media="screen"/>
	<link href="${mvcPath}/dacp-lib/datepicker/jquery.pst-area-control.css" type="text/css" rel="stylesheet" media="screen"/>
	<link href="${mvcPath}/dacp-view/ve/css/dacp-ve-js-1.0.css" type="text/css" rel="stylesheet" media="screen"/>
	<link href="${mvcPath}/dacp-res/task/css/implWidgets.css" type="text/css" rel="stylesheet"  />
	<link href="${mvcPath}/dacp-view/aijs/css/ai.css" type="text/css" rel="stylesheet"  />
	
	<script src="${mvcPath}/dacp-lib/jquery/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${mvcPath}/dacp-lib/jquery/jquery-ui-1.10.2.min.js"></script>
	<script src="${mvcPath}/dacp-lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="${mvcPath}/dacp-lib/underscore/underscore.js" type="text/javascript"></script>
	<script src="${mvcPath}/dacp-lib/backbone/backbone-min.js" type="text/javascript"></script>
	<script src="${mvcPath}/dacp-lib/highcharts/highcharts.js" type="text/javascript" ></script>
	<script src="${mvcPath}/dacp-lib/datepicker/bootstrap-datepicker.js" type="text/javascript" ></script>
	<script src="${mvcPath}/dacp-lib/datepicker/jquery.simpledate.js" type="text/javascript"></script>
	<script src="${mvcPath}/dacp-lib/datepicker/jquery.pst-area-control.js" type="text/javascript"></script>
	<script src="${mvcPath}/dacp-view/ve/js/dacp-ve-js-1.0.js" type="text/javascript" charset="utf-8"></script>
	<script src="${mvcPath}/ve/ve-context-path.js" type="text/javascript" charset="utf-8"></script>

    <script src="${mvcPath}/dacp-lib/jquery-plugins/bootstrap-treeview.min.js"> </script>
    <script src="${mvcPath}/dacp-lib/jquery-plugins/jquery.layout-latest.js" type="text/javascript"> </script>
    <script src="${mvcPath}/dacp-view/aijs/js/ai.treeview.js"></script>
    
    
    <!-- 使用ai.core.js需要将下面两个加到页面 -->
	<script src="${mvcPath}/dacp-lib/cryptojs/aes.js" type="text/javascript"></script>
	<script src="${mvcPath}/crypto/crypto-context.js" type="text/javascript"></script>
	
	<script src="${mvcPath}/dacp-view/aijs/js/ai.core.js"></script>
	<script src="${mvcPath}/dacp-view/aijs/js/ai.field.js"></script>
	<script src="${mvcPath}/dacp-view/aijs/js/ai.jsonstore.js"></script>
	<script src="${mvcPath}/dacp-view/aijs/js/ai.grid.js"></script>
    
    
  	<script src="${mvcPath}/dacp-view/task/taskType.js"></script>
	<style type="text/css">
body {
	margin: 0;
	font-family: Roboto, arial, sans-serif;
	font-size: 13px;
	line-height: 20px;
	color: #444444;
	background-color: #f1f1f1;
}

a{
	cursor:pointer;
}

.navbar-btn.btn-sm {
	margin-top: 5px;
	margin-bottom: 10px;
}

tr.active.table-text-visited {
	color: #4CB6CB;
	background-color: #000000;
	font-weight: bold;
}

.ui-layout-north {
	z-index: 10000 !important;
}

.ui-layout-center {
	overflow: auto;
}

.ui-layout-toggler-west .btnCenter {
	background: #00C;
}

.ui-layout-toggler-west .btnWest {
	background: #090;
}

.ui-layout-toggler-west .btnBoth {
	background: #C00;
}

.ui-layout-resizer-west {
	border-width: 0 1px;
}

.ui-layout-toggler-west {
	border-width: 0;
}

.ui-layout-toggler-west div {
	width: 4px;
	height: 35px; /* 3x 35 = 105 total height */
}

.ui-layout-toggler-west .btnCenter {
	background: #00C;
}

.ui-layout-toggler-west .btnWest {
	background: #090;
}

.ui-layout-toggler-west .btnBoth {
	background: #C00;
}

.dropdown-menu{
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 1000;
	display: none;
	float: left;
	min-width: 60px;
	padding: 5px 0;
	margin: 2px 0 0;
	font-size: 14px;
	list-style: none;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #ccc;
	border: 1px solid rgba(0,0,0,.15);
	border-radius: 4px;
	-webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
	box-shadow: 0 6px 12px rgba(0,0,0,.175);
	max-height:300px;
	overflow:visible;
}

</style>
<script>
var _contentStore="";
var _totalStore="";
var g_tvNode; //树之焦点节点
var REFRESHTIMER;
var curTeamCodeCondi = "";
var agent_code="";
var run_freq="";//"day"; 
var task_state="";
var task_type="";
var exportSql="";
var curDateStr = new Date().format("yyyy-mm-dd");
var _status=['0','1',' and task_state>=-7 ','3',' and (task_state between -4 and 4) ',' and task_state= 5 ',' and task_state=6 ',' and task_state>=50 ',' and task_state=-7'];
var _type=['1','2']
var _CLASS=['btn-default','btn-info','btn-info','btn-primary','btn-warning','btn-success','btn-danger','btn-warning','btn-default','btn-danger','btn-info','btn-warning','btn-danger'];
var _VALUE=['创建成功','排队等待','并发检测成功','发送至agent','正在运行','运行成功','运行失败','暂停任务','重做后续','等待中断','失效','未触发','等待重做'];
/*var _treeSql ="SELECT TOPICNAME,LEVEL_VAL,COUNT(1) NUM FROM proc c  right join proc_schedule_log a on a.proc_name=c.proc_name where 1=1 {} GROUP BY TOPICNAME, LEVEL_VAL ORDER BY NUM DESC";
var treeSql ="SELECT TOPICNAME,LEVEL_VAL,COUNT(1) NUM FROM (SELECT PROC_NAME,DATE_ARGS,TEAM_CODE ,MAX(START_TIME) START_TIME FROM proc_schedule_log a WHERE 1=1 {} GROUP BY DATE_ARGS,PROC_NAME,TEAM_CODE) t left join proc b on t.proc_name=b.proc_name where 1=1 {condi} GROUP BY TOPICNAME, LEVEL_VAL ORDER BY NUM DESC";
var _finalQuerySql="SELECT SEQNO,RETURN_CODE,b.PROCTYPE,PRI_LEVEL,PLATFORM,AGENT_CODE,a.PROC_NAME,RUN_FREQ,TASK_STATE,STATUS_TIME,START_TIME,EXEC_TIME,END_TIME,'' DURATION,RETRYNUM,PROC_DATE,DATE_ARGS,QUEUE_FLAG,CURDUTYER,ERRCODE from proc_schedule_log a,proc b where  a.proc_name=b.proc_name {}  order by START_TIME desc";
var  finalQuerySql="SELECT 	SEQNO,RETURN_CODE,b.PROCTYPE,PRI_LEVEL,PLATFORM,AGENT_CODE,t.PROC_NAME,RUN_FREQ,TASK_STATE,STATUS_TIME,t.START_TIME,EXEC_TIME,END_TIME,'' DURATION,	RETRYNUM,PROC_DATE,t.DATE_ARGS ,QUEUE_FLAG,CURDUTYER,ERRCODE FROM (	SELECT PROC_NAME,DATE_ARGS ,TEAM_CODE,MAX(START_TIME) START_TIME FROM proc_schedule_log a where 1=1 {}	GROUP BY PROC_NAME,DATE_ARGS,TEAM_CODE) t left join proc b on t.proc_name=b.proc_name left JOIN proc_schedule_log c ON 	t.DATE_ARGS=c.DATE_ARGS AND  t.PROC_NAME=c.PROC_NAME AND t.START_TIME=c.START_TIME where 1=1  AND valid_flag <> 1  {condi}  ORDER BY  START_TIME DESC ";
var _finalTotalSql="select count(*) as total, sum(case when task_state=6 then 1 else 0 end ) as finish, sum(case when task_state=5 then 1 else 0 end ) as running, sum(case when task_state<=4 and task_state>-4 then 1 else 0 end ) as queue, sum(case when task_state=-7 then 1 else 0 end) as unqueue,sum(case when task_state>6 then 1 else 0 end ) as fail from proc_schedule_log a ,proc b where a.proc_name=b.proc_name  {} ";
var  finalTotalSql ="SELECT COUNT(*) AS TOTAL, SUM(CASE WHEN TASK_STATE=6 THEN 1 ELSE 0 END ) AS FINISH,SUM(CASE WHEN TASK_STATE=5 THEN 1 ELSE 0 END ) AS RUNNING,SUM(CASE WHEN TASK_STATE<=4 AND TASK_STATE>-4 THEN 1 ELSE 0 END ) AS QUEUE, SUM(CASE WHEN TASK_STATE=-7 THEN 1 ELSE 0 END) AS UNQUEUE,SUM(CASE WHEN TASK_STATE>6 THEN 1 ELSE 0 END ) AS FAIL FROM (SELECT PROC_NAME,DATE_ARGS,TEAM_CODE,MAX(START_TIME) START_TIME  FROM PROC_SCHEDULE_LOG a WHERE 1=1 {}	GROUP BY PROC_NAME,DATE_ARGS,TEAM_CODE) t left JOIN PROC b ON t.PROC_NAME=b.PROC_NAME left JOIN PROC_SCHEDULE_LOG c ON 	t.DATE_ARGS=c.DATE_ARGS AND t.PROC_NAME=c.PROC_NAME AND t.START_TIME=c.START_TIME where 1=1  AND valid_flag <> 1 {condi} "; 
*/
var _querySql="SELECT SEQNO,b.topicname,b.level_val,a.PRI_LEVEL,a.PLATFORM,a.AGENT_CODE,a.PROC_NAME,a.RUN_FREQ,TASK_STATE,STATUS_TIME,START_TIME,EXEC_TIME,END_TIME,'' DURATION,RETRYNUM,a.proctype,a.DATE_ARGS,CREATER,a.TIME_WIN,c.ON_FOCUS,queue_flag,ERRCODE,PROC_DATE "+
"  from proc_schedule_log a left join proc b on a.xmlid = b.xmlid left join proc_schedule_info c on a.xmlid = c.xmlid " +
"  where 1=1 {} ";

var _treeSql ="SELECT TOPICNAME,LEVEL_VAL,COUNT(1) NUM FROM (" + _querySql + ") t GROUP BY TOPICNAME,LEVEL_VAL ORDER BY NUM DESC";
var _totalSql=" select count(*) as total, sum(case when task_state=6 then 1 else 0 end ) as finish, sum(case when task_state=5 then 1 else 0 end ) as running,sum(case when task_state in (-1,1) then 1 else 0 end ) as created , sum(case when task_state<=4 and task_state>-4 and task_state not in (-1,1) then 1 else 0 end ) as queue, sum(case when task_state=-7 then 1 else 0 end) as unqueue,sum(case when task_state>6 then 1 else 0 end ) as fail " +
		   "  from (" + _querySql + ") t ";

var _realSql = _querySql;
var _realTotalSql = _totalSql;
var _realTreeSql= _treeSql;

var formatDateArgs=function(dateArgs){
	//yyyyMMddhhmmss--->yyyy-MM-dd hh:mm
	var tmp = dateArgs.toString().trim();
	tmp =  tmp.replace(/-/g,"");
	tmp =  tmp.replace(":" ,"");
	tmp =  tmp.replace(" " ,"");
	var newStr = "";
	for(var i=0;i<tmp.length;i++){
		 if(i==3){
		 	newStr=newStr+tmp.charAt(i)+"-";
		 }else if(i==5){
		 	newStr=newStr+tmp.charAt(i)+"-";
		 }else if(i==7){
		 	newStr=newStr+tmp.charAt(i)+" ";
		 }else if(i==9){
		 	newStr=newStr+tmp.charAt(i)+":";
		 }else{
		 	newStr=newStr+tmp.charAt(i);
		 }
	}
	var finalChar = newStr.charAt(newStr.length-1);
	if(finalChar==" "||finalChar==":"||finalChar=="-"){
	   newStr=newStr.substring(0,newStr.length-1);
	}
	return newStr;
}

var kill = function(seqno,agentCode){
	$.ajax({ 
		url:'/'+contextPath+'/syn/kill?SEQNO='+seqno+'&AGENT_CODE='+agentCode+'&SYN_TYPE=KILL_PROC',
		error:function(){     
		       alert('网络错误！');     
		    },
		success:function(msg){
			var msg = $.parseJSON(msg);
			if(msg.flag==true||msg.flag=="true"){
			     alert('终止任务成功');
				 _contentStore.fetch();
			}else{
				alert('终止任务失败');     
			}
		}
  });
}

var getQuerCondi=function(){
	var _condi = getQuerCondi2();
	if(task_state.length>0){
		_condi +=task_state;
	}else{
		_condi +=" and task_state>=-7 ";   
	}
	return _condi;
};
var getQuerCondi2=function(){
	proc_name = $("#proc_name input").val();
	proc_name = proc_name.length>0?proc_name.trim():"";
	date_args = $("#date_args input").val();
	timestamp = new Date().getTime();
	var start_time = $("#start_time").val().trim();
	var end_time = $("#end_time").val().trim();
	var _condi = " and  '" + timestamp + "'='" + timestamp + "'";
	if(agent_code.length>0){
		_condi +=" and agent_code='"+agent_code+"' ";
	} 
	// if (task_type==2||task_type=='2'){
	// 	_condi+= " and  a.proctype ='SCOPE'";
	// }else{
	// 	_condi+= " and  a.proctype <>'SCOPE'";
	// }
// 	if(task_state.length>0){
// 		_condi +=task_state;
// 	}else{
// 		_condi +=" and task_state>=-7 ";   
// 	}
	if(proc_name.length>0){
		_condi +=" AND (a.proc_name like '%"+proc_name+"%' ) " ;
	}
	
	if(date_args && date_args.length > 0){
		_condi += " and a.date_args like '"+formatDateArgs(date_args)+"%'";
	}
	
	if(start_time && start_time.length > 0){
		//to_date(end_time,'yyyy-mm-dd hh24:mi:ss')
		_condi += " and start_time >= '" + start_time + " 00:00'";
	} 
	
	if(end_time && end_time.length > 0){
		_condi += " and start_time <= '" + end_time + " 23:59'";
	}
	
	if(run_freq=="month"){
		_condi += " and a.run_freq='month' ";
	}else if(run_freq=="day"){
		_condi += " and a.run_freq='day' ";	
	}else if(run_freq=="hour"){
		_condi += " and a.run_freq='hour' ";
	}else if(run_freq=="minute"){
		_condi += " and a.run_freq='minute' ";
	}else if(run_freq=="year"){
		_condi += " and a.run_freq='year' ";
	}
	_condi +=curTeamCodeCondi;
	return _condi;
};
var getQuerySql=function(){
	
	var execSql = _realSql.replace("{}",getQuerCondi());
	return execSql;
};
var _argsRender = function (value,data,index){
	var args = data.DATE_ARGS;
	var argsType = data.RUN_FREQ;
	switch(argsType){
		case "month":
			args = args.substr(0,7);
			break;
		case "year":
			args = args.substr(0,4);
			break;
		default:
			break;
	}
	return args;
};
var _timeDiffRender = function(value,data,index){
	var end= data.END_TIME;
	var start =data.EXEC_TIME;
	if(start&&start.length>0&&end&&end.length>0){
		start +=":00"; 
		start = start.replace(/-/g,"/");
		end  +=":00";
		end  = end.replace(/-/g,"/");
		var _start = new Date(start);
		var _end = new Date(end);
		var diff = _end.getTime()-_start.getTime();
		if(diff<0){
			return"--";
		}
		//计算出相差天数
		var days=Math.floor(diff/(24*3600*1000))
		//计算出小时数
		var leave1=diff%(24*3600*1000)    
		//计算天数后剩余的毫秒数
		var hours=Math.floor(leave1/(3600*1000))
		//计算相差分钟数
		var leave2=leave1%(3600*1000)      
		//计算小时数后剩余的毫秒数
		var minutes=Math.floor(leave2/(60*1000))
		if(days>1){
			hours += days*24;
		}
		minutes = minutes==0?1:minutes;
		var _hours = hours<=9?"0"+hours:""+hours;
		var _minutes=minutes<=9?"0"+minutes:""+minutes;
		if(_minutes.length>0 && _hours.length>0){
			return _hours+":"+_minutes;
		}else{
			return "--";
		}
	}else{
		return "--";
	}
};

var _stateIcon = function(value,data,index){
	value = value>=50&&data.QUEUE_FLAG==1?7:value;
	value = value<0&&value>=-3?8:value;
	value = value==0?9:value;
	value = value==-5?10:value;
	value = value==-6?11:value;
	value = value==-7?12:value;
	value = value>=50&&data.QUEUE_FLAG==0? 13:value;
	var _tmpl = 
		'<div class="btn-group '+(index>6?"dropup":"")+'">'+
		'<button type="button" class="btn btn-xs <%=cla%> dropdown-toggle" data-toggle="dropdown">'+
		' <%=name%> <%if(value!=4&&value!=9&&value!=10&value!=11){%><span class="caret"></span>'+
		'</button>'+
		'<ul class="dropdown-menu" role="menu">'+
		'<%if(value!=12){%>'+
		'<li><a  id="relay" seq="<%=seqno%>" name="<%=procName%>" err="<%=errorCode%>" status="<%=task_status%>">查看执行条件</a></li>'+
		'<%}%>'+ 
		'<%if(value!=6&&value!=4&&value!=5){%>'+
		'<li><a  id="pass"  seq="<%=seqno%>">强制通过</a></li>'+
		'<%}%>'+ 
		'<%if(value==5){%>'+
		'<li><a  id="running-log" seq="<%=seqno%>" agent="<%=agent%>">查看运行日志</a></li>'+
		//'<li><a  id="stop_drive"  seq="<%=seqno%>">停止触发</a></li>'+
		'<li><a  id="kill"  seq="<%=seqno%>" agent="<%=agent%>">停止</a></li>'+
		'<%}%>'+ 
		'<%if(value==1 || value==12){%>'+
		'<li><a  id="force"  seq="<%=seqno%>" >强制执行</a></li>'+
		'<%}%>'+
		'<%if(value<=3&&value>=1){%>'+
		'<li><a  id="pause"  seq="<%=seqno%>" task_status="<%=task_status%>">暂停执行</a></li>'+
		'<%}%>'+
		'<%if(value==7||value==13){%>';
		if(data.PROCTYPE=="taskTypeProc"){
			if(dp_redo_type=='1'||dp_redo_type==1){
				_tmpl+='<li class="dropdown-submenu">'+
				'<a tabindex="-1" href="javascript:;">重做后续</a>'+
				'<ul class="dropdown-menu" >'+
					'<li class=""> <a id="conti" name="重做完整后续" seq="<%=seqno%>" href="javascript:;">'+'<span class="glyphicon "></span>'+'重做完整后续</a></li>'+
					'<li class="" > <a id="contiError" name="重做错误后续" seq="<%=seqno%>"  returncode="<%=returnCode%>"  href="javascript:;">'+'<span class="glyphicon "></span>'+'重做错误后续</a></li>'+
				'</ul></li>'+
				'<li class="dropdown-submenu">'+
				'<a tabindex="-1" href="javascript:;">重做当前</a>'+
				'<ul class="dropdown-menu" >'+
					'<li class=""> <a id="redo" name="重做完整当前" seq="<%=seqno%>" href="javascript:;">'+'<span class="glyphicon "></span>'+'重做完整当前</a></li>'+
					'<li class="" > <a id="redoError" name="重做错误当前" seq="<%=seqno%>"  returncode="<%=returnCode%>"  href="javascript:;">'+'<span class="glyphicon "></span>'+'重做错误当前</a></li>'+
				'</ul></li>';
			}else{
				_tmpl+='<li><a  id="conti"  seq="<%=seqno%>">重做后续</a></li>'+
				'<li><a  id="redo"   seq="<%=seqno%>">重做当前</a></li>';
			}
			
		}else{
			_tmpl+='<li><a  id="conti"  seq="<%=seqno%>">重做后续</a></li>'+
			'<li><a  id="redo"   seq="<%=seqno%>">重做当前</a></li>';
		}
		
		_tmpl+='<li><a  id="log"    seq="<%=seqno%>">查看日志</a></li>'+
		'<li><a  id="dura"   seq="<%=procName%>">时长分析</a></li>'+
		'<%}%>'+
		'<%if(value==6){%>'+
		'<li><a  id="redo"   seq="<%=seqno%>">重做当前</a></li>'+
		'<li><a  id="conti"  seq="<%=seqno%>">重做后续</a></li>'+
		'<li><a  id="log"   name="<%=procName%>"  seq="<%=seqno%>">查看日志</a></li>'+
		'<li><a  id="dura"   seq="<%=procName%>">时长分析</a></li>'+
		'<%}%>'+
		'<%if(value==1||value==2||value==3){%>'+
		'<li class="dropdown-submenu">'+
        '<a tabindex="-1" href="javascript:;">设置优先级</a>'+
        '<ul class="dropdown-menu" >'+
            '<li class="'+'<%=(priLevel==20?"active":"")%>">'+'<a id="setPLevel" name="20" seq="<%=seqno%>" href="javascript:;">'+'<span class="glyphicon glyphicon-ok <%=priLevel==20?"":"hide"%>"></span>'+' 高（20）</a></li>'+
            '<li class="'+'<%=(priLevel>14&&priLevel<20?"active":"")%>">'+'<a id="setPLevel" name="15" seq="<%=seqno%>" href="javascript:;">'+'<span class="glyphicon glyphicon-ok <%=priLevel>14&&priLevel<20?"":"hide"%>"></span>'+' 高于正常（15）</a></li>'+
            '<li class="'+'<%=(priLevel>9&&priLevel<15?"active":"")%>">'+'<a id="setPLevel" name="10" seq="<%=seqno%>" href="javascript:;">'+'<span class="glyphicon glyphicon-ok <%=priLevel>9&&priLevel<15?"":"hide"%>"></span>'+' 正常（10）</a></li>'+
            '<li class="'+'<%=(priLevel>5&&priLevel<10?"active":"")%>">'+'<a id="setPLevel" name="5" seq="<%=seqno%>" href="javascript:;">'+'<span class="glyphicon glyphicon-ok <%=priLevel>5&&priLevel<10?"":"hide"%>"></span>'+' 低于正常（5）</a></li>'+
            '<li class="'+'<%=priLevel<5?"active":""%>">'+'<a id="setPLevel" name="1" seq="<%=seqno%>" href="javascript:;">'+'<span class="glyphicon glyphicon-ok <%=priLevel<5?"":"hide"%>"></span>'+' 低（1）</a></li>'+
        '</ul></li>'+
		'<%}%>'+
		'<%if(value==8){%>'+
		'<li><a id="goon" seq="<%=seqno%>" task_status="<%=task_status%>">恢复任务</a></li>'+
		'<%}%>'+
		'</ul><%}else{%>'+
		'</button>'+
		'<%}%>'+
		'</div>';
	return _.template(_tmpl,{"cla":_CLASS[value-1],"name":_VALUE[value-1],"value":value,"seqno":data.SEQNO,"priLevel":data.PRI_LEVEL,"procName":data.PROC_NAME,"task_status":data.TASK_STATE,"agent":data.AGENT_CODE,"errorCode":data.ERRCODE,"returnCode":data.RETURN_CODE});
};
var runFreqRender = function(value,data,index){
	var res="未知";
	switch(value){
		case "year":
			res="年"
			break;
		case "month":
			res="月"
			break;
		case "day":
			res="日"
			break;
		case "hour":
			res="小时"
			break;
		case "minute":
			res="分钟"
			break;
		default:
			break;
	}
	return res;
};

var procNameRender = function(value,data,index){
	var res='<a href="#" style="text-decoration:underline;color:blue;" title="查看调度信息" onclick="showProcScheduleInfo(\''+value.trim()+'\')">'+ value +'</a>';
	return res;
};

var dateRender=function(value,data,index){
	//var _dateStr = value.substring(5);
	//return _dateStr;
	return value;
};

var getCurdutyer=function(){
	curdutyer=$("#curdutyer input").val();
	curdutyer = (curdutyer&&curdutyer.length>0)?curdutyer.trim():"";
	if(curdutyer.length>0){
       	condi =" AND (b.curdutyer like '%"+curdutyer+"%' ) " ;
       	return condi;
	}else{
		return "";
	}
};
//左边树   
var buildTreeView = function(sql){
	    exportSql=sql;
		$('#treeview6').treeview({
			color: "#428bca",
			expandIcon: "glyphicon glyphicon-chevron-right",
			collapseIcon: "glyphicon glyphicon-chevron-down",
			nodeIcon: "glyphicon glyphicon-tasks",
			showTags: true,
			onNodeSelected:function(event,node){
				g_tvNode = node;
				var strArray=node.id.split(">");
				var where="";
				for(var i=0;i<strArray.length;i++){
					var str =strArray[i];
					var subWhere=str.split(":")[0]+" = '"+str.split(":")[1]+"'";
					if(str.split(":")[1]=='未知') subWhere = str.split(":")[0] +" is null ";
					if(where) where += " and "+ subWhere
					else where=subWhere;
				}
				where = where.length>0?(" and "+where):"";//topic=xx level_val=xxx
				_contentStore.config.sql=_realSql.replace("{}",getQuerCondi()).replace("{condi}",where+getCurdutyer());
				_contentStore.fetch();
				exportSql=_contentStore.config.sql;
			},
			groupfield:"TOPICNAME,LEVEL_VAL",//SCHEMA_NAME,TABSPACE,
			titlefield:"MODELNAME",
			iconfield:"",
			sql:sql,
			dataSource:"METADB",
			subtype: 'grouptree',
			renderer:function(text){
				var res="";
				switch(text){
					case -1:
					case -2:
					case -3:
					case -4:
					case -5:
					case -6:
					case -7:
						res="挂起";
						break;
					case 7:
						res="未触发";
						break;
					case 0:
					case 1:
					case 2:
					case 3:
						res="排队等待";
						break;
					case 4:
					case 5:
						res="正在运行";
						break;
					case 6:
						res="执行成功";
						break;
					default:
						if(isNaN(text))
							switch(text){
								case "day":
									res="日";
									break;
								case "month":
									res="月";
									break;
								case "hour":
									res="时";
									break;
								case "year":
									res="年";
									break;
								case "minute":
									res="分";
									break;
								default:
									res="未知";
						}else if(text>50){
							res="运行失败";
						}else{
							res="未知";
						}
						break;
				}
				return res;
			}
		});
};
var switchContent = function(condi){
	if(!condi||typeof(condi)=="undefined"){
		condi="";
	}
	buildTreeView(_realTreeSql.replace("{}",condi));
	_contentStore.config.sql=_realSql.replace("{}",condi);
	_contentStore.fetch();
	_totalStore.config.sql = _realTotalSql.replace("{}",condi);
	_totalStore.fetch();
	exportSql=_contentStore.config.sql;
};
var switchContent2 = function(condi,condi2){
	if(!condi||typeof(condi)=="undefined"){
		condi="";
	}
	buildTreeView(_realTreeSql.replace("{}",condi));
	_contentStore.config.sql=_realSql.replace("{}",condi);
	_contentStore.fetch();
	exportSql=_contentStore.config.sql;
	_totalStore.config.sql = _realTotalSql.replace("{}",condi2);
	_totalStore.fetch();
};
//统计面板
var _totalPanel = new ve.HtmlWidget({
	config:{
		"className": "html",
		"id": "view_total_up_total_id",
		"template":'<div class="total_line row"><div class="total_run col-sm-2"><div class="total_1 ">任务运行概况</div><div id="total_2" class="total_2 "><%=curDate%></div></div>'//<div class="detail_0 col-sm-2">'
			       + '<div class="total_detail col-sm-10">'
			       + '<div class="detail_1"><label class="total_label_1"><%=finishRate%>%</label><div><label class="sm-detail">运行成功率</label></div></div>'
			       + '<div class="detail_2"><label class="total_label_2 detail_label" id="2"><%=total%></label><div><label class="sm-detail">总程序数</label></div></div>'
			       + '<div class="detail_3"><label class="total_label_3 detail_label" id="6"><%=finish%></label><div><label class="sm-detail">执行成功</label></div></div>'
			       + '<div class="detail_4"><label class="total_label_4 detail_label" id="7"><%=fail%></label><div><label class="sm-detail">执行失败</label></div></div>'
			       + '<div class="detail_5"><label class="total_label_5 detail_label" id="5"><%=running%></label><div><label class="sm-detail">正在执行</label></div></div>'
			       + '<div class="detail_6"><label class="total_label_6 detail_label" id="4"><%=queue%></label><div><label class="sm-detail">排队等待</label></div></div>'
			       + '<div class="detail_7"><label class="total_label_7 detail_label" id="8"><%=unqueue%></label><div><label class="sm-detail">未触发</label></div></div>'
			       + '</div></div>',
		"events":{
			afterRender:function(){
				var _view = this;
				var clock = function(){
					var curDate = $("#date_args input").val();
				
			  		var finish = _totalStore.models[0].get("FINISH");
			  		var fail =    _totalStore.models[0].get("FAIL");
			  		var running = _totalStore.models[0].get("RUNNING");
			  		var unqueue= _totalStore.models[0].get("UNQUEUE");
			  		var queue = _totalStore.models[0].get("QUEUE");
			  		var total = _totalStore.models[0].get("TOTAL");
			  		var finish = finish==undefined||finish==null?0:finish;
			  		var fail = fail==undefined||fail==null?0:fail;
			  		var running = running==undefined||running==null?0:running;
			  		var queue = queue==undefined||queue==null?0:queue;
			  		var unqueue = unqueue==undefined||unqueue==null?0:unqueue;
			  		var finishRate = (finish*100/(total==0?1:total)).toFixed(2);
			  		_view.$el.addClass('info-general').empty().append(_.template(_view.config.template,{'curDate':curDate,'finishRate':finishRate,'total':total,'finish':finish,'fail':fail,'running':running,'queue':queue,'unqueue':unqueue}));
			  		_view.$el.find("div[class*='detail_']").on('click',function(e){
			  			var _id = $(e.currentTarget).find(".detail_label").attr("id");
			  			$(e.currentTarget).css("cursor","pointer");
			  			choose_state = $(e.currentTarget).attr("class");
				  		$("#task_state_select select").val(_id);
				  		$("#task_state_select select").trigger("change");
			  		});
				};
				clock();
				if(choose_state) $("."+choose_state).css("border","2px solid blue")
			}
		}
	}
});
//查询面板
var _queryPanel = new ve.FormWidget({
	config:{
		"class":"form",
		"formClass":"form-inline",
		"id": "view_total_up_total_tab_nav",
		"noJustfiyFilter":"on",
		"items": [
			{
				"type":"combox",
				"id":"task_state_select",
				"fieldLabel":"状态",
				"select":[{'key':'2','value':'全部状态'},{'key':'4','value':'排队等待'},{'key':'5','value':'正在运行'},{'key':'6','value':'执行成功'},{'key':'7','value':'执行失败'},{'key':'8','value':'未触发'}],
			    "style": "min-width:60px;width:95px;"
			},
			{
				"type":"combox",
				"fieldLabel":"周期",
				"id":"run_freq_select",
				"select":${cycleList},
				"style": "min-width:60px;width:65px;"
			},
			// {
			// 	"type":"combox",
			// 	"id":"task_proc_type",
			// 	"fieldLabel":"调度",
			// 	"select":[{'key':'0','value':'调度'},{'key':'1','value':'KPI'}],
			//     "style": "min-width:60px;width:95px;"
			// },
			{
				"type":"combox",
				"fieldLabel":"Agent",
				"id":"agent_code_select",
				"select":${agentList},
				"style": "min-width:80px;width:100px;"
			},
			
			{
				"type": "text",
				"id":"date_args",
				"fieldLabel":"批次",
				"placeholder":"日期参数",
				"format" : "yyyy-mm-dd",
				//"sql":"SELECT CURDATE() AS DEFVAL FROM metauser GROUP BY DEFVAL",
				"style": "min-width:80px;width:100px;"
			},
			{
				"type": "timebetween",
				"id":"timebetween",
				"startTimeId":"start_time",
				"endTimeId":"end_time",
				"fieldLabel":"时间范围",
				"placeholder":"时间范围",
				"format" : "yyyy-mm-dd",
				//"sql":"SELECT CURDATE() AS DEFVAL FROM metauser GROUP BY DEFVAL",
				"style": "min-width:60px;width:80px;"
			},
			{
				"type": "text",
				"id":"proc_name",
				"fieldLabel":"",
				"placeholder":"程序名称",
				"style": "min-width:80px;width:120px;"
			},
			{
				"type": "text",
				"id":"curdutyer",
				"fieldLabel":"",
				"placeholder":"当前责任人",
				"style": "min-width:80px;width:120px;"
			},
			{
				"id":"search",
				"value":"查询",
				"type":"button",
				"className":"search_btn btn-sm btn-primary",
			},/*{
				"id":"refresh-grid",
				"value":"",
				"type":"button",
				"className":"search_btn btn-sm btn-primary",
			},
			{
				"id":"refresh-btn",
				"value":"",
				"type":"button",
				"className":"btn btn-sm btn-primary hide",
			}*/,
			{
				"id":"switch-mode",
				"value":"",
				"type":"button",
				"className":"search_btn btn-sm btn-primary",
			},
			{
				"id":"redo_cur",
				"value":"批量重做当前",
				"type":"button",
				"className":"search_btn btn-sm btn-warning",
			},
			{
				"id":"redo_after",
				"value":"批量重做后续",
				"type":"button",
				"className":"search_btn btn-sm btn-danger",
			}
		],
		'events': {
			afterRender:function(){
				var _view = this;
				_view.$el.find('form').addClass('form_personal');
				//_view.$el.css("padding","5px");
				_view.$el.css("padding","2px 2px 2px 20px");
				_view.$el.find("#switch-mode").empty().append(
						'<div class="btn-group" data-toggle="buttons" style="margin-right: 2px;">'+
						'<label id="m-simple" class="btn btn-sm btn-info active">'+
						'<input type="radio" name="options">'+
						'<i class="fa fa-check text-active" ></i>去重</label>'+
						'<label id="m-all" class="btn btn-sm btn-success">'+
						'<input type="radio" name="options">'+
						'<i class="fa fa-check text-active"></i>全量</label>'+
						'</div>'
				);
				//_view.$el.find("#task_state_select").hide();
				_view.$el.find("#agent_code_select").after("<br />").css("xmargin-bottom","5px");
				$(".ui-layout-center").css("top","135px")
				$(".ui-layout-west").css("top","135px")
				/*_view.$el.find("#refresh-grid").empty().append(
					'<div class="btn-group" data-toggle="buttons" style="margin-right: 5px;">'+
					'<label id="m-g" class="btn btn-sm btn-info">'+
					'<input type="radio" name="options">'+
					'<i class="fa fa-check text-active "></i> 实时刷新</label>'+
					'<label id="m-o" class="btn btn-sm btn-success">'+
					'<input type="radio" name="options">'+
					'<i class="fa fa-check text-active"></i> 手动刷新</label>'+
					'</div>');*/
				_view.$el.find("#refresh-btn button").append('<span class="glyphicon glyphicon-refresh"></span>');
				var _refresh = function(flag){
					if(flag){
						REFRESHTIMER = setTimeout(function(){
							_contentStore.fetch();
							_totalStore.fetch();
							_refresh(true);
						},10000);
					}else{
						clearTimeout(REFRESHTIMER);
					}
				};
				_view.$el.find("#m-all").on("click",function(e){
					
					_realSql = _finalQuerySql;
					_realTotalSql = _finalTotalSql;
					_realTreeSql = _treeSql;
				});
				_view.$el.find("#m-simple").on("click",function(e){
					
					_realSql = finalQuerySql;
					_realTotalSql = finalTotalSql;
					_realTreeSql = treeSql;
			   });
				/*_view.$el.find("#m-g").on("click",function(e){
					_view.$el.find("#refresh-btn button").addClass("hide");
					_refresh(true);
				});
				_view.$el.find("#m-o").on("click",function(e){
					_view.$el.find("#refresh-btn button").removeClass("hide");
					_refresh(false);
				});*/
			},
			'change #agent_code_select select':function(e){
				agent_code = $(e.currentTarget).val();
				switchContent(getQuerCondi());
			},
			'change #run_freq_select select':function(e){
			    run_freq = $(e.currentTarget).val();
			    switchContent(getQuerCondi());
			},
			'change #task_state_select select':function(e){
				task_state = _status[$(e.currentTarget).val()];
				switchContent2(getQuerCondi(),getQuerCondi2());

			},
			// 'change #task_proc_type select':function(e){
			// 	task_type = _type[$(e.currentTarget).val()];
			// 	switchContent2(getQuerCondi(),getQuerCondi2());

			// },
			// 'click #search':function(){
			// 	switchContent(getQuerCondi());
		 //  		$("#task_proc_type select").trigger("change");
			// },
			'click #search':function(){
				switchContent(getQuerCondi());
		  		$("#task_state_select select").trigger("change");
			},
			'click #refresh-btn':function(){
				switchContent(getQuerCondi());
			},//批量重做当前
			'click #redo_cur':function(){
				var selected = _grid.getCheckedRows();
				if(selected.length==0){
					alert("至少选中一个可重做项");					
				}else{
					if(confirm("确定所选项都要重做当前吗？")){
						redoProc("cur",selected);						
						//刷新版面
						switchContent(getQuerCondi());
					}
				}
			},//批量重做后续
			'click #redo_after':function(){
				var selected = _grid.getCheckedRows();
				if(selected.length==0){
					alert("至少选中一个可重做项");					
				}else{
					if(confirm("确定所选项都要重做后续吗？")){
						redoProc("after",selected);
						//刷新版面
						switchContent(getQuerCondi());
					}
				}
			},//导出查询的数据为EXCEl的格式
			'click #export-to-excel':function(){
				var header = [{"label":'程序名称',"dataIndex":"PROC_NAME"},{"label":'周期',"dataIndex":"RUN_FREQ"},{"label":'Agent',"dataIndex":"AGENT_CODE"},{"label":'状态',"dataIndex":"TASK_STATE"},{"label":'当前责任人',"dataIndex":"CURDUTYER"},{"label":'创建时间',"dataIndex":"START_TIME"},{"label":'开始执行时间',"dataIndex":"EXEC_TIME"},{"label":'执行结束时间',"dataIndex":"END_TIME"},{"label":'运行时长',"dataIndex":"DURATION"},{"label":'批次号',"dataIndex":"DATE_ARGS"}];
				var contextPath = location.pathname.split('/')[1]||'';
		        contextPath = '/'+contextPath+'/ve/download';
		        ve.DownloadHelper.download({
			    sql:exportSql,
			    dataSource:"METADB",
			    header:JSON.stringify(header),
			    url:contextPath,
			    fileName : "任务监控的查询结果",
			    fileType:'excel'
		        });
				
			}
		}
	}

});

//批量重做
function redoProc(type,data){
	var sql="";
	var deleteSql = "delete  from  PROC_SCHEDULE_META_LOG  where  seqno in ({seqnos})";
	if(type=="cur"){
		sql="update proc_schedule_log set task_state=0,trigger_flag=1,queue_flag=0,return_code=0,exec_time=NULL,end_time=NULL where seqno in ({seqnos})  and ( task_state >=50 or task_state=6 )";
	}else{
		sql="update proc_schedule_log set task_state=0,trigger_flag=0,return_code=0,queue_flag=0,exec_time=NULL,end_time=NULL where seqno in ({seqnos}) and ( task_state >=50 or task_state=6 )";
	}
	var seqnos="";
	for(var i=0;i<data.length;i++){
		if(data[i].get("TASK_STATE")>=6){
			//运行成功和运行失败方可重做
			seqnos +="'"+ data[i].get("SEQNO") +"',"
		}
	}
	//没有可重做返回 -1
	if(seqnos.length==0){
		return -1;
	}else{
		seqnos = seqnos.substring(0,seqnos.length-1);
		deleteSql=deleteSql.replace('{seqnos}',seqnos);
		sql = sql.replace('{seqnos}',seqnos);
		ai.executeSQL(deleteSql,false,"METADB");
		ai.executeSQL(sql,false,"METADB");
		return 0;
	}
}

function showProcScheduleInfo(procName){
	$("#upsertForm").empty();
	var sql="SELECT b.proc_name,b.creater,a.platform,a.agent_code,a.trigger_type,a.eff_time,a.exp_time,a.cron_exp,a.muti_run_flag,a.date_args,a.pri_level FROM proc_schedule_info a RIGHT JOIN proc b on a.proc_name = b.proc_name where b.proc_name ='" + procName + "'";
	ds_mydata=new AI.JsonStore({
		sql : sql,
		filter : 'proctype =1',
		selfield : '',
		key : "PROC_NAME",
		pageSize : 15,
		table : "PROC",
		dataSource:"METADB"
	});
	var formcfg = ({
		id : 'form',
		store : ds_mydata,
		containerId : 'upsertForm',
		items : [ 
			{type : 'text',label : '程序名称',fieldName : 'PROC_NAME',isReadOnly:"y"},
			{type : 'date',label : '上线时间',fieldName : 'EFF_TIME',value:new Date().format('yyyy-mm-dd'),isReadOnly:"y"}, 
			{type : 'date',label : '下线时间',fieldName : 'EXP_TIME',isReadOnly:"y"},
			{type : 'text',label : '资源组',fieldName : 'PLATFORM',isReadOnly:"y"},
		    {type : 'text',label : 'AGENT',fieldName : 'AGENT_CODE',isReadOnly:"y"},
			{type : 'text',label : '优先级',fieldName : "PRI_LEVEL",isReadOnly:"y"}, 
			{type : 'radio-custom',label : '运行模式',fieldName : 'MUTI_RUN_FLAG',storesql:'0,顺序启动|1,多重启动|2,唯一启动',isReadOnly:"y"},
			{type:  "radio-custom", label: "触发类型", fieldName: "TRIGGER_TYPE",storesql:'0,时间触发|1,事件触发',isReadOnly:"y"},
			{type : 'text',label : 'cron表达式',fieldName : 'CRON_EXP',isReadOnly:"y"}, 
			{type : 'text',label : '日期偏移量',fieldName : 'DATE_ARGS',isReadOnly:"y"}
		],
		
	});

	var from = new AI.Form(formcfg);
	var x = document.getElementsByName('TRIGGER_TYPE');
       for (var j = 0; j < x.length; j++) {
           if (x[j].checked) {
           	if(j == '0'){
           		$("#CRON_EXP").parent().parent().show();
        		$("#DATE_ARGS").parent().parent().show();
           	}else{
           		$("#CRON_EXP").parent().parent().hide();
        		$("#DATE_ARGS").parent().parent().hide();
           	}
           }
       }
	$("#dialog-ok").hide();
	$(".modal-title").html("查看调度信息");
	$('#myModal').css("z-index",99999)
    $('#myModal').modal({
		show : true,
		backdrop:false
	});
}

var _grid = new ve.GridWidget({
	config:{//start-config
		"className":"grid",
		'id':'evaluateView_tab_evaluate_middle_down_grid',
		'showcheck': true,
		'pageSize':30,
		"header":[
			{"label":"程序名称","dataIndex":"PROC_NAME","className":"ai-grid-body-td-left",renderer:procNameRender},
			{"label":"周期","dataIndex":"RUN_FREQ","className":"ai-grid-body-td-left",renderer:runFreqRender},
			{"label":"Agent","dataIndex":"AGENT_CODE"},
			{"label":"状态","dataIndex":"TASK_STATE","className":"ai-grid-body-td-left",renderer:_stateIcon},
			//{"label":"优先级","dataIndex":"PRI_LEVEL"},
			{"label":"当前责任人","dataIndex":"CURDUTYER"},
			{"label":"创建时间","dataIndex":"START_TIME"},
			{"label":"开始执行时间","dataIndex":"EXEC_TIME"},
			{"label":"执行结束时间","dataIndex":"END_TIME"},
			{"label":"运行时长"       ,"dataIndex":"DURATION",renderer:_timeDiffRender},
			//{"label":"自动重做次数","dataIndex":"RETRYNUM"},
			{"label":"批次号","dataIndex":"DATE_ARGS","className":"ai-grid-body-td-left",renderer:_argsRender}
		],
		"events":{
			afterRender:function(){
				var _view = this;
				_view.$el.find(".table-outer").css("overflow","visible");
			},
			rowClick:function(index,data){
				//alert(index)
			},
			rowDblClick:function(index,data,_view){
					var seqno=data.SEQNO;
					showDetail(seqno,"flow");
			},
			afterTabelBodyRender:function(){
				var _view = this;
				_view.$el.find(".table-area").css("overflow","visible");
				_view.$el.find("a#running-log").on("click",function(e){
					var seqno = $(e.currentTarget).attr("seq");
					var agentCode = $(e.currentTarget).attr("agent");
					var log = '';
					$.ajax({
						url:'/'+contextPath+'/syn/getLog?SEQNO='+seqno+'&AGENT_CODE='+agentCode+'&CMD=tail -n100 ',
						async:false,
						error:function(){     
						       alert('网络错误！');
						       return;
						    },
						success:function(msg){
							var msg = $.parseJSON(msg);
							if(msg.flag==true||msg.flag=="true"){
							     log = msg.response;
							}else{
								alert('获取运行日志失败');
								return;
							}
						}
					});
					var _store = new ve.SqlStore({
						sql:"select seqno,proc_name,start_time,task_state,retrynum,status_time from proc_schedule_log   where  seqno='"+seqno+"'",
						dataSource:"METADB"
					});
					_store.on("reset",function(store){
						var tmpl = '';
						if(store.models.length==1){
							var _taskState = store.models[0].get("TASK_STATE");
							var _title = _store.models[0].get("PROC_NAME").toUpperCase();
							_taskState = _taskState>=50?7:_taskState;
							_taskState = _taskState<0&&_taskState>=-3?8:_taskState;
							_taskState = _taskState==0?9:_taskState;
							_taskState = _taskState==-5?10:_taskState;
							_taskState = _taskState==-6?11:_taskState;
							tmpl = _.template(
								'<section class="panel panel-default">'
								+ '<header class="panel-heading"> 脚本运行日志</header> '
								+ '<article class="media" style="overflow:auto">'
								+ '<div class="media-body" style="margin:0px 40px 40px 40px;">'
								+ '<div class="pull-right media-xs text-center text-muted"> '
								+ '<strong class="h4"><%=retry%></strong> 次<br> <small class="label bg-gray text-xs">失败重做</small>'
								+ '</div>'
								+ '<h4><%=time%> <span class="label <%=cla%>"><%=name%></span> </h4>'
								+ '<small class="block"><span>日志内容：</span></small>'
								+ '<small class="block" ><pre style="white-space: pre-wrap;"><%=log%></pre></small>'
								+ '</div>'
								+ '</article>'
								+'</section>',
								{"cla":_CLASS[_taskState-1],"name":_VALUE[_taskState-1],"time":store.models[0].get("STATUS_TIME"),"log":log,"retry":store.models[0].get("RETRYNUM")});
						}else{
							tmpl = "找不到日志信息！";
						}
						parent.openTableInfo("log",_title,tmpl,true);
					},_view);
					_store.fetch();
				});




				_view.$el.find("a#log").on("click",function(e){
					var _seqno = $(e.currentTarget).attr("seq");
					showDetail(_seqno,this.id);
					
				});
              _view.$el.find("a#dura").on("click",function(e){
					var _procName = $(e.currentTarget).attr("seq");
					showDetail(_procName,this.id);
					
				});
	            _view.$el.find("a#relay").on("click",function(e){
					var _seqno = $(e.currentTarget).attr("seq");
					var _procName=$(e.currentTarget).attr("name");
					var _errCode = $(e.currentTarget).attr("err");
					var _status=$(e.currentTarget).attr("status");
					showDetail(_seqno,this.id);
				});
				_view.$el.find("a#force,a#pause,a#goon,a#redo,a#conti,a#pass,a#setPLevel,a#stop_drive,a#kill,a#contiError,a#redoError").on("click",function(e){
					var _seqno = $(e.currentTarget).attr("seq");
					var _workType = $(e.currentTarget).attr("id");
				    var task_status= $(e.currentTarget).attr("task_status");
				    var agent=$(e.currentTarget).attr("agent");
					//var _newLog = proc_log.getNewRecord();
					var return_code=$(e.currentTarget).attr("returncode");
					var finalSql="update proc_schedule_log  ";
					var execSql="";
					var res="";
					if(_workType=='pause'||_workType=='goon'){
						var alterStr = _workType=='pause'?"确定暂停程序?":"确定恢复程序?";
						if(confirm(alterStr)){
							execSql=finalSql + "set TASK_STATE='"+(0-task_status)+"' where seqno='"+_seqno+"' and  task_state='"+task_status+"'";
							res=ai.executeSQL(execSql,false,"METADB");
						}
					}else if(_workType=='setPLevel'){
						if(confirm("确定调整优先级?")){
						var _level = $(e.currentTarget).attr("name")
						execSql=finalSql +"set PRI_LEVEL='"+_level+"' where seqno='"+_seqno+"'  ";
						res=ai.executeSQL(execSql,false,"METADB");
						}
					}else if(_workType=='pass'){
						showDialog(_seqno);					
					}else if(_workType=='force'){
						//_log.set("TASK_STATE",2);
						if(confirm("确定强制执行?")){
							execSql=finalSql+" set TASK_STATE=2,trigger_flag=0,queue_flag=0 where seqno='"+_seqno+"' and (task_state=1 or task_state=-7)";
							res=ai.executeSQL(execSql,false,"METADB");
						}
					}else if (_workType=='contiError'||_workType=='redoError'){
						if(confirm("确定从第"+return_code+"步重做错误"+(_workType=='contiError'?"后续?":"当前?"))){
							var logStore = getValidStore(_seqno);
							if(!logStore) {
								alert("该批次已被重做，当前记录失效！")
								return;
							}

							var date = new Date();
							_dateStr=date.format("yyyy-mm-dd hh:mm:ss").substr(0,16);
							var sql1=" update proc_schedule_log set valid_flag=1,status_time='"+_dateStr+"' where seqno='"+_seqno+"' and ( task_state=6 or task_state>=50 ) ";
							var sql2=" update proc_schedule_script_log set app_log=CONCAT(app_log,'\\n \\n【前置任务重做，此任务失效】') where seqno='"+_seqno+"' ";
							ai.executeSQL(sql1,false,"METADB");
							ai.executeSQL(sql2,false,"METADB");

								$.ajax({ 
									url:'/'+contextPath+'/syn/getSeqNo',
									error:function(){     
									       alert('网络错误！');     
								    },
									success:function(msg){
										var newSeqNo = msg;
										if(newSeqNo){
											var newlog = logStore.getAt(0);
											newlog.set("SEQNO",msg);
											newlog.set("TASK_STATE",0);
											newlog.set("START_TIME",_dateStr)
											newlog.set("EXEC_TIME",null)
											newlog.set("END_TIME",null)
											newlog.set("STATUS_TIME",_dateStr);
											newlog.set("QUEUE_FLAG",0);
											newlog.set("TRIGGER_FLAG",_workType=="redoError"?1:0);
											newlog.set("VALID_FLAG",0);
											newlog.set("AGENT_CODE",newlog.data.AGENT_CODE);
											logStore.add(newlog);
											logStore.commit(false);
										}
									
								}
						  });
						}
					}else if(_workType=='stop_drive'){
						//_log.set("TASK_STATE",2);
						if(confirm("停止触发?")){
							execSql=finalSql+" set trigger_flag=1 where seqno='"+_seqno+"' and trigger_flag=1";
							res=ai.executeSQL(execSql,false,"METADB");
						}
					}else if(_workType=='kill'){
						//_log.set("TASK_STATE",2);
						if(confirm("停止任务?")){
							kill(_seqno,agent);
						}
					}else {
						if(confirm("确定重做?")){
							var logStore = getValidStore(_seqno);
							if(!logStore) {
								alert("该批次已被重做，当前记录失效！")
								return;
							}


							var date = new Date();
							_dateStr=date.format("yyyy-mm-dd hh:mm:ss").substr(0,16);
							var sql1=" update proc_schedule_log set valid_flag=1,status_time='"+_dateStr+"' where seqno='"+_seqno+"' and ( task_state=6 or task_state>=50 ) ";
							var sql2=" update proc_schedule_script_log set app_log=CONCAT(app_log,'\\n \\n【前置任务重做，此任务失效】') where seqno='"+_seqno+"' ";
							ai.executeSQL(sql1,false,"METADB");
							ai.executeSQL(sql2,false,"METADB");

							$.ajax({ 
								url:'/'+contextPath+'/syn/getSeqNo',
								error:function(){     
								       alert('网络错误！');     
							    },
								success:function(msg){
									var newSeqNo = msg;
									if(newSeqNo){
										var newlog = logStore.getAt(0);
										newlog.set("SEQNO",msg);
										newlog.set("TASK_STATE",0);
										newlog.set("START_TIME",_dateStr)
										newlog.set("EXEC_TIME",null)
										newlog.set("END_TIME",null)
										newlog.set("STATUS_TIME",_dateStr);
										newlog.set("QUEUE_FLAG",0);
										newlog.set("TRIGGER_FLAG",_workType=="redo"?1:0);
										newlog.set("VALID_FLAG",0);
										newlog.set("RETURN_CODE",0);
										newlog.set("AGENT_CODE",newlog.data.AGENT_CODE);
										logStore.add(newlog);
										logStore.commit(false);
									}
								}
							
						  });
						}
					}
					_contentStore.fetch();
				});
			}
	    }
  }//end-config
	
});
var choose_state="detail_2";
$(document).ready(function() {
	var toggleButtons = '<div class="btnCenter"></div>'
			+ '<div class="btnBoth"></div>'
			+ '<div class="btnWest"></div>';
	$('body').layout({
	    	sizable:						false
		,	animatePaneSizing:				true
		,	fxSpeed:						'slow'
		,	spacing_open:					0
		,	spacing_closed:					0
		,	west__spacing_closed:			8
		,	west__spacing_open:				8
		,	west__togglerLength_closed:		105
		,	west__togglerLength_open:		105
		,	west__togglerContent_closed:	toggleButtons
		,	west__togglerContent_open:		toggleButtons
		,	west__size:						205
		,	north__size: 					100
	});
	_totalPanel.$el=$("#totalPanel");
	_queryPanel.$el=$("#queryPanel");
	_queryPanel.render();
	_grid.$el=$("#tabpanel1");
	   // $("#tabpanel1").parent().css("height",($("#tabpanel1").parent().height()-30)+"px");
	var formater = new Date();
	var timestamp = formater.getTime();
	var defaultEndTime = formater.format("yyyy-mm-dd");
	formater.setDate(formater.getDate()-1); 
	var defaultDateArgs = formater.format("yyyy-mm-dd");
	formater.setDate(formater.getDate()-5);
	var defaultStartTime=formater.format("yyyy-mm-dd");
	//var _date='2015-01-05';
	var curTeamCode = paramMap['TEAM_CODE'];
	var date_args   = paramMap['DATE_ARGS'];
	var topic_name  = paramMap['TOPICNAME'];
	var run_freq    = paramMap['RUN_FREQ'];
	var proc_tpye  	= paramMap['PROCTYPE'];
	curTeamCodeCondi = (typeof(curTeamCode)=="undefined" || curTeamCode =='' || curTeamCode == 'undefined' || _UserInfo.username==='sys' )?(''):("  and team_code = '"+curTeamCode+"' ");
	curDateArgsCondi = (typeof(date_args)=="undefined" || date_args =='' || date_args == 'undefined' )?("and a.date_args like '"+defaultDateArgs+"%'"):("  and a.date_args like  '"+date_args+"%' ");
	curRunFreqCondi  = (typeof(run_freq)=="undefined" || run_freq =='' || run_freq == 'undefined' )?(''):("  and a.run_freq = '"+run_freq+"' ");
	curTopicNameCondi= (typeof(topic_name)=="undefined" || topic_name =='' || topic_name == 'undefined' )?(''):("  and topicname = '"+topic_name+"' ");
	// curProcTypeCondi= (typeof(proc_tpye)=="undefined" || proc_tpye =='' || proc_tpye == 'undefined' )?(''):("  and PROCTYPE = '"+proc_tpye+"' ");
	var _condi=" and '"+timestamp + "'='" + timestamp + "' and a.run_freq<>'manual' and task_state >=-7 ";
	_condi +=curTeamCodeCondi;
	_condi +=curDateArgsCondi;
	_condi +=curRunFreqCondi;
	_condi +=curTopicNameCondi;
	if((date_args&&date_args.lenth>0)||(topic_name&&topic_name.lenth>0)||(run_freq&&run_freq.lenth>0)){
		curDateStr=date_args;
		$("#date_args").val(date_args); 
		$("#queryPanel").hide();
	}else{
		_condi += " and start_time >= '" + defaultStartTime + " 00:00'";
		_condi += " and start_time <= '" + defaultEndTime + " 23:59'";
		$("#date_args input").val(defaultDateArgs);
		$("#start_time").val(defaultStartTime);
	    $("#end_time").val(defaultEndTime);
	}
    buildTreeView(_realTreeSql.replace("{}",_condi));
	_totalStore = new ve.SqlStore({
		sql:_realTotalSql.replace("{}",_condi),
		dataSource:"METADB"
	});
	_totalStore.on("reset",function(){
		_totalPanel.store=_totalStore;
		_totalPanel.store.fetched=true;
		_totalPanel.render();
	});
	$("#proc_name input").on("keydown",function(e){
		if(e.keyCode == 13){ 
			document.getElementById("search").click();
		} 
	})
	_totalStore.fetch();
	var execSql = _realSql.replace("{}",_condi);
	_contentStore=new ve.SqlStore({
		sql:execSql,
		dataSource:"METADB"
	});
	_contentStore.on("reset",function(){
		_grid.store=_contentStore;
		_grid.store.fetched=true;
		_grid.render();
		
		$(".btnCenter").hide();
		$(".btnBoth").hide();
		$(".btnWest").hide();
		if(_contentStore.length >0){
			$(".btnCenter").show();
			$(".btnBoth").show();
			$(".btnWest").show();
		}		
	});
	_contentStore.fetch();

//取消
$(".close-modal").on('click', function(){
   $('#myModal').modal('hide');
});	
	
});
function showDetail(seqno,op){
	window.open("monitorDialog?seqno="+seqno+"&op="+op);
}
function showDialog(seqno){	
	$("#dialog-ok").show();
	$(".modal-title").html("强制通过原因");
	$("#myModal").modal({
		show:true,
		backdrop:false
	});

	$("#upsertForm").empty();
	$("#dialog-ok").unbind("click");
	var _editPanel = new AI.Form({
		id: 'baseInfoForm',
		//store: tableStore,
		containerId: 'upsertForm',
		fieldChange: function(fieldName, newVal){},
		items: [
			{type : 'text', label : '通过原因', notNull: 'N', fieldName : 'PASS_REASON', width : 420 }
		]
	});
	
	//确定
	$("#dialog-ok").on('click', function(){
		if($("#PASS_REASON").val().trim()==""){
			alert("通过原因不能为空！")
			return false;
		}
		
		var sql= "update proc_schedule_log set TASK_STATE=6,QUEUE_FLAG=0,TRIGGER_FLAG=0 where seqno='"+seqno+"' and task_state<>6 ";
		ai.executeSQL(sql,false,"METADB");
		
		var sql1 ="select seqno from proc_schedule_script_log where seqno='"+seqno+"' ";
		var store1=ai.getStore(sql1,'METADB');
		var sql2="";
		if(store1&&store1.count>0){
			sql2=" update proc_schedule_script_log set app_log= CONCAT(app_log,'\\n\\n','【"+getNowTime()+"强制通过】,原因："+$("#PASS_REASON").val()+"') where seqno='"+seqno+"' ";
		}else{
			sql2=" insert into proc_schedule_script_log values('"+seqno+"',(select proc_name from proc_schedule_log where seqno='"+seqno+"'),'DEFAULT_FLOW','【"+getNowTime()+"强制通过】,原因："+$("#PASS_REASON").val()+"')"
		}			
		ai.executeSQL(sql2,false,"METADB");
        $('#myModal').modal('hide');
	});
	
	$("#myModal").modal({
		show:true,
		backdrop:false
	});
}

function getNowTime(){
	var d = new Date();
	var vYear = d.getFullYear();
	var vMon = d.getMonth() + 1;
	var vDay = d.getDate();
	var h = d.getHours();
	var m = d.getMinutes();
	var se = d.getSeconds();
	return vYear +"-"+(vMon<10 ? "0" + vMon : vMon)+"-"+(vDay<10 ? "0"+ vDay : vDay)+" "+(h<10 ? "0"+ h : h)+":"+(m<10 ? "0" + m : m)+":"+(se<10 ? "0" +se : se);
}

function getValidStore(seqno){
	var store = new AI.JsonStore({
		sql :"select * from proc_schedule_log where seqno='"+seqno+"' and valid_flag=0",
		table:'proc_schedule_log',
		key:"SEQNO",
		dataSource:"METADB"
	});
	if(store.count>0)return store;
	return null;
}	

</script>
</head>
<body class="">
	<div id="myModal" class="modal fade"> 
	   <div class="modal-dialog"> 
		   <div class="modal-content" > 
			   <div class="modal-header"> 
				   <button type="button" class="close close-modal" > <span aria-hidden="true">&times;</span><span class="sr-only">Close</span> </button> 
				   <h4 class="modal-title">强制通过原因</h4> 
			   </div> 
			   <div class="modal-body" id="upsertForm"></div> 
			   <div class="modal-footer"> 
				   <button id="dialog-cancel" type="button" class="btn btn-default close-modal" >取消</button> 
				   <button id="dialog-ok" type="button" class="btn btn-primary">通过</button> 
			   </div> 
		  </div>
	   </div>
	</div>
	
	<div class="ui-layout-north">
	   <div class="row breadcrumb" id="totalPanel" style="margin:5px 1px 1px 1px;padding:6px 0px;"></div>
	   <div  id="queryPanel"></div>
	</div>
	<div class="ui-layout-west" style="overflow:auto;">
		<div id="treeview6" class="test"></div>
	</div>
	<div class="ui-layout-center">
		<div id="tabpanel1"></div>
	</div>
</body>
</html>
﻿
