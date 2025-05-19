<%@page import ="java.sql.Connection" %>
<%@page import ="java.sql.DriverManager" %>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Configuração de Preços</title>
        <link rel="icon" href="./images/Icon-tab.svg">
        <link rel="stylesheet" href="./style-preco.css">
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
        
        String sql= "SELECT preco_hora FROM sistema";
        st = conecta.prepareStatement(sql);
        rs = st.executeQuery();
            
        double preco_hora = 0;

        if (rs.next()) {
           preco_hora = rs.getDouble("preco_hora");
        }
        %>
        
        <main class="precos-container">        
        <div class="precos-title-container">
            <img src="./images/Logo-Senai-AutoPark.svg" alt="">
            <h1>Configuração de preços</h1>
        </div>

        <form method="post" action="alterar_preco.jsp">
            <h2>Preço por hora: <%=preco_hora%> </h2>

            <fieldset class="precos-form">
                <div class="input-box">
                    <img src="./images/Dollar sign.svg" alt="">
                    <input type="number" placeholder="Novo preço" id="preco_hora" name="preco_hora" required>
                </div>
            </fieldset>
            <button class="btn-precos" type="submit">Alterar</button>
            <a class="btn-precos" type="submit">Voltar</a>
        </form>
        
    </main>
        
         <%  
        } catch (Exception x) {
          out.print("Erro: " + x.getMessage());   
        }  
         %>
    </body>
</html>
