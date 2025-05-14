<%@page import ="java.sql.Connection"%>
<%@page import ="java.sql.DriverManager"%>
<%@page import ="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "java.sql.ResultSet"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Entrada de Veículo</title>
    </head>
    <body>
        
   <%
    // Captura os dados do formulário
    String placa = request.getParameter("placa");

    try {
        // Conexão com o banco de dados
        Connection conecta;
        PreparedStatement st;
        ResultSet rs;
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/senai_autopark2";
        String user = "root";
        String password = "root";

        conecta = DriverManager.getConnection(url, user, password);

        // Validação da placa
        placa = placa.trim().toUpperCase();
        boolean placaTamanho = placa.length() == 7;

        if (!placaTamanho) {
            out.print("Tamanho da placa inválido");
        } else {
            if (placa.matches("[A-Z]{3}[0-9]{4}|[A-Z]{3}[0-9]{1}[A-Z]{1}[0-9]{2}")) {
                out.print("Placa válida<br>");

                // **BUSCANDO UMA VAGA DISPONÍVEL**
                String sqlVaga = "SELECT vagasid FROM vagas WHERE vaga_status = 'Disponível' LIMIT 1";
                st = conecta.prepareStatement(sqlVaga);
                rs = st.executeQuery();

                if (rs.next()) {
                    int vagaId = rs.getInt("vagasid");

                    // **CADASTRANDO O CARRO COM A VAGA ENCONTRADA**
                    String sqlCarro = "INSERT INTO carros (placa, data_entrada, horario_entrada, vagasid) VALUES (?, CURRENT_DATE, CURRENT_TIME, ?)";
                    st = conecta.prepareStatement(sqlCarro);
                    st.setString(1, placa);
                    st.setInt(2, vagaId);
                    st.executeUpdate();

                    // **ATUALIZANDO STATUS DA VAGA PARA OCUPADA**
                    String sqlAtualizaVaga = "UPDATE vagas SET vaga_status = 'Ocupada' WHERE vagasid = ?";
                    st = conecta.prepareStatement(sqlAtualizaVaga);
                    st.setInt(1, vagaId);
                    st.executeUpdate();

                    out.print("Entrada do veículo cadastrada com sucesso! Vaga ID: " + vagaId);
                    out.print("<br> <a href='menu_admin.html'>Clique aqui para voltar ao menu</a>");
                } else {
                    out.print("Nenhuma vaga disponível.");
                    out.print("<br> <a href='menu_admin.html'>Voltar ao menu</a>");
                }
            } else {
                out.print("Placa inválida! O veículo não foi cadastrado.");
                out.print("<br> <a href='cadastro_entrada.html'>Tente novamente</a>");
            }
        }

        // Fechar conexão
        conecta.close();
    } catch (Exception x) {
        out.print("Erro: " + x.getMessage());
    }
%>


    </body>
</html>

        
    </body>
</html>
