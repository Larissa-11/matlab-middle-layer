%   [s_P,P] = LNLS_IMPORTA_PERFIL_PRESSAO(arquivo) importa o perfil de press�o
%   do arquivo de texto.
%
%   ENTRADA
%       arquivo     arquivo com o perfil de press�o a importar, com
%                   posi��es [m] na primeira coluna e press�o [mbar] na
%                   segunda coluna
%   SA�DA
%       s_P         posi��o [m]
%       P           press�o [mbar]

function [s_P,P] = lnls_importa_perfil_pressao(arquivo)

perfil_pressao = importdata(arquivo);

% Obt�m dados de posi��o e press�o em um trecho do anel.
s_P = perfil_pressao(:,1); % Posi��o [m]
P   = perfil_pressao(:,2); % Press�o [mbar]

end