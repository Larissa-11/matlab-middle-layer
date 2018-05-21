% d_acc = CALCULA_ACEITANCIA(U0,mcf,k,cp,V_rf) calcula a aceit�ncia em
% energia.
%
%   ENTRADA
%       U0      perda de energia por volta por el�tron [eV]
%       mcf     fator de compacta��o de momento
%       k       n�mero harm�nico
%       cp      energia [GeV]
%       V_rf    tens�o de RF [V]
%   SA�DA
%       d_acc   acet�ncia em energia relativa


function d_acc = calcula_aceitancia(U0,mcf,k,cp,V_rf)

cp = cp * 1e9; % energia em eV

q = V_rf/U0; % sobrevoltagem

if(q > 1)
    F = 2*(sqrt(q^2-1) - acos(1/q));
    d_acc = sqrt(U0*F/pi/mcf/k/cp);
else
    d_acc = 0;
end