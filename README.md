Um dos grandes desafios no setor de dados é a resolução de ticket internos e externos, esses tickets geralmente são bem desafiadores, segue a baixo uma lista de tickets para você resolver e se divertir:

**Ticket #1:**
  - Me chamo João e sou administrador da clínica Sempre Saúde. Gostaria da ajuda de vocês para bonificar meus médicos de forma justa, onde quem mais atendeu receberá uma porcentagem maior da bonificação. Para isso, gostaria de solicitar o ranking dos médicos que mais tiveram agendamentos atendidos no ano de 2023.

**Ticket #2:**
  - Pensando em aumentar nosso quadro médico com foco em aumentar nosso faturamento anual, solicitamos ajuda para nos mandarem o ranking dos procedimentos que mais geraram dinheiro para nossa clínica no ano de 2023.

**Ticket #3:**
  - Boa tarde, estamos em processo de planejamento estratégico para o próximo ano e pretendemos fazer alguns comparativos da parte financeira deste ano com a do ano anterior. Para isso, vamos precisar de uma tabela contendo as informações de quanto ganhamos ou deixamos de ganhar em receita/dinheiro em cada mês de 2023.

**Ticket #4:**
  - Pensando em melhorar os fluxos de agendamentos da clínica e a experiência dos pacientes, precisamos das seguintes informações:
      - Taxa de cancelamento média para cada médico.
      - Média de tempo entre a marcação e o cancelamento para cada médico.

**Ticket #5:**
  - A equipe de marketing lançará diariamente um informe sobre nossas OKRs anuais. Uma das informações mais importantes são o número total de pacientes e agendamentos atendidos. Para isso, teremos que criar uma nova tabela chamada OKRs e incluir diariamente (trigger) essas informações. Além disso, precisaremos incluir informações retroativas para podermos comparar o passado com o presente momento.
    - Ex: hoje tivemos 50 agendamentos atendidos. Ao finalizar o dia às 00:00:00, devemos incluir automaticamente essa informação na tabela de OKRs.
    - Obs: com base na tabela de agendamentos, deverá ser feito o carregamento de todos os quantitativos de agendamentos anteriores de uma vez só. Ex: ano passado, no dia 01/01, tivemos 10 agendamentos atendidos. No dia 02, tivemos 20 e assim sucessivamente.

**Ticket #6.1:**
  - As grandes seguradoras de saúde que atendemos cada vez mais nos solicitam dados para que elas analisem quanto de receitas estão ganhando e deixando de ganhar. Tendo em vista essa demanda, iremos criar um novo relatório que contenha as seguintes informações: data, quantidade e tipo.
    - Ex: no dia 01/01/2023, uma segunda-feira, o médico 1 possuía 15 slots da sua agenda disponíveis para agendamentos (8:00, 8:30, 9:00, ...). Ao fim do dia, 6 agendamentos foram atendidos, 2 desmarcados e 2 faltaram. Os outros 5 horários não foram ocupados.
    - Para o último exemplo, precisaremos inserir as seguintes linhas na tabela:
      ```
      data            quantidade          tipo                    idUsuario
      01/01/2023      6                   atendidos               1
      01/01/2023      4                   no-show                 1
      01/01/2023      5                   horários restantes      1
      ```
      - Horários restantes: horários livres que os médicos poderiam ter atendido alguém, mas não houve agendamento.
      - No-show: falta, desmarcação, agendamentos marcados e não atendidos.
      - Atendidos: agendamentos que de fato foram atendidos.
    - Obs: considere que todos os médicos possuem 20 horários disponíveis todos os dias.
    - Obs2: considere que por padrão os médicos não atenderam nos feriados nacionais, caso exista algum atendimento, foi uma emergência e não precisará ser contabilizado.

**Ticket #6.2:**
  - Tendo em vista que já possuímos o conhecimento de como calcular o no-show e os atendidos, iremos agora calcular o quanto ganhamos e deixamos de ganhar. Nesse novo ticket, foi solicitado um relatório com as seguintes colunas: ano, mês, tipo e valor.
    - Dica: os valores dos agendamentos são baseados nos procedimentos realizados.

Obs: em anexo seguem os arquivos .sql para a resolução desse desafio. Lembrando que logo mais poderemos ter uma reunião mais técnica para avaliar como os tickets foram solucionados e teremos algumas perguntas técnicas.

Obs2: antes de resolver os tickets, elabore o Modelo Entidade Relacionamento do banco. Ele contará para o desafio e servirá de auxílio para as resoluções.


