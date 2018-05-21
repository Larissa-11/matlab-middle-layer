function lnls1_slow_orbcorr_on
%Liga corre��o autom�tica de �rbita no OPR1
%
%History: 
%
%2010-09-13: coment�rios iniciais no c�digo.

if strcmpi(getmode('BEND'), 'online')
    msg.AORBCOR_ON = 1;
    lnls1_comm_write(msg);
else
    fprintf('lnls1_slow_orbcorr_on: simulation mode!\n');
end
