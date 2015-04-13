function lnls1_comm_connect_inputdlg
% Menu de conex�o com servidor LNLS1LinkS
%
% lnls1_comm_connect_inputdlg
% ---------------------------
% Script que disponibiliza ao usu�rio um menu para escolha de qual servidor
% de estado de m�quina usar. Depois de escolhido o script chama a fun��o
% 'lnls1_comm_connect' que se encarrega de estabelecer a conex�o de fato.
% 
% Se existe uma estrutura 'PVServer' no espa�o de vari�veis AppData ent�o
% seus campos s�o acessados para definir os par�metros da conex�o, ao inv�s
% de se abrir o menu de escolha de 
%
% Hist�rico
%
% 2011-04-27: dados de conex�o s�o registrados em estruitura PVServer independente do MML (X.R.R.)
% 2010-09-16: coment�rios iniciais no c�digo

PVServer = getappdata(0, 'PVServer');
if isempty(PVServer)
    
    % ok, user has to select which server to connect to.
    servers(1) = struct('machine', '(NO CONNECTION)', 'ip', '', 'type', 'LNLS1Link');
    servers(2) = struct('machine', 'MML-LNLS1Link (LOCAL COMPUTER)', 'ip', '127.0.0.1', 'type', 'MML-LNLS1Link');
    servers(3) = struct('machine', 'OPR7', 'ip', '10.0.5.4', 'type', 'REMOTE');
    servers(4) = struct('machine', 'OPR1', 'ip', '10.128.1.2', 'type', 'REMOTE');
    servers(5) = struct('machine', 'OPR2', 'ip', '10.0.5.13', 'type', 'REMOTE');
    servers(6) = struct('machine', 'LNLS1Link (LOCAL COMPUTER)', 'ip', '127.0.0.1', 'type', 'LNLS1Link');

    % selects PV server for connection
    for i=1:length(servers)
        server_machines{i} = servers(i).machine;
    end
    [r ok] = listdlg('Name', 'LNLS1 PV Server Connection', 'PromptString', 'Select PV Server:', 'ListSize', [250 100], 'SelectionMode', 'single', 'ListString', server_machines);
    if ((~ok) || (r==0) || (strcmpi(servers(r).ip,''))), return; end

    server_type = servers(r).type;
    server_ip   = servers(r).ip;
    server_port = '53131';
    
else
    
    % the server ip and port numbers are stored in the AppData variable PVServer.
    server_type = PVServer.server.type;
    server_ip   = PVServer.server.ip_address;
    server_port = PVServer.server.ip_port;
    
end

% creates necessary structures for connection
PVServer.server.type       = server_type;
PVServer.server.ip_address = server_ip;
PVServer.server.ip_port    = server_port;
setappdata(0, 'PVServer', PVServer);

% calls connection drive routine
lnls1_comm_connect;