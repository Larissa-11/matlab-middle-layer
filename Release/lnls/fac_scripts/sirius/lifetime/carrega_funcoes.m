%   [r,P,Bx,By,alpha,eta,eta_diff,s_P_dipolo] = carrega_funcoes(arquivo)
%   fornece um vetor r com posi��es igualmente espa�adas em m, a press�o P
%   em arquivo(.txt) interpolada nos pontos de r e as fun��es Bx, By,
%   -B'/2, D e D' interpoladas ao longo desses pontos, usando o at.
%
%   A fun��o importa o perfil de press�o do arquivo .txt, para um trecho do
%   anel at� o marker definido em nomeft, com o vetor de posi��es
%   correspondente. Bx, By, alpha=-Bx'/2, eta e eta' s�o obtidas do at, com
%   calctwiss. Se a posi��o do dipolo no perfil de press�o � conhecida, o
%   vetor posi��o do perfil de press�o � transladado para coincidir com as
%   posi��es das fun��es obtidas do at, com o nome do dipolo definido em
%   nomedp; caso n�o seja, o perfil de press�o � transladado para o centro
%   do trecho. Os valores finais fornecidos pela fun��o s�o obtidos por
%   interpola��o dentro do intervalo determinado pela intersec��o do perfil
%   de press�o com o intervalo do trecho.

function [r,P,Bx,By,alpha,eta,eta_diff,s_P_dipolo]...
    = carrega_funcoes(arquivo)

% Importa perfil de press�o
[s_P,P1,s_P_dipolo,nome_pos_dipolo,nome_fim_trecho] = importa_perfil_pressao(arquivo);

% Obt�m dados do at
global THERING
A = calctwiss;

% Encontra �ndice do final do 1� trecho.
indices1 = findcells(THERING,'FamName',nome_fim_trecho);
i_B_fim = indices1(1);
% Obt�m valores de beta para o trecho.
s_B = A.pos(1:i_B_fim);        % Posi��o
Bx1 = A.betax(1:i_B_fim);      % Fun��o betatron horizontal no trecho
By1 = A.betay(1:i_B_fim);      % Fun��o betatron vertical no trecho
alpha1 = A.alphax;
eta1 = A.etax;

n_P = length(s_P);
n_B = length(s_B);


% Ajusta a origem da posi��o da press�o.
if(~isnan(s_P_dipolo))
    % Encontra �ndice do in�cio do 1� dipolo em s_B.
    indices2 = findcells(THERING,'FamName',nome_pos_dipolo);
    i_B_dipolo = indices2(1);
    s_P = s_P + s_B(i_B_dipolo) - s_P_dipolo;
else
    % Desloca o perfil de press�o para o centro do trecho.
    s_P = s_P + (s_B(n_B) - s_B(1) - (s_P(n_P) - s_P(1))) / 2;
end


% Determina o intervalo da interpola��o.
a = max(s_P(1),s_B(1));
b = min(s_P(n_P),s_B(n_B));

% Remove valores repetidos (para interpola��o).
[s_B,indices3] = unique(s_B);
Bx1 = Bx1(indices3);
By1 = By1(indices3);
alpha1 = alpha1(indices3);
eta1 = eta1(indices3);

% Calcula a derivada de eta1
eta_diff = diff(eta1) ./ diff(s_B);
s_Be = s_B(1:(length(s_B)-1));

N = 1000;   % N�mero de pontos para interpola��o
h = (b - a)/N;

% Interpola valores para integra��o.
r = a:h:b;                             % Pontos para interpola��o
P = interp1(s_P,P1,r);                 % Valores interpolados de press�o
Bx = interp1(s_B,Bx1,r);               % Valores interpolados de betax
By = interp1(s_B,By1,r);               % Valores interpolados de betay
alpha = interp1(s_B,alpha1,r);         % Valores interpolados de alpha
eta = interp1(s_B,eta1,r);             % Valores interpolados de eta
% Valores interpolados e extrapolados de eta_diff
eta_diff = interp1(s_Be,eta_diff,r,'linear','extrap');