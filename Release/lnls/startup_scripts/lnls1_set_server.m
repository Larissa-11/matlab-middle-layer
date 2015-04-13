function lnls1_set_server(server_type, server_ip, server_port)
% Define servidor LNLS1LinkS default para conex�o
%
% lnls1_set_server
% --------------------
% Script que permite ao usu�rio definir um servidor default para conex�o
% e acesso � m�quina (real ou simulada). Os par�metros que definem o
% servidor s�o armazenados em uma estrutura na �rea de dados de aplicativos 
% do Matlab e s�o, portanto, diretamente invis�veis do workspace. Esta
% estrutura quando existende permite que a inicializa��o da comunica��o
% com o servidor seja realizada pelos scripts do MML de forma autom�tica,
% sem o input do usu�rio.
%
% Exemplos:
%
% 1) Simulator Mode
% >>lnls1_set_server('','','');
%
% 2) Conex�o com OPR1 (a partir da rede de controle):
% >>lnls1_set_server('REMOTE', '10.128.1.2', '53131');
%
% 3) Conex�o com Servidor MML-LNLS1Link (emula��o) rodando no mesmo PC 
% >>lnls1_set_server('REMOTE', '127.0.0.1', '53131');
%
%
% Hist�rico
%
% 2012-01-25: corrigidos os coment�rios. (X.R.R.)
% 2011-04-27: dados de conex�o s�o registrados em estrutura PVServer independente do MML (X.R.R.)
% 2010-09-22: vers�o inicial com coment�rios.

PVServer = getappdata(0, 'PVServer');
PVServer.server.type = server_type;
PVServer.server.ip_address   = server_ip;
PVServer.server.ip_port = server_port;
setappdata(0, 'PVServer', PVServer);