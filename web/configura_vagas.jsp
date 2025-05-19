<%@page import ="java.sql.Connection" %>
<%@page import ="java.sql.DriverManager" %>
<%@page import = "java.sql.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Configuração de Vagas</title>
        <link rel="icon" href="./images/Icon-tab.svg">
        <link rel="stylesheet" href="./style-vagas.css">
    </head>
    <body>
        <%
        // Conexão com o banco de dados
        try {
        Connection conecta;
        PreparedStatement st;
        ResultSet rs;
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/senai_autopark2";
        String user = "root";
        String password = "";

        conecta = DriverManager.getConnection(url, user, password);
        
        String sql= "SELECT COUNT(vagas.vagasid) AS capacidade FROM vagas";
        st = conecta.prepareStatement(sql);
        rs = st.executeQuery();

        int capacidade = 0;
        if (rs.next()) {
           capacidade = rs.getInt("capacidade");
        
        %>
        <main class="precos-container">        
        <div class="precos-title-container">
            <img src="./images/Logo-Senai-AutoPark.svg" alt="">
            <h1>Configuração de vagas</h1>
        </div>

        <form method="post" action="alterar_vagas.jsp">
            <h2>QTD. Vagas:  <%=capacidade%> </h2>

            <fieldset class="precos-form">
                <div class="input-box">
                    <img src="./images/Nº.svg" alt="">
                    <input type="number" placeholder="Nova capacidade" id="nova_capacidade" name="nova_capacidade" required>
                </div>
            </fieldset>

            <button class="btn-precos" type="submit">Alterar</button>
            
        </form>
        
          </main>
        <%
        }
        }catch (Exception x) {
         out.print("Erro: " + x.getMessage());
        }
        %>
          
    </body>
</html>
