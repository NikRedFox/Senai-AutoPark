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
  // Pegando as datas do formulário
            String dataInicio = request.getParameter("dataInicio");
            String dataFim = request.getParameter("dataFim");

            if (dataInicio != null && dataFim != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/senai_autopark2", "root", "");

  // Consulta SQL para somar os valores pagos no período
                    String sql = "SELECT SUM(valor_total) AS totalGanho FROM vagas WHERE data_saida BETWEEN ? AND ?";
                    PreparedStatement st = conecta.prepareStatement(sql);
                    st.setString(1, dataInicio);
                    st.setString(2, dataFim);

                    ResultSet rs = st.executeQuery();

                    if (rs.next()) {
                        double totalGanho = rs.getDouble("totalGanho");
        %>
        <div class="relatorio-container">
            <h2>Total ganho entre <%= dataInicio%> e <%= dataFim%>: R$ <%= String.format("%.2f", totalGanho)%></h2>
        </div>
        <%
                    } else {
                        out.println("<p>Nenhum dado encontrado para esse período.</p>");
                    }
                    rs.close();
                    st.close();
                    conecta.close();
                } catch (Exception e) {
                    out.println("Erro: " + e.getMessage());
                }
            }
        %>
    </body>
</html>
