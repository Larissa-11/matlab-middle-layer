function lnls1_comm_disconnect

% Fecha conex�o com servidor LNLS1LinkS
%
% lnls1_comm_disconnect: disconecta do servidor de estado do anel UVX do LNLS.
%
% Hist�rico
%
% 2011-04-27: dados de conex�o s�o registrados em estruitura PVServer independente do MML (X.R.R.)

try
    PVServer = getappdata(0, 'PVServer');
    if ~isempty(PVServer)
        if isfield(PVServer, 'link')
            PVServer.link.socket.close();
            PVServer = rmfield(PVServer, 'link');
            setappdata(0, 'PVServer', PVServer);
        end
    end
catch
end


          