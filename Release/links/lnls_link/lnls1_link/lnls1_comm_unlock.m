function lnls1_comm_unlock
% Destrava conex�o
%
% lnls1_comm_unlock: destrava conex�o
%
% Hist�rico
%
% 2011-04-27: dados de conex�o s�o registrados em estruitura PVServer independente do MML (X.R.R.)
% 2010-09-16: coment�rios iniciais ao c�digo.

PVServer = getappdata(0, 'PVServer');
if ~isempty(PVServer) && isfield(PVServer, 'link')
    PVServer.link.locked = 0;
end
setappdata(0, 'PVServer', PVServer);
