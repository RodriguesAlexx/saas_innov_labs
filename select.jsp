<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%
//aqui conexão com banco de dados
Connection conn = null;
Statement stmt = null;
ResultSet rsEquipeAtendimento = null;

//aqui no código é averiguado o acesso ao banco...
try {
	//aqui o uso do mysql e é praxe no java
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enterprise", "saas", "saas");
	stmt = conn.createStatement();

	String nomeBusca = request.getParameter("nomeBusca");

	String sqlEquipeAtendimento = "SELECT primeiroNome, nome, ramal, telefone FROM departamento "+
		     "INNER JOIN equipeatendimento ON departamento.idPK = equipeatendimento.dptoIdFK "+
		     "INNER JOIN funcionario ON equipeatendimento.cpfPK = funcionario.cpfPK "+
			 "WHERE primeiroNome LIKE '%"+ nomeBusca +"%' ";
	rsEquipeAtendimento = stmt.executeQuery(sqlEquipeAtendimento);
%>


<html>
	<head>
		<title></title>
		<style>
			p {
				font-size: 18pt;
			}
			select {
				font-size: 16pt;
				color: green;
			}
			input {
 				font-size:16pt;
				color:green;
			}
		</style>
	</head>
	<body>

	<a href="searchFilled.jsp"><img src="imagens/button_insert.png" border="0"/></a>
	<a href="select.html"><img src="imagens/button_select.png" border="0"/></a>

	<form method="post" action="select.jsp">	
		<p>Funcionário
		<input type="text" size="20" name="nomeBusca" value="<%=nomeBusca%>"/>
		<input type="submit" value="Encontrar" style="color:black"/>
		</p>
	</form>

	<table border="1">
		<tr style="background-color: darkgrey;">
			<td><p>Funcionário</p></td><td><p>Departamento</p></td><td><p>Ramal</p></td><td><p>Telefone</p></td>
		</tr>		

	<% while (rsEquipeAtendimento.next()) { %>

		<tr>
			<td><p style="color:green"><%=rsEquipeAtendimento.getString("primeiroNome")%></p></td>
			<td><p><%=rsEquipeAtendimento.getString("nome")%></p></td>
			<td><p><%=rsEquipeAtendimento.getString("ramal")%></p></td>
			<td><p><%=rsEquipeAtendimento.getString("telefone")%></p></td>
		</tr>		

	<% } %>

	</table>

	</body>
</html>


<%
//aqui é acionado caso ocorra erro no acesso ao banco etc
} catch (Exception e) {	
	out.print((String) e.getMessage());
	//response.sendRedirect("erro/erro.jsp");
}%>
