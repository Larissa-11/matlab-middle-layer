%   [s_V,Vx,Vy] = LNLS_IMPORTA_PERFIL_CAMARA(arquivo) importa o perfil de
%   c�mara de v�cuo do arquivo de texto.
%
%   ENTRADA
%       arquivo     arquivo .txt para importar, com posi��es [m] na
%                   primeira coluna e meia abertura horizontal e vertical
%                   [mm] na segunda e terceira colunas, respectivamente
%   SA�DA
%       s_V         posi��o [m]
%       Vx          meia abertura horizontal da c�mara de v�cuo [mm]
%       Vy          meia abertura vertical da c�mara de v�cuo [mm]

function [s_V,Vx,Vy] = lnls_importa_perfil_camara(arquivo)

perfil_camara = importdata(arquivo);

% Obt�m dados de posi��o e meia abertura em um trecho do anel.
s_V = perfil_camara(:,1); % Posi��o [m]
Vx  = perfil_camara(:,2); % Meia abertura horizontal [mm]
Vy  = perfil_camara(:,3); % Meia abertura vertical [mm]

end