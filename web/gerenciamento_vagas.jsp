<%@page import ="java.sql.Connection" %>
<%@page import ="java.sql.DriverManager" %>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gerenciamento de Vagas</title>
        <link rel="stylesheet" href="./style-geren-vagas.css">    
        <link rel="Icon" href="./images/Icon-tab.svg">
    </head>
    <body>
        <%
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
        
        //Consulta sql para verificar a quantidade de vagas que estão ocupadas
        String sqlOcupadas = "SELECT COUNT(vagas.vagasid) FROM vagas WHERE vaga_status = 'Ocupada';";
        
        st = conecta.prepareStatement(sqlOcupadas);
        rs = st.executeQuery();
        
        //Armazenando o resultado da consulta na variável vagas_ocupadas
        int vagas_ocupadas = 0;
        if (rs.next()) {
            vagas_ocupadas = rs.getInt(1);
        }
        
        //Encerrando a consulta
        rs.close();
        st.close();
        
        //Consulta sql para verificar a quantidade de vagas que estão disponíveis
        String sqlDisponiveis = "SELECT COUNT(vagas.vagasid) FROM vagas WHERE vaga_status = 'Disponível';";
        
        st = conecta.prepareStatement(sqlDisponiveis);
        rs = st.executeQuery();
        
        //Armazenando o resultado da consulta na variável vagas_disponiveis
        int vagas_disponiveis = 0;
        if (rs.next()) {
            vagas_disponiveis = rs.getInt(1);
        }

        %>
         <main>
        <div class="logo-container">
            <img src="./images/Logo-Senai-AutoPark.svg" alt="">
            <h1>Gerenciamento de vagas</h1>
        </div>

        <div class="vagas-container">
            <div class="vagas-text">
                <p>Vagas disponíveis</p>
                <p>Vagas ocupadas</p>
            </div>

            <div class="vagas-numbers">
                <p> <%=vagas_disponiveis %> </p>
                <div class="black-bar"></div>
                <p> <%=vagas_ocupadas %> </p>
            </div>

        </div>
        
        <div class="vagas-button">
            <a href="menu_admin.html">Voltar</a>
        </div>
    </main>
        <%
            } catch (Exception x) {
              out.print("Erro: " + x.getMessage());   
            }
                
        %>
        
    </body>
</html>
