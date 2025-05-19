<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Funcionários</title>
    </head>
    <body>
        <%
        
        //Recebendo os dados do formulário
        String usuario = request.getParameter("usuario");
        String email =request.getParameter("email");
        String senha = request.getParameter("senha");
        String nome_func = request.getParameter("nome_func");
        String cargo = request.getParameter("cargo");
        
        //Conexão com o banco de dados
        try {
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/senai_autopark2";
        String user="root";
        String password="";
         
        conecta=DriverManager.getConnection(url,user,password);
        
        //Inserindo os dados no banco de dados
        String sql=("INSERT INTO funcionarios (usuario, email, senha, nome_func, cargo) VALUES (?, ?, ?, ?, ?)");
        st=conecta.prepareStatement(sql);
        st.setString (1, usuario);
        st.setString (2, email);
        st.setString (3, senha);
        st.setString (4, nome_func);
        st.setString (5, cargo);
        
        st.executeUpdate();
        out.print("Funcionário cadastrado com sucesso!");
        
        } catch (Exception x) {
          out.print("Erro: " + x.getMessage());
        }

        %>
    </body>
</html>
