function lnls1_meastuneresp
%Mede sintonias do anel.
%
%Hist�ria: 
%
%2010-09-13: coment�rios iniciais no c�digo.
%

if ~strcmpi(getmode('BEND'), 'Online'), switch2online; end

lnls1_fast_orbcorr_on;
meastuneresp;
