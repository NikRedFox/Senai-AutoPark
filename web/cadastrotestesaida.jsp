<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Duration" %>



<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Saída de Veículos</title>
        <link rel="stylesheet" href="./saida.css">
        <link rel="icon" href="./images/Icon-tab.svg">
    </head>
    <body>   


        <main class="main-container">
            <img src="./images/Car-background-saida.svg" alt="alt"/>
            <section class="saida-container" > 
                <section class="content-container">
                    <h1>Registro de Saída</h1>
                    <form action="cadastrotestesaida.jsp" method="post">
                        <div class="input-box">
                            <label for="placa">Informe a placa do veículo</label>
                            <input type="text" name="placa" placeholder="LLLNNN / LLL-NNNN" required>
                        </div>

                        <button type="submit">Registrar Saída</button>
                    </form>
                    <a href="./menu_admin.html">Voltar</a>
                </section>

                <%
                    String placa = request.getParameter("placa");
                    String formaPagamento = request.getParameter("forma_pagamento");
                    try {
                        Connection conecta;
                        PreparedStatement st;
                        ResultSet rs;
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/senai_autopark2", "root", "");

                        String sqlBusca = "SELECT data_entrada, horario_entrada, vagasid FROM carros WHERE placa = ? AND data_saida IS NULL";
                        st = conecta.prepareStatement(sqlBusca);
                        st.setString(1, placa);
                        rs = st.executeQuery();

                        if (rs.next()) {
                            java.sql.Date dataEntrada = rs.getDate("data_entrada");
                            java.sql.Time horarioEntrada = rs.getTime("horario_entrada");
                            int vagasId = rs.getInt("vagasid");

                            LocalDateTime entrada = LocalDateTime.of(dataEntrada.toLocalDate(), horarioEntrada.toLocalTime());
                            LocalDateTime saida = LocalDateTime.now();

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

                            String sqlAtualiza = "UPDATE carros SET data_saida = CURRENT_DATE, horario_saida = CURRENT_TIME, valor_total = ?, forma_pagamento = ? WHERE placa = ?";
                            st = conecta.prepareStatement(sqlAtualiza);
                            st.setDouble(1, valorTotal);
                            st.setString(2, formaPagamento);
                            st.setString(3, placa);
                            st.executeUpdate();

                            String sqlVaga = "UPDATE vagas SET vaga_status = 'Disponível' WHERE vagasid = ?";
                            st = conecta.prepareStatement(sqlVaga);
                            st.setInt(1, vagasId);
                            st.executeUpdate();
                %>

                <section class="cobranca-container">
                    <h2>Veículo de placa: <%= placa%></h2>
                    <div class="preco-box">
                        <p>Preço Total</p>
                        <h1>R$ <%= valorTotal%>,00</h1>

                        <div class="date-box">
                            <div class="date-card">
                                <div class="date-text">
                                    <p>Hora de Entrada</p>
                                    <div class="hour-box">
                                        <p><%= dataEntrada%> - <%= horarioEntrada%></p>
                                    </div>
                                </div>                        
                            </div>

                            <div class="date-card">
                                <div class="date-text" >
                                    <p>Hora de Saída</p>
                                    <div class="hour-box">
                                        <p><%= java.time.LocalTime.now().withNano(0)%></p>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>

                    <div class="botoes-pagamento">
                        <form method="post" action="cadastrotestesaida.jsp">
                            <input type="hidden" name="placa" value="<%= placa%>">
                            <input type="hidden" name="forma_pagamento" value="Dinheiro">
                            <button type="submit">Dinheiro</button>
                        </form>
                        <form method="post" action="cadastrotestesaida.jsp">
                            <input type="hidden" name="placa" value="<%= placa%>">
                            <input type="hidden" name="forma_pagamento" value="Cartão Débito">
                            <button type="submit">Cartão Débito</button>
                        </form>
                    </div>                   
                </section>
            </section>
            <%
                    }
                } catch (Exception e) {
                    out.println("Erro: " + e.getMessage());
                }
            %>

        </main>

    </body>
</html>


