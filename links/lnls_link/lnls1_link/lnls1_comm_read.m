function lnls1_comm_read(read_fields)
% Envia comando de leitura ao servidor LNLS1LinkS
%
% lnls1_comm_read(read_fields): l� os par�metros do estado do anel definidos na estrutura 'read_fields'.
%
% Hist�rico
%
% 2011-04-27: dados de conex�o s�o registrados em estruitura PVServer independente do MML (X.R.R.)
% 2010-09-16: coment�rios iniciais no c�digo


% checks whether there is a connection to a machine state server
PVServer = getappdata(0, 'PVServer');
if isempty(PVServer) || ~isfield(PVServer, 'link')
    error('MML is not connected to any LNLS1 PV Server!');
end

% builds struct with channelnames to be accessed
msg = ',READ,';
fields = fieldnames(read_fields);
for i=1:length(fields)
    msg = [msg upper(fields{i}) ','];
end

% sends commando to server
lnls1_comm_sendrecv_store_state(msg);
