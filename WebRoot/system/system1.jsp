<%@ page language="java" import="java.util.*" pageEncoding="gb18030" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/" +"tab/";
%>
<% long order = 1;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���ݿ����</title>

<!---------------------------CSS��ʽ------------------------------>
<style type="text/css">	

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE1 {
	font-size: 12px
}
.STYLE3 {
	font-size: 12px;
	font-weight: bold;
}
.STYLE4 {
	color: #03515d;
	font-size: 12px;
}
.close {
	width: 50px;
	height: 30px;
	
	border-radius: 5px;
	line-height: 30px;
	position: absolute;

	margin-left: -8px;
	margin-top: -15px;
}
.close:hover {
	background: #008000;
	color: #FFFFFF;
}
.beautywords {
	font-size: 40px;
	font-family: ����Ҧ��;
	color: blue;
}
</style>



<!------------------------ Jquery 2015.7.12 -------------------->
<script type="text/javascript"
src="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.min.js">
</script>


<div style='display: none; position: absolute; left: 40%; top: 14%;'id='updateDoneDiv'>
	<span class="beautywords">��ԭ�ɹ�</span>
</div>
		
<div style='display: none; position: absolute; left: 40%; top: 14%;'id='delDoneDiv'>
	<span class="beautywords">ɾ���ɹ���</span>
</div>	
<div style='display: none; position: absolute; left: 40%; top: 14%;'id='addDoneDiv'>
	<span class="beautywords">���ݳɹ���</span>
</div>



<!---------------------------------Jquery end 2015.7.12---------------------------->

<!--------------------------------JavaScript����-------------------------------->
<script type="text/javascript" src="../js/WdatePicker.js"></script>
<script>		
var selectedId;//��ѡ�е�item
var doc=document;
/*���ǲ�����Ϣ����,ÿ����Ϣ��ı༭���ܵĵ��ú���,ʵ���޸Ĺ���*/
function openEdit(id){  
   
 
	var sysdmp=doc.getElementById("sysdmp"+id).innerHTML;
	var syslog=doc.getElementById("syslog"+id).innerHTML;

	doc.getElementsByName("sysdmpvalue")[0].value=sysdmp;
	doc.getElementsByName("syslogvalue")[0].value=syslog;
	var isSureEdited=confirm('ȷ��Ҫ��ԭ��');
    if(isSureEdited==true)
    {
	   document.getElementById("updateDoneDiv").style.display="";
	   var tip='document.getElementById("updateDoneDiv").style.display="none";'
	   setTimeout(tip,2000); 
	   var form=doc.forms("transform");  //��Ӧ��һ��table form
	   form.action="../servlet/System1_Reduction";
	   form.submit();
	   closeLogin();
   }
   else
   	   closeLogin();

}
//�ڱ�������ת����Xҳ
function jumpTo(){

	 var temp=document.getElementById('jump_to').value;
	 var count = <%=(Integer)session.getAttribute("pageCount")/15+((Integer)session.getAttribute("pageCount")%15!=0?1:0)%>
	 if(temp<=count && temp>0)
	  	window.location.href="../servlet/System1?jump_type=jump_to&to_page="+temp;
}
function closeLogin(){   
    document.getElementById("win").style.display="none";
}



//����
function backup()
{
	document.getElementById("addDoneDiv").style.display=""; 
	     var tip='document.getElementById("addDoneDiv").style.display="none";'
	     setTimeout(tip,2000); 
	     var addForm=doc.forms("transForm");   
	     addForm.action="../servlet/System1_Insert";
	     addForm.submit(); 

}
//ɾ��������Ŀ 2015.7.13
function delSingleItem(delId){ 
      
    var isSureDeled=confirm('ȷ��ҪҪɾ��������Ϣ��');
    if(isSureDeled){
	    var departKey=doc.getElementById("sysnum"+delId).innerHTML;    	  
	    doc.getElementsByName("delSolve")[0].value=departKey+'#';//��ȡkeyֵ    	   
	    for (i=1;i<sysTable.rows.length;i++){//����
	        sysTable.rows[i].cells[1].innerHTML=i;
	    }  //for
	      //submit
	    var form=doc.forms("transForm");       
	    form.action="../servlet/System1_Delete";
	    form.submit();   
    }//if         
}
//����ɾ������ 2015.7.13
function delBatItems(){ 

   var batBox=doc.getElementsByName("checkbox"); 
   var len=batBox.length;
   var rowIndex;
   var allKey="";
   for(i=0;i<len;i++)
   {
	    if(batBox[i].checked==true)
	    {   
	        var departKey = doc.getElementById("sysnum"+i).innerHTML;
	        allKey+=departKey+'#';
	    }  
   } 
   doc.getElementsByName("delSolve")[0].value=allKey;
   var keyform=doc.forms("transForm");   
   keyform.action="../servlet/System1_Delete";
   keyform.submit();  
}

