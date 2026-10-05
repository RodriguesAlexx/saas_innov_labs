<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%
//aqui conexão com banco de dados
Connection conn = null;
Statement stmt = null;

//aqui no código é averiguado o acesso ao banco...
try {
	//aqui o uso do mysql e é praxe no java
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enterprise", "saas", "saas");

	String cpf = (String) request.getParameter("cpf");
	String id = (String) request.getParameter("id");

	String sql = "INSERT INTO equipeatendimento (cpfPK,dptoIdFK) VALUES ('"+ cpf +"',"+ id +")";
	
	stmt = conn.createStatement();
	stmt.executeUpdate(sql);	

	response.sendRedirect("searchFilled.jsp");

//aqui é acionado caso ocorra erro no acesso ao banco etc
} catch (Exception e) {	
	out.print((String) e.getMessage());
	//response.sendRedirect("erro/erro.jsp");
}%>
