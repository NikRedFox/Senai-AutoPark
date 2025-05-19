<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterando Registro de Funcionário</title>
    </head>
    <body>
        <%
        //Recebendo os dados alterados do formulário
        int funcionarioid = Integer.parseInt(request.getParameter("funcionarioid"));
        String nome_func = request.getParameter("nome_func");
        String usuario = request.getParameter("usuario");
        String email =request.getParameter("email");
        String senha = request.getParameter("senha");
        String cargo = request.getParameter("cargo");
        
        //Conexão com o banco de dados
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/senai_autopark2";
        String user = "root";
        String password = "";
        
        conecta=DriverManager.getConnection(url,user,password);
        
        //Alterando no banco de dados
        String sql = ("UPDATE funcionarios SET usuario=?, email=?, senha=?,cargo=? WHERE funcionarioid=?");
        st = conecta.prepareStatement(sql);
           
        st.setString (1, usuario);
        st.setString (2, email);
        st.setString (3, senha);
        st.setString (4, cargo);
        st.setInt (5, funcionarioid);
        
        st.executeUpdate();
        out.print("O registro do funcionário " + nome_func + " foi alterado com sucesso");
        

        %>
    </body>
</html>
