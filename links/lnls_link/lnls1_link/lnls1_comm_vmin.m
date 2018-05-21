function r = lnls1_comm_vmin(read_fields)
% Comando de leitura de valores m�nimos de todos os channelnames
%
% lnls1_comm_vmin(read_fields): l� os valores m�nimos dos par�metros do estado do anel definidos na estrutura 'read_fields'.
%
% Hist�rico
%
% 2010-09-16: coment�rios iniciais no c�digo



AD = getad;
if ~isfield(AD, 'PVServer') || ~isfield(AD.PVServer, 'link')
    error('MML is not connected to any LNLS1 PV Server!');
end

msg = ',VMIN,';

fields = fieldnames(read_fields);
for i=1:length(fields)
    msg = [msg upper(fields{i}) ','];
end

lnls1_comm_sendrecv_store_state(msg);

AD = getad;
for i=1:length(fields)
    r.(upper(fields{i})) = AD.PVServer.state.(upper(fields{i}));
end

