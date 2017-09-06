<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>自定义表单</title>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript">
	function myfunction(element) {
		alert("您好！")
		var str = "<tr><td></td><td></td><td></td><td><input type=\"button\" name=\"modify\" value=\"修改\"><input type=\"button\" name=\"del\" value=\"删除\"><input type=\"button\"";
		str+="id=\"add_row\" value=\"增加\" onclick=\"myfunction(this)\"></td></tr>";
		alert(str); 
		$(element).parent("tr").append(str);
	}
	function add() {  
        var trObj = document.createElement("tr");  
        var trObj.innerHTML = "<tr><td></td><td></td><td></td><td><input type=\"button\" name=\"modify\" value=\"修改\"><input type=\"button\" name=\"del\" value=\"删除\"><input type=\"button\"";
        trObj.innerHTML+="id=\"add_row\" value=\"增加\" onclick=\"myfunction(this)\"></td></tr>";
        $(element).parent("tr").appendChild(trObj);  
    }  
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
						<option value="0">下拉框</option>
						<option value="1">文本框</option>
						<option value="2">输入框</option>
				</select></td>
				<td><input type="button" name="modify" value="修改"><input
					type="button" name="del" value="删除"> <input type="button"
					name="add_row" value="增加" onclick="myfunction(this)"></td>
			</tr>
		</table>
		<br> <input type="button" name="create_form" value="生成表单">
	</form>

</body>
</html>