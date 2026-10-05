<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%
//aqui conexão com banco de dados
Connection conn = null;
Statement stmt = null;
ResultSet rsFuncionario = null;
ResultSet rsDepartamento = null;

//aqui no código é averiguado o acesso ao banco...
try {
	//aqui o uso do mysql e é praxe no java
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enterprise", "saas", "saas");
	stmt = conn.createStatement();

	String sqlFuncionario = "SELECT cpfPK, primeiroNome, sobrenome FROM funcionario WHERE cpfPK NOT IN (SELECT cpfPK FROM equipeatendimento)";
	rsFuncionario = stmt.executeQuery(sqlFuncionario);
	String enabled = "enabled";
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
		</style>
	</head>
	<body>

	<a href="searchFilled.jsp"><img src="imagens/button_insert.png" border="0"/></a>
	<a href="select.html"><img src="imagens/button_select.png" border="0"/></a>

	<form method="get" action="insert.jsp">	
		<p>Funcionário <select name="cpf">

			<% int nr = 0;
			
			while (rsFuncionario.next()) { 
				nr += 1; %>

			<option value="<%=rsFuncionario.getString("cpfPK")%>">
				<%=rsFuncionario.getString("primeiroNome")%> <%=rsFuncionario.getString("sobrenome")%>
			</option>

			<% }
			if (nr == 0) 
				enabled = "disabled"; %>

			</select>

			<% String sqlDepartamento = "SELECT idPK, nome FROM departamento";
			rsDepartamento = stmt.executeQuery(sqlDepartamento); %>

		Departamento <select name="id">
		
			<% while (rsDepartamento.next()) { %>

			<option value="<%=rsDepartamento.getString("idPK")%>"><%=rsDepartamento.getString("nome")%></option>

			<% } %>

			</select>
		
		<input type="submit" value="Relacionar" style="font-size:16pt" <%=enabled%>/>
		</a>
	</form>

	</body>
</html>


<%
//aqui é acionado caso ocorra erro no acesso ao banco etc
} catch (Exception e) {	
	out.print((String) e.getMessage());
	//response.sendRedirect("erro/erro.jsp");
}%>
