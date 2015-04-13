function lnls1_measoptics2
%Medida completa de caracteriza��o da �tica do anel.
%
%Este script se encarrega de realizar um s�rie de medidas de
%caracteriza��o da �tica do anel.
%
%Hist�ria: 
%
%2010-09-13: coment�rios iniciais no c�digo.
%


date_str = get_date_str;
data_dir = fullfile(getfamilydata('Directory', 'DataRoot'), 'Optics', datestr(now, 'yyyy-mm-dd'));

% coloca o anel em modo ONLINE
if ~strcmpi(getmode('BEND'), 'Online'), switch2online; end

disp([get_date_str ': in�cio das medidas de caracteriza��o da �tica do anel']);
disp('Medidas:');
disp('1. medida de flutua��o nos BPMs');
disp('2. medida de fun��o dispers�o');
disp('3. medida de matriz resposta');

% medida de flutua��es dos BPMs
interval  = 180; % seconds
period    = 1.0; % seconds
file_name = fullfile(data_dir, ['BPMData_' date_str '.mat']);
lnls1_monbpm(0:period:interval, 'Archive', file_name, 'NoDisplay');

%{
% medida de flutua��es das fontes do anel
interval  = 180; % seconds
period    = 1.0; % seconds
file_name = fullfile(data_dir, ['magnetdata_' date_str '.mat']);
lnls1_monmags(0:period:interval, 'Archive', file_name, 'NoDisplay');
%}

% medida de fun��o dispers�o
file_name = fullfile(data_dir, ['Disp_' date_str '.mat']);
lnls1_measdisp('NoDisplay', 'Archive', file_name);

% medida de matriz resposta
file_name = fullfile(data_dir, ['BPMRespMat_' date_str '.mat']);
lnls1_measbpmresp('Archive', file_name);


disp([get_date_str ': fim das medidas de caracteriza��o da �tica.']);


function r = get_date_str
r = datestr(now, 'yyyy-mm-dd_HH-MM-SS'); 

