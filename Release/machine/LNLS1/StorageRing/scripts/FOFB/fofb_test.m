function  fofb_test(nr_samples,reading)
% r = fofb_acquire_data(nr_samples)
%
% Script de comunica��o com servidor FOFB para aquisi��o de dados de �rbita
%
% Input
%
% period:       per�odo de aquisi��o [us].
% nr_samples:   n�mero de amostras a serem adquiridas.
% reading:      Dado de leitura. Pode ser escolhido entre BPM, Corretoras
% ou ambos.Este par�metro deve ser configurado como BPM,PS ou BOTH.
%
% Hist�rico
%
% 2011-05-24: vers�o inicial
% 2011-05-27: vers�o Beta

import java.net.Socket;
import java.io.*;

% processes input parameters
r.acquisition_config.period     = 150;
r.acquisition_config.nr_samples = nr_samples;

if nargin < 2
    reading = 'BPM';
end
 if (strcmpi('BPM',reading)==1) || (strcmpi('PS',reading)==1) ||...
         (strcmpi('BOTH',reading))  
% builds acquition command string
msg = [',ACQUISITION_PERIOD,', ...
       num2str(r.acquisition_config.period), ',' ...
       ',N_SAMPLES,', ...
       num2str(r.acquisition_config.nr_samples), ',Reading,' ...
       reading,',']
   
else
    error('The input parameter "reading" is invalid. This parameter must be:''BPM'',''PS'' or ''BOTH''.');
end