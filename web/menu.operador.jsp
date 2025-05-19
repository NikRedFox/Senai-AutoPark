    <%@page import ="java.sql.Connection" %>
<%@page import ="java.sql.DriverManager" %>
<%@page import = "java.sql.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Principal</title><link rel="icon" href="./images/Icon-tab.svg">
        <link rel="stylesheet" href="./style-menu.css">
        
    </head>
    <body>
        <%
        String usuario = request.getParameter("usuario");
        String senha  = request.getParameter("senha");

        try {
        Connection conecta;
        
        PreparedStatement st; 
        Class.forName("com.mysql.cj.jdbc.Driver");
                
        String url = "jdbc:mysql://localhost:3306/senai_autopark2";
        String user="root";
        String password ="";
            
        conecta = DriverManager.getConnection(url,user,password);
        
        String sql = "SELECT cargo FROM funcionarios WHERE usuario = ? AND senha = ?";
        
        st = conecta.prepareStatement(sql);
        st.setString(1, usuario);
        st.setString(2, senha);

        ResultSet rs = st.executeQuery();
        
 if (rs.next()) { 
            String cargo_banco = rs.getString("cargo");

            if (cargo_banco.equals("operaodor")) { 
                %>



%>
        <main class="menu-container">
            <div class="menu-title-container">
                <img src="./images/Logo-Senai-AutoPark.svg" alt="">
                <h1>Bem vindo(a) <%=usuario%>!</h1>
            </div>
            <br>
            <div class="menu-button-row">
                <div class="btn-menu">                
                    <a href="cadastro_entrada.html">
                    <img src="./images/Icon-entrada.svg" alt="">
                    Entrada de veículos
                    </a> 
                </div>

                <div class="btn-menu">
                    <a href="cadastro_saida.html">
                    <img src="./images/Icon-saida.svg" alt="">
                    Saída de veículos
                    </a> 
                </div>
            </div>

            <div class="menu-button-row">
                <div class="btn-menu">                
                    <a href="gerenciamento_vagas.jsp">
                    <img src="./images/Icon-gerenciamento.svg" alt="">
                    Gerenciamento de vagas
                    </a> 
                </div>
                
                <div class="btn-menu">                
                    <a href="index.html">
                    <img src="./images/Icon-logout.svg" alt="">
                    Logout
                    </a> 
                </div>
                
            </div>
        </main> 
        <%
            }
                   } else {
            response.sendRedirect("error.html"); 
        }
        
        rs.close();
        st.close();
        conecta.close();

    } catch (Exception x) {
        //out.print("<p style='color:red;'>Erro: " + x.getMessage() + "</p>");
        response.sendRedirect("error.html");
    }
 
%>
    </body>
</html>
