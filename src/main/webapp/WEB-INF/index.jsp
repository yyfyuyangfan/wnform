<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>自定义表单</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/js/jquery.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="${APP_PATH}/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function myfunction() {
		var tab = document.getElementById("mytable"); //获得表格
		var colsNum = tab.rows.item(0).cells.length; //表格的列数
		//表格当前的行数 
		var num = document.getElementById("mytable").rows.length;
		var rownum = num;
		tab.insertRow(rownum);
		for (var i = 0; i < 3; i++) {
			tab.rows[rownum].insertCell(i);//插入列
			if (i == 0) {
				tab.rows[rownum].cells[i].innerHTML = '<input name="zname" type="text"/>';
			} else if (i == 1) {
				tab.rows[rownum].cells[i].innerHTML = '<input name="ename" type="text"/>';
			} else if (i == 2) {
				tab.rows[rownum].cells[i].innerHTML = "<select name=\"type\"><option value=\"2\">输入框</option><option value=\"1\">文本框</option><option value=\"0\">下拉框</option></select>";
			}
		}
		/* <input type=\"button\" name=\"modify\" value=\"修改\"> */
		tab.rows[rownum].insertCell(i);
		tab.rows[rownum].cells[i].innerHTML = '<td><input type=\"button\" name=\"del\" value=\"删除\" onclick=\"delRow(this)\"></td>';
	}
	function delRow(obj) {
		//var Row = obj.parentNode;
		var Row = obj.parentNode; //tr
		//alert(Row.tagName);
		while (Row.tagName.toLowerCase() != "tr") {
			Row = Row.parentNode;
		}
		Row.parentNode.removeChild(Row); //删除行
	}

	function createform() {
		var tab = document.getElementById("mytable"); //获得表格
		var rowsnum = tab.rows.length;
		//alert("rowsnum:" + rowsnum);
		var ename = "";
		var zname = "";
		var type = "";
		var json = "";
		var jsonstr = "";
		for (var i = 1; i < rowsnum; i++) {
		//	alert(i);
			//alert("rowsnum:" + rowsnum);
			for (var j = 0; j < 3; j++) {
				//alert("j:" + j);
				if (j == 2) {
					type = tab.getElementsByTagName("tr")[i]
							.getElementsByTagName("td")[j]
							.getElementsByTagName("select")[0].value;
					//alert("type"+type);
				} else if (j == 1) {
					ename = tab.getElementsByTagName("tr")[i]
							.getElementsByTagName("td")[j]
							.getElementsByTagName("input")[0].value;
				} else if (j == 0) {
					zname = tab.getElementsByTagName("tr")[i]
							.getElementsByTagName("td")[j]
							.getElementsByTagName("input")[0].value;
				}
			}
			/*  json = zname + "." + ename + "." + type + ",";
			jsonstr += json; */ 
		
			json="\""+ i+"\":{\"zname\":\"";
			json+=zname;
			//alert("json:"+json); 
			json+=",\"ename\":\"";
			json+=ename;
			json+="\",\"type\":\"";
			json+=type;
			json+="\"},";
			jsonstr += json;
		}
		//alert(jsonstr.length-1);
		jsonstr = jsonstr.substring(0, jsonstr.length - 1);
		jsonstr="{"+jsonstr+"}";
		alert(jsonstr);
		return jsonstr;
	}
	$(function() {
		$("input#createform").click(function() {
			//alert("1231");
			 var arr = createform();
			 $.ajax({
			        type: "POST",
			        url: "RequestData.ashx",
			        contentType: "application/json; charset=utf-8",
			        data: JSON.stringify(arr),
			        dataType: "json",
			        success: function (message) {
			            if (message > 0) {
			                alert("请求已提交！我们会尽快与您取得联系");
			            }
			        },
			        error: function (message) {
			        	alert("请求提交失败");
			        }
			    });
			 /*var arr = createform().split(',');
			for(var i=0;i<arr.length;i++){
				var list=arr[i].split(".");
				arr[i]=list;
			}
			 for(var i=0;i<arr.length;i++){
				for(var j=0;j<arr[i].length;j++){
					alert(arr[i][j]);
				}
			} */
		});
	})
	/* //获取饱包含汉字的字符长度
	function strlength(str){
		return str.replace(/[\u0391-\uFFE5]/g,"aa").length;
	} */
	/* function myfunction(element) { 
	alert("您好！"+element); 
	   var trObj = document.createElement("tr");  
	   trObj.innerHTML = "<tr><td></td><td></td><td></td><td><input type=\"button\" name=\"modify\" value=\"修改\"><input type=\"button\" name=\"del\" value=\"删除\"><input type=\"button\"";
	   trObj.innerHTML+="id=\"add_row\" value=\"增加\" onclick=\"myfunction(this)\"></td></tr>";
	   element.parent("tr").appendto(trObj);  
	}   */
</script>
</head>
<body>
	<form>
		<table id="mytable" border="1">
			<tr>
				<th>名称</th>
				<th>字段名</th>
				<th>类型</th>
				<th>操作</th>
			</tr>
			<tr>
				<td><input type="text" name="zname" value=""></td>
				<td><input type="text" name="ename" value=""></td>
				<td><select name="type">
						<option value="2">输入框</option>
						<option value="1">文本框</option>
						<option value="0">下拉框</option>
				</select></td>
				<!--<input type="button" name="modify" value="修改">  -->
				<td><input type="button" name="del" value="删除"
					onclick="delRow(this)"></td>
			</tr>
		</table>
		<br> <input type="button" id="createform" value="生成表单"> <input
			type="button" name="add_row" value="增加" onclick="myfunction()">
	</form>

</body>
</html>