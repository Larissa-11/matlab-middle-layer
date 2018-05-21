%   [cp,d_acc,E_n,gamma,T_rev,sigma_E,sigma_s,tau_am,mcf,U0] =
%   carrega_parametros carrega os parametros para c�lculo de tempo de vida,
%   usando o at. I � a corrente no anel em A, Nb o n�mero de bunches.


function [cp,d_acc,E_n,gamma,T_rev,sigma_E,sigma_s,tau_am,mcf,U0,k] ...
    = carrega_parametros

% Obt�m dados do at
dados_at = atsummary;

cp = dados_at.e0;                        % Energia [GeV]
d_acc = dados_at.energyacceptance;       % Aceit�ncia em energia
E_n = dados_at.naturalEmittance;         % Emit�ncia natural [m rad]

gamma = dados_at.gamma;                  % Calcula gama

T_rev = dados_at.revTime;                % Per�odo de revolu��o [s]

sigma_E = dados_at.naturalEnergySpread;  % Dispers�o de energia
sigma_s = dados_at.bunchlength;          % Comprimento do bunch [m]

tau_am = dados_at.radiationDamping;      % Tempos de amortecimento [s]
mcf = dados_at.compactionFactor;         % Fator de compacta��o de momento
U0 = dados_at.radiation*1e9;             % Perda de energia por volta [eV]
k = dados_at.harmon;                     % N�mero harm�nico