function delay = lnls1_booster_GF2delay(G,F)
%Retorna ajuste total de atraso do sistema de inje��o.
%
%Retorna ajuste de atraso total (nanosegundos) calculados do ajuste grosso
%
%History: 
%
%2010-09-13: coment�rios iniciais no c�digo.


delay = G + F;