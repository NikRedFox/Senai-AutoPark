<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Funcionário</title>
        <link rel="icon" href="./images/Icon-tab.svg">
        <link rel="stylesheet" href="./style-alterar-funcionario.css">
    </head>
    <body>
        <%
         //Recendo o id do funcionário inserido no formulário
         int funcionarioid = Integer.parseInt(request.getParameter("funcionarioid"));
         
         //Conexão com o banco de dados
         Connection conecta;
         PreparedStatement st;
         Class.forName("com.mysql.jdbc.Driver");
         String url="jdbc:mysql://localhost:3306/senai_autopark2";
         String user="root";
         String password="";
         
         conecta=DriverManager.getConnection(url,user,password);
         
        //Buscando o funcoinário pelo id recebido
         String sql=("SELECT * FROM funcionarios WHERE funcionarioid=?");
         st=conecta.prepareStatement(sql);

         st.setInt(1,funcionarioid);
         ResultSet resultado = st.executeQuery();
         
         //Verificando se o id informado foi encontrado
         if(!resultado.next()) {
         out.print("Este funcionário não foi localizado");
            } else {
        %>
        
        <main class="alterar-container">        
         <div class="alterar-title-container">
            <img src="./images/Logo-Senai-AutoPark.svg" alt="">
            <h1>Funcionário(a) <%=resultado.getString("nome_func")%> </h1>
        </div>

        <form method="post" action="alterar_funcionario.jsp">
            <fieldset class="alterar-form">
                <div class="input-box">
                    <input type="number" id="funcionarioid" name="funcionarioid" value="<%=resultado.getString("funcionarioid")%>" readonly>
                </div>
                <div class="input-box">
                    <img src="./images/icon-user.svg" alt="">
                    <input type="text" id="nome_func" name="nome_func" value="<%=resultado.getString("nome_func")%>" readonly>
                </div>
                <div class="input-box">
                    <img src="./images/icon-user.svg" alt="">
                    <input type="text" id="usuario" name="usuario" value="<%=resultado.getString("usuario")%>">
                </div>
                <div class="input-box">
                    <img src="./images/lock.svg" alt="">
                    <input type="text" id="senha" name="senha" value="<%=resultado.getString("senha")%>">
                </div>
                <div class="input-box">
                    <img src="./images/mail.svg" alt="">
                    <input type="email" id="email" name="email" value="<%=resultado.getString("email")%>">
                </div>
                <div class="input-box">
                    <img src="./images/Briefcase.svg" alt="">
                    <input type="text" id="cargo" name="cargo" value="<%=resultado.getString("cargo")%>">
                </div>                
                
            </fieldset>

            <button class="btn-alterar" type="submit">Alterar</button>            
        </form>
    </main>
        <%
            }  
        %>
    </body>
</html>
