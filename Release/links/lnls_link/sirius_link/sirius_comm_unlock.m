function sirius_comm_unlock
% sirius_comm_unlock: destrava conex�o

AD = getad;
if isfield(AD, 'PVServer') && isfield(AD.PVServer, 'link')
    AD.PVServer.link = 0;
end
    
setad(AD);