</script>


<script>
var  highlightcolor='#c1ebff';
//�˴�clickcolorֻ����winϵͳ��ɫ������ܳɹ�,�����#xxxxxx�Ĵ���Ͳ���,��û�����Ϊʲô:(
var  clickcolor='#51b2f6';
function  changeto(){
	source=event.srcElement;
	if  (source.tagName=="TR"||source.tagName=="TABLE")
	return;
	while(source.tagName!="TD")
	source=source.parentElement;
	source=source.parentElement;
	cs  =  source.children;
	//alert(cs.length);
	if  (cs[1].style.backgroundColor!=highlightcolor&&source.id!="nc"&&cs[1].style.backgroundColor!=clickcolor)
		
		for(i=0;i<cs.length;i++){
			cs[i].style.backgroundColor=highlightcolor;
		}
	}
		
function  changeback(){
	
	if (event.fromElement.contains(event.toElement)||source.contains(event.toElement)||source.id=="nc")
		return
	if  (event.toElement!=source&&cs[1].style.backgroundColor!=clickcolor)
		//source.style.backgroundColor=originalcolor
	for(i=0;i<cs.length;i++){
		cs[i].style.backgroundColor="";
	}
}

function  clickto(){
	source=event.srcElement;
	if(source.tagName=="TR"||source.tagName=="TABLE")
		return;
	while(source.tagName!="TD")
	source=source.parentElement;
	source=source.parentElement;
	cs  =  source.children;
	//alert(cs.length);
	if(cs[1].style.backgroundColor!=clickcolor&&source.id!="nc")
		for(i=0;i<cs.length;i++){
			cs[i].style.backgroundColor=clickcolor;
		}
	else
		for(i=0;i<cs.length;i++){
			cs[i].style.backgroundColor="";
		}
}
//ȫѡ����  2015.7.12
var isSelected=1;
function clickall(){
   var el = document.getElementsByTagName('input'); 
   var len = el.length; 
   for(var i=0; i<len; i++) { 
	   if((el[i].type=="checkbox")) { 
	     if(isSelected==1)
	     el[i].checked = true;
	     else
	     el[i].checked = false;
	  } //if
	} //for
   isSelected++;
   isSelected=isSelected%2;
}

  
</script>
<!----------------------�޸��ɴ˿�ʼ ------------------------->
<style type="text/css">
table.gridtable {
	margin: auto;
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	color: #333333;
	border-color: #999999;
	border-collapse: collapse;
}
table.gridtable td {
	background: #b5cfd2 url('<%=basePath%>/images/tab_05.gif');
	border-width: 1px;
	border: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #999999;
}
table.gridtable td.tdbtn input {
	color: #d9eef7;
	border: solid 1px #0076a3;
	background: #0095cd;
	background: -webkit-gradient(linear, left top, left bottom, from(#00adee),
		to(#0078a5) );
	background: -moz-linear-gradient(top, #00adee, #0078a5);
	filter: progid :   DXImageTransform.Microsoft.gradient (   startColorstr
		= 
		 '#00adee', endColorstr =   '#0078a5' );
}
table.gridtable td.tdbtn input:hover {
	background: #007ead;
	background: -webkit-gradient(linear, left top, left bottom, from(#0095cc),
		to(#00678e) );
	background: -moz-linear-gradient(top, #0095cc, #00678e);
	filter: progid :   DXImageTransform.Microsoft.gradient (   startColorstr
		= 
		 '#0095cc', endColorstr =   '#00678e' );
}
table.gridtable td.tdbtn input:active {
	color: #80bed6;
	background: -webkit-gradient(linear, left top, left bottom, from(#0078a5),
		to(#00adee) );
	background: -moz-linear-gradient(top, #0078a5, #00adee);
	filter: progid :   DXImageTransform.Microsoft.gradient (   startColorstr
		= 
		 '#0078a5', endColorstr =   '#00adee' );
}
table.gridtable select {
	WIDTH: 150px�� position :   relative;
	left: -2px;
	top: -2px;
	font-size: 12px;
	line-height: 14px;
	border: 1px;
	color: #909993;
}
table.gridtable input[type=text] {
	border: 2px solid #F4F5F3;
	width: 150px;
	font-size: 16px;
	font-weight: bold;
	left: -2px;
	top: -2px;
	line-height: 14px;
	height: 14px;
}
.box1 {
	background: url('<%=basePath%>/images/tab_05.gif');
	height: 20px;
}
</style>

<style>
.optbtn {
	background-color: transparent; /* ����ɫ͸�� */
	border: 0px; /* �߿�ȡ�� */
	border-bottom: 1px solid #005aa7; /* �»���Ч�� */
}
::-moz-focus-inner {
	border: 0px;
}
</style>
</head>


<body>
<!-- ������  2015.7.13-->
<form name="transForm" method="post" action="">
	<input type="hidden" name="delSolve" value=""/>
	<input type="hidden" name="addSolve" value=""/>
	<input type="hidden" name="sysdmpvalue" value=""/>   
	<input type="hidden" name="syslogvalue" value=""/>   
   
	
</form>
<!-- ������ end -->

<div class="box1">&nbsp;
	<font size="2">�㵱ǰ��λ��:</font>
	<font color="blue" size=2pt>[ϵͳά��]-[���ݿ����]<br /> <br /> </font>
</div>
<br>
<form action="../servlet/System1_Select" method="post" name="queryform">
	<table  class="gridtable" width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<font size=2>&nbsp;&nbsp;��������:</font>
				<input type="text" id="datebegin" name="datebegin" onclick="WdatePicker()"></input>~
				<input type="text" id="dateend" name="dateend" onclick="WdatePicker()"></input>
			</td>
			<td width="50%"></td>
	
		</tr>

		<tr>
 			<td colspan="3"  align="right" class="tdbtn">
 			<input type="submit" id="btnAdd" value="��ѯ" class="buttonadd"></input>
  			<input type="button" id="btnAdd" value="����" class="buttonadd" onclick="backup()"></input>
  			<input type="button" id="btnAdd" value="ɾ��" class="buttonadd" onclick="delBatItems()"></input>
  			<input type="reset" id="btnAdd" value="����" class="buttonadd"></input>
  			</td>
		</tr>
	</table>
</form>
<br>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="8" background="<%=basePath%>/images/tab_12.gif">
									&nbsp;
								</td>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="1"
										bgcolor="b5d6e6" onmouseover="changeto()"
										onmouseout="changeback()" id="sysTable">
										<tr>
											<td width="5%" height="22" background="<%=basePath%>/images/bg.gif"
												bgcolor="#FFFFFF">
												<div align="center">
													<input type="checkbox" name="checkbox" value="checkbox"
														onclick="clickall()" />
													<span class="STYLE1">ȫѡ</span>
												</div>
											</td>
											<td width="5%" height="22" background="<%=basePath%>/images/bg.gif"
												bgcolor="#FFFFFF">
												<div align="center">
													<span class="STYLE1">���</span>
												</div>
											</td>
											<td width="10%" height="22" background="<%=basePath%>/images/bg.gif"
												bgcolor="#FFFFFF">
												<div align="center">
													<span class="STYLE1">���</span>
												</div>
											</td>
											<td width="20%" background="<%=basePath%>/images/bg.gif" bgcolor="#FFFFFF">
												<div align="center">
													<span class="STYLE1">�ļ���</span>
												</div>
											</td>
											<td width="20%" background="<%=basePath%>/images/bg.gif" bgcolor="#FFFFFF">
												<div align="center">
													<span class="STYLE1">��־�ļ�</span>
												</div>
											</td>
											<td width="20%" background="<%=basePath%>/images/bg.gif" bgcolor="#FFFFFF">
												<div align="center">
													<span class="STYLE1">��������</span>
												</div>
											</td>
											<td width="20%" height="22" background="<%=basePath%>/images/bg.gif"
												bgcolor="#FFFFFF" class="STYLE1">
												<div align="center">
													��������
												</div>
											</td>
										</tr>

										<!-- -ѭ����� -->
										<c:forEach items="${sys}" var="sys">
											<tr>
												<td height="20" bgcolor="#FFFFFF">
													<div align="center">
														<input type="checkbox" name="checkbox" value="checkbox" />
													</div>
												</td>
												<td height="20" bgcolor="#FFFFFF" align="center">
												<span class="STYLE1"><%=order%>											
												</td>
												<td height="20" bgcolor="#FFFFFF">
													<div align="center" >
														<span class="STYLE1" id="sysnum<%=order%>">${sys.sysnum}
														</span>
													</div>
												</td>
												<td bgcolor="#FFFFFF">
													<div align="center">
														<span class="STYLE1" id="sysdmp<%=order%>"><a href="http://127.0.0.1:8080/MyProject/upload/${sys.sysdmp}">${sys.sysdmp}</span>
													</div>
												</td>
												<td height="20" bgcolor="#FFFFFF">
													<div align="center">
														<span class="STYLE1" id="syslog<%=order%>"><a href="http://127.0.0.1:8080/MyProject/upload/${sys.syslog}">${sys.syslog}</span>
													</div>
												</td>
												<td height="20" bgcolor="#FFFFFF">
													<div align="center">
														<span class="STYLE1" id="sysdate<%=order%>">${sys.sysdate}</span>
													</div>
												</td>
												

												<td height="20" bgcolor="#FFFFFF" align="center">
													<img src="<%=basePath%>/images/edt.gif" />
													<button type="button" name="btnedit" id="btnedit<%=order %>"
														class="optbtn" onclick="openEdit(<%=order %>)">
														��ԭ
													</button>
													<img src="<%=basePath%>/images/del.gif" />
													<button type="button" name="btndel" id="btndel<%=order %>"
														class="optbtn" onclick="delSingleItem(<%=order++%>)">
														ɾ��
													</button>
												</td>
												


											</tr>
										</c:forEach>

									</table>
								</td>
								<td width="8" background="<%=basePath%>/images/tab_15.gif">
									&nbsp;
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="35" background="<%=basePath%>/images/tab_19.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="12" height="35">
									<img src="<%=basePath%>/images/tab_18.gif" width="12" height="35" />
								</td>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class="STYLE4">
												&nbsp;&nbsp;����<%=session.getAttribute("pageCount")%>����¼����ǰ�� <%=session.getAttribute("currentPage")%>/<%=(Integer)session.getAttribute("pageCount")/15+((Integer)session.getAttribute("pageCount")%15!=0?1:0)%>ҳ
											</td>
											<td>
												<table border="0" align="right" cellpadding="0" cellspacing="0">					  
													<tr>
														<td width="40">	
														<div align="center">
														<%
														      if(((Integer)session.getAttribute("currentPage")).intValue()!=0){												    	   
														    	  out.print("<a href=\"../servlet/System1?jump_type=first\">");
														      }												    
														%>										
														<img src="<%=basePath%>/images/first.gif" width="37" height="15"/></a></div>
														</td>
														
														<td width="45">													    
														    <div align="center">
														    <%
														        if(((Integer)session.getAttribute("currentPage")).intValue()>=2){												    	   
														    	    out.print("<a href=\"../servlet/System1?jump_type=back\">");
														    	}												    
														    %>														  
														    <img src="<%=basePath%>/images/back.gif" width="43" height="15" /></a></div>								
														</td>
														
														<td width="45">
														    <div align="center">
														   	<%
														     if(((Integer)session.getAttribute("currentPage")).intValue()<((Integer)session.getAttribute("pageCount")/15+((Integer)session.getAttribute("pageCount")%15!=0?1:0))){							    	    
														    	 out.print("<a href=\"../servlet/System1?jump_type=next\">");
														     }									  											    
														    %>													  													   	
															<img src="<%=basePath%>/images/next.gif" width="43" height="15" /></a></div>								
														</td>
																					
														<td width="40"><div align="center">
														<%
														     if(((Integer)session.getAttribute("currentPage")).intValue()!=0){												    	   
														    	 out.print("<a href=\"../servlet/System1?jump_type=last\">");
														     }												    
														%>										
														<img src="<%=basePath%>/images/last.gif" width="37" height="15" /></a></div>																							
														</td>
												
														<td width="100">
															<div align="center">
																<span class="STYLE1">ת���� <input name="textfield" id="jump_to"
																		type="text" size="4"
																		style="height: 12px; width: 20px; border: 1px solid #999999;" />
																	ҳ </span>
															</div>
														</td>
														<td width="40">
															<div align="center"><a href="javascript:jumpTo()" onclick="jumpTo()"><img src="<%=basePath%>/images/go.gif" width="37" height="15" /></a></div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<td width="16">
									<img src="<%=basePath%>/images/tab_20.gif" width="16" height="35" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
	</body>
</html>
