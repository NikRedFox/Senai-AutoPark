<%@page import ="java.sql.Connection" %>
<%@page import ="java.sql.DriverManager" %>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Preço</title>
    </head>
    <body>
        <%
        //Recebendo o preço alterado do formulário
        double preco_hora;
        preco_hora = Double.parseDouble(request.getParameter("preco_hora"));
        
        try {
        // Conexão com o banco de dados
        Connection conecta;
        PreparedStatement st;
        ResultSet rs;
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/senai_autopark2";
        String user = "root";
        String password = "";

        conecta = DriverManager.getConnection(url, user, password);
        
        //Atualizando o preço no banco de dados
         String sql = "UPDATE sistema SET preco_hora=?";
         st = conecta.prepareStatement(sql); 
         st.setDouble(1, preco_hora);
         st.executeUpdate();
         
         out.print("O valor por hora do sistema foi alterado com sucesso!");
           
        } catch (Exception x) {
          out.print("Erro: " + x.getMessage());   
        }
        %>
    </body>
</html>
