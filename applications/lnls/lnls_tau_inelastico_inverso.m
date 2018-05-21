%   [W,Wm] = LNLS_TAU_INELASTICO_INVERSO(Z,T,cp,R,EA_x,EA_y,r,P,Bx,By)
%   calcula 1/tau, onde tau � o tempo de vida inel�stico, em segundos. W �
%   um vetor contendo os valores de tempo de vida ao longo do vetor posi��o
%   r, enquanto Wm � o valor m�dio de W nesse trecho.
%
%   C�lculo de tempo de vida por espalhamento el�stico baseado em Beam
%   losses and lifetime - A. Piwinski, em CERN 85-19.
%
%   As entradas s�o a aceit�ncia em energia d_acc (fra��o), um vetor
%   posi��o (r), em m, com os valores de press�o (P) ao longo desse vetor
%   (r e P devem ter as mesmas dimens�es. Para aceit�ncia nula, negativa ou
%   complexa, o tempo de vida calculado � nulo.

function [W,Wm] = lnls_tau_inelastico_inverso(Z,T,d_acc,r,P)

if(isreal(d_acc) && d_acc>0)
    W = 1346 * log(183/Z^(1/3)) * ( log(1/d_acc) - 0.625 + d_acc ) * Z^2/T * P;
    Wm = trapz(r,W) / ( r(length(r)) - r(1) );
else
    W = Inf(length(r),1);
    Wm = Inf;
end