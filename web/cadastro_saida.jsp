<%@page import ="java.sql.Connection"%>
<%@page import ="java.sql.DriverManager"%>
<%@page import ="java.sql.PreparedStatement"%>
<%@page import="java.time.*" %>
<%@page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Saída de Veículo</title>
    </head>
    <body>
       

   <%
    // Captura os dados do formulário
    String placa = request.getParameter("placa");
    String formaPagamento = request.getParameter("forma_pagamento");

    try {
        Connection conecta;
        PreparedStatement st;
        ResultSet rs;
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/senai_autopark2";
        String user = "root";
        String password = "";

        conecta = DriverManager.getConnection(url, user, password);

        // Buscando a data, horário de entrada e vaga do veículo
        String sqlBusca = "SELECT data_entrada, horario_entrada, vagasid FROM carros WHERE placa = ? AND data_saida IS NULL";
        st = conecta.prepareStatement(sqlBusca);
        st.setString(1, placa);
        rs = st.executeQuery();

        if (rs.next()) {
            // Obtendo dados do carro
            java.sql.Date dataEntrada = rs.getDate("data_entrada");
            java.sql.Time horarioEntrada = rs.getTime("horario_entrada");
            int vagasId = rs.getInt("vagasid"); // Pegando o ID da vaga usada

            // Convertendo para LocalDateTime para cálculo correto
            LocalDateTime entrada = LocalDateTime.of(dataEntrada.toLocalDate(), horarioEntrada.toLocalTime());
            LocalDateTime saida = LocalDateTime.now(); // Obtendo a saída atual

      // Caso fossemos cobrar por minuto
      
      
//            Duration duracao = Duration.between(entrada, saida);
//            long minutos = duracao.toMinutes(); // Calcula a diferença em minutos
//
//            double valorTotal;
//            if (minutos < 1) {
//                valorTotal = 0.00; // Se ficou menos de 1 minuto, não cobra nada
//            } else if (minutos <= 60) {
//                valorTotal = (minutos * (25.00 / 60)); // Cobrança proporcional dentro da primeira hora
//            } else {
//                valorTotal = 25.00 + ((minutos - 60) / 60) * 9; // Cobra R$ 9,00 por hora adicional completa
//            }

        //Cobrando por hora
               Duration duracao = Duration.between(entrada, saida);
            long minutos = duracao.toMinutes(); // Pegamos a diferença em minutos
            long horas = minutos / 60; // Convertendo para horas completas

            // Aplicando regras de cobrança
            int valorTotal;
            if (horas == 0) {
                valorTotal = 25; // Se ficou menos de 1 hora, cobra R$ 25,00
            } else {
                valorTotal = 25 + (int) ((horas) * 9); // Cobra R$ 9,00 por cada hora adicional
            }


            // Atualizamos  a saída do veículo no nosso banco de dados
            String sqlAtualiza = "UPDATE carros SET data_saida = CURRENT_DATE, horario_saida = CURRENT_TIME, valor_total = ?, forma_pagamento = ? WHERE placa = ?";
            st = conecta.prepareStatement(sqlAtualiza);
            st.setDouble(1,valorTotal);
            st.setString(2, formaPagamento);
            st.setString(3, placa);
            st.executeUpdate();

            // Aqui a gente atualiza a vaga que o carro estava usando para disponível no banco de dados
            String sqlVaga = "UPDATE vagas SET vaga_status = 'Disponível' WHERE vagasid = ?";
            st = conecta.prepareStatement(sqlVaga);
            st.setInt(1, vagasId); // Agora estamos recuperando o ID correto antes de atualizar
            st.executeUpdate();

            // Exibir informações ao usuário
            out.print("<h3>Saída do veículo registrada com sucesso!</h3>");
            out.print("<p>Tempo de permanência: " + minutos + " minutos</p>");
            out.print("<p>Valor total: R$ " + String.format("%.2f", valorTotal) + "</p>"); // Formatando corretamente o valor monetário
            out.print("<br> <a href='menu_admin.html'>Clique aqui para efetuar o pagamento</a>");
        } else {
            out.print("<p style='color:red;'>Veículo não está cadastrado ou já saiu.</p>");
        }

        conecta.close();
    } catch (Exception x) {
        out.print("<p style='color:red;'>Erro: " + x.getMessage() + "</p>");
    }
%>



    </body>
</html>

       
    </body>
</html>