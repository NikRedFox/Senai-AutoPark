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
    String usuario = request.getParameter("usuario");
    String senha  = request.getParameter("senha");

    try {
         Connection conecta;
        
        PreparedStatement st; 
        Class.forName("com.mysql.cj.jdbc.Driver");
                
        String url = "jdbc:mysql://localhost:3306/senai_autopark2";
        String user="root";
        String password ="root";
            
        conecta = DriverManager.getConnection(url,user,password);
        
        String sql = "SELECT cargo FROM funcionarios WHERE usuario = ? AND senha = ?";
        
        st = conecta.prepareStatement(sql);
        st.setString(1, usuario);
        st.setString(2, senha);

        ResultSet rs = st.executeQuery();

        if (rs.next()) { 
            String cargo_banco = rs.getString("cargo");

            if (cargo_banco.equals("admin")) { 
                response.sendRedirect("configuracoes_sistema.html");
            } else {
                response.sendRedirect("error_validar_admin.html");
            }
                   } else {
            response.sendRedirect("error_validar_admin.html"); 
        }
        
        rs.close();
        st.close();
        conecta.close();

    } catch (Exception x) {
        response.sendRedirect("error_validar_admin.html");
    }
 
%>


    </body>
</html>