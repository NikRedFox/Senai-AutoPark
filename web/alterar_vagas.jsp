<%@page import ="java.sql.Connection" %>
<%@page import ="java.sql.DriverManager" %>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
       //Recebendo do formulário a nova capacidade de vagas
        int nova_capacidade = Integer.parseInt(request.getParameter("nova_capacidade"));
        
        //Conexão com o banco de dados
        try {
        Connection conecta;
        PreparedStatement st;
        ResultSet rs;
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/senai_autopark2";
        String user = "root";
        String password = "";

        conecta = DriverManager.getConnection(url, user, password);
        
        //Recuperando a capacidade atual do estacionamento
        String sql= "SELECT COUNT(vagas.vagasid) AS capacidade FROM vagas";
        st = conecta.prepareStatement(sql);
        rs = st.executeQuery();

        int capacidade = 0;
        if (rs.next()) {
           capacidade = rs.getInt("capacidade");
        }
        
        //Alterando a capacidade do estacionamento
        //Deletando vagas do banco, caso a nova capacidade seja menor do que a capacidade atual
        if (nova_capacidade < capacidade) {
        String sqlAlterar = "DELETE FROM vagas WHERE numero_vaga > ?";
        st = conecta.prepareStatement(sqlAlterar); 
        st.setInt(1, nova_capacidade);
        st.executeUpdate();
        
        //Adicionando vagas no banco, caso a nova capacidade seja maior do que a capacidade atual
        } else if (nova_capacidade > capacidade) {
        for (int i = capacidade + 1; i <= nova_capacidade; i++) {
        String sqlAlterar = "INSERT INTO vagas (numero_vaga, vaga_status, capacidade) VALUES (?, 'Disponível', 1)";
        st = conecta.prepareStatement(sqlAlterar); 
        st.setInt(1, i);
        st.executeUpdate();
        } }
        out.print("A capacidade de vagas do estacionamento foi alterada com sucesso!");
        } catch (Exception x) {
          out.print("Erro: " + x.getMessage());   
        }
        
        %>
    </body>
</html>
