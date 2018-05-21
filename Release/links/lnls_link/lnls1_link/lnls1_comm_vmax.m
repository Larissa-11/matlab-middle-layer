function r = lnls1_comm_vmax(read_fields)
% Comando de leitura de valores m�ximos de todos os channelnames
%
% lnls1_comm_vmin(read_fields): l� os valores m�ximos dos par�metros do
% estado do anel definidos na estrutura 'read_fields'.
%
% Hist�rico
%
% 2011-04-27: dados de conex�o s�o registrados em estruitura PVServer independente do MML (X.R.R.)
% 2010-09-16: coment�rios iniciais no c�digo



PVServer = getappdata(0, 'PVServer');
if isempty(PVServer) || ~isfield(PVServer, 'link')
    error('MML is not connected to any LNLS1 PV Server!');
end

msg = ',VMAX,';

fields = fieldnames(read_fields);
for i=1:length(fields)
    msg = [msg upper(fields{i}) ','];
end

lnls1_comm_sendrecv_store_state(msg);

PVServer = getappdata(0, 'PVServer');
for i=1:length(fields)
    r.(upper(fields{i})) = PVServer.state.(upper(fields{i}));
end

