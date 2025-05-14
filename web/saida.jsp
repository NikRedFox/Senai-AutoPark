<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String placa = request.getParameter("placa");
    boolean enviado = placa != null && !placa.trim().isEmpty();

    // Aqui você puxaria do banco horaEntrada, horaSaida e calculava preco...
    String horaEntrada = "06/04 12:00";
    String horaSaida   = "06/04 15:01";
    String preco       = "43,00";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="./style.css"> 
    </head>
    <body>
        <main>
            <!-- imagem e logo (sempre visíveis) -->
            <div class="side-image"> 
                <img src="E:\Senai\Backend-DB\Senai-AutoPark\src\pages\saida\src\assets\images\Car-background-saida" alt="alt"/>
            </div>

            <div class="content-container">
              <!-- Etapa 1: o formulário, só aparece quando NÃO enviou -->
              <section id="step1"
                       style="display: <%= enviado ? "none" : "block" %>;">
                <h1>Registro de Saída</h1>
                <form action="saida.jsp" method="post">
                  <input
                    type="text"
                    name="placa"
                    placeholder="LLLNNNN / LLLNNNN"
                    required
                    style="width:365px; height:40px;"
                  >
                  <button type="submit">Registrar Saída</button>
                </form>
              </section>

              <!-- Etapa 2: o cartão de resultado, só aparece quando JÁ enviou -->
              <section id="step2"
                       style="display: <%= enviado ? "block" : "none" %>;">
                <h1>Veículo de placa: <%= placa.toUpperCase() %></h1>
                <div class="result-card">
                  <p class="price-label">Preço Total</p>
                  <p class="price-value">R$ <%= preco %></p>
                  <div class="times">
                    <div>
                      <small>Hora de Entrada</small>
                      <p><%= horaEntrada %></p>
                    </div>
                    <div>
                      <small>Hora de Saída</small>
                      <p><%= horaSaida %></p>
                    </div>
                  </div>
                </div>
                <div class="payment-buttons">
                  <button>Dinheiro</button>
                  <button>Cartão Débito</button>
                </div>
              </section>
            </div>
        </main>

    </body>
</html>
