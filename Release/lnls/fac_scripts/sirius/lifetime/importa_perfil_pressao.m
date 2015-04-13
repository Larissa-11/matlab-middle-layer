%   [s_P,P,s_P_dipolo,nome_pos_dipolo,nome_fim_trecho] =
%   IMPORTA_PERFIL_PRESSAO(arquivo) importa o perfil de press�o do arquivo
%   de texto. Na primeira linha, dipolo= indica a posi��o do dipolo no
%   perfil de press�o em m (n�o deve haver espa�o antes do n�mero; se for
%   vazio, o resultado � NaN. Ap�s a terceira linha, a primeira coluna do
%   arquivo deve conter as posi��es (s_P) em m; a segunda, os valores de
%   press�o correspondentes (P) em mbar. Strings com o FamName do elemento
%   que determina a posi��o do dipolo e o fim do trecho s�o carregadas em
%   nome_pos_dipolo e nome_fim_trecho.

function [s_P,P,s_P_dipolo,nome_pos_dipolo,nome_fim_trecho] = importa_perfil_pressao(arquivo)

perfil_pressao = importdata(arquivo);

% Obt�m dados de posi��o (m) e press�o (mbar) em um trecho do anel.
s_P = perfil_pressao.data(:,1);   % Posi��o
P = perfil_pressao.data(:,2);     % Press�o

dipolo_str = perfil_pressao.textdata{1};
s_P_dipolo = str2double(dipolo_str(8:length(dipolo_str)));

pos_str = perfil_pressao.textdata{2};
nome_pos_dipolo = pos_str(8:length(pos_str));

fim_str = perfil_pressao.textdata{3};
nome_fim_trecho = fim_str(8:length(fim_str));

end