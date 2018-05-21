function lnls1_comm_wait_semaphore
% Espera semaphoro de conex�o ser liberado
%
% lnls1_comm_wait_semaphore: espera sem�foro de conex�o
%
% Hist�rico
%
% 2011-04-27: dados de conex�o s�o registrados em estruitura PVServer independente do MML (X.R.R.)
% 2010-09-16: coment�rios iniciais ao c�digo.

wait_msg = 'lnls1_comm_sendrecv_store_state: waiting semaphore to open...\n';
is_locked = false;

PVServer = getappdata(0, 'PVServer');
if ~isempty(PVServer) && isfield(PVServer, 'link') && isfield(PVServer.link, 'locked') && (PVServer.link.locked ~= 0)
    is_locked = true;
end

while is_locked
    
    % prints info message if one time
    if ~isempty(wait_msg) 
        fprintf(wait_msg); 
        wait_msg = [];
    end
    
    % updates lock info
    PVServer = getappdata(0, 'PVServer');
    if ~isempty(PVServer) && isfield(PVServer, 'link') && isfield(PVServer.link, 'locked') && (PVServer.link.locked ~= 0)
        is_locked = true;
    else
        is_locked = false;
    end
    
end