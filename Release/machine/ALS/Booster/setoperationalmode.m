function setoperationalmode(ModeNumber)
%SETOPERATIONALMODE - Switches between the various operational modes
%  setoperationalmode(ModeNumber)
%
%  ModeNumber = 1. '1.9 GeV Injection'
%               2. '1.5 GeV Injection
%             999. 'Greg's Mode'
%
%  See also aoinit, updateatindex, alsinit


global THERING

% Check if the AO exists
checkforao;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Accelerator Dependent Modes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 1
    ModeNumber = [];
end
if isempty(ModeNumber)
    ModeCell = {'1.9 GeV Injection', '1.23 GeV Injection', '1.522 GeV Injection', 'Greg''s Mode'};
    [ModeNumber, OKFlag] = listdlg('Name','ALS','PromptString','Select the Operational Mode:', 'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [450 200]);
    if OKFlag ~= 1
        fprintf('   Operational mode not changed\n');
        return
    end
    if ModeNumber == 4
        ModeNumber = 101;  % Model
    elseif ModeNumber == 5
        ModeNumber = 999;  % Greg
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Accelerator Data Structure %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AD = getad;
AD.Machine = 'ALS';              % Will already be defined if setpathmml was used
AD.MachineType = 'Booster';      % Will already be defined if setpathmml was used
AD.SubMachine  = 'Booster';      % Will already be defined if setpathmml was used
AD.OperationalMode = '';         % Gets filled in later
AD.HarmonicNumber = [];


% Defaults RF for disperion and chromaticity measurements (must be in Hardware units)
AD.DeltaRFDisp = 1000e-6;
AD.DeltaRFChro = [-2000 -1000 0 1000 2000] * 1e-6;


% Tune processor delay: delay required to wait
% to have a fresh tune measurement after changing
% a variable like the RF frequency.
AD.TuneDelay = 20.0;


% The offset and golden orbits are stored at the end of this file
BuildOffsetAndGoldenOrbits;  % Local function


% SP-AM Error level
% AD.ErrorWarningLevel = 0 -> SP-AM errors are Matlab errors {Default}
%                       -1 -> SP-AM errors are Matlab warnings
%                       -2 -> SP-AM errors prompt a dialog box
%                       -3 -> SP-AM errors are ignored (ErrorFlag=-1 is returned)
AD.ErrorWarningLevel = 0;


% BPM [2 4] gets CA errors
setfamilydata(0,'BPMx','Status',[2 4]);
setfamilydata(0,'BPMy','Status',[2 4]);
fprintf('   BPM(2,4) removed due to CA errors.\n');


%%%%%%%%%%%%%%%%%%%%%
% Operational Modes %
%%%%%%%%%%%%%%%%%%%%%

% Mode setup variables (mostly path and file names)
% AD.OperationalMode - String used in titles
% ModeName - String used for mode directory name off DataRoot/MachineName
% OpsFileExtension - string add to default file names
MachineName = lower(AD.Machine);
if ModeNumber == 1
    % 1.9 GeV Injection
    AD.OperationalMode = '1.9 GeV Injection';
    ModeName = '19INJ';
    OpsFileExtension = '_Booster';
    
    AD.Energy          = 1.89086196873342;  % make sure this is the same as bend2gev at the production lattice!
    AD.InjectionEnergy = 1.89086196873342;
    
    % AT lattice
    AD.ATModel = 'boosterlattice';
    boosterlattice(AD.Energy*1e9);
    
elseif ModeNumber == 2
    % 1.5 GeV Injection
    AD.OperationalMode = '1.23 GeV Injection';
    ModeName = '123INJ';
    OpsFileExtension = '_Booster';
    
    AD.Energy          = 1.23;  % make sure this is the same as bend2gev at the production lattice!
    AD.InjectionEnergy = 1.23;

    % AT lattice
    AD.ATModel = 'boosterlattice';
    boosterlattice(AD.Energy*1e9);
    
elseif ModeNumber == 3
    % 1.5 GeV Injection
    AD.OperationalMode = '1.5 GeV Injection';
    ModeName = '15INJ';
    OpsFileExtension = '_Booster';
    
    AD.Energy          = 1.522;  % make sure this is the same as bend2gev at the production lattice!
    AD.InjectionEnergy = 1.522;

    % AT lattice
    AD.ATModel = 'boosterlattice';
    boosterlattice(AD.Energy*1e9);

elseif 999
    
    % Greg's mode
    AD.OperationalMode = 'Greg''s Booster Mode';
    ModeName = 'Greg';
    OpsFileExtension = '_Booster';
    
    AD.Energy          = 1.89086196873342;  % make sure this is the same as bend2gev at the production lattice!
    AD.InjectionEnergy = 1.89086196873342;

    % AT lattice
    AD.ATModel = 'boosterlattice';
    boosterlattice(AD.Energy*1e9);
    
else
    
    % Test mode
    AD.OperationalMode = 'Booster Test Mode';
    ModeName = 'Test';
    OpsFileExtension = '_Booster';
    
    AD.Energy          = 1.89086196873342;  % make sure this is the same as bend2gev at the production lattice!
    AD.InjectionEnergy = 1.89086196873342;

    % AT lattice
    AD.ATModel = 'boosterlattice';
    boosterlattice(AD.Energy*1e9);
end



% Set MMLRoot to the standard local path when in standalone mode (must end in a file separator)
% Otherwise it will be set to someplace in the standalone directory location
if isdeployed
    if ispc
        AD.MMLRoot = 'N:\';
    else
        AD.MMLRoot = '/home/als/physbase/';
    end
end
setad(AD);
MMLROOT = setmmldirectories(AD.Machine, AD.SubMachine, ModeName, OpsFileExtension);
AD = getad;


% ALS specific path changes

% DataRoot Location
% This is a bit of a cluge to know if the user is on the ALS filer
% If so, the location of DataRoot will be different from the middle layer default
if isempty(findstr(lower(MMLROOT),'physbase')) && isempty(findstr(lower(MMLROOT),'n:\'))
    % Keep the normal middle layer directory structure
    switch2sim;
    
else
    % Use MMLROOT and DataRoot on the ALS filer
    if strcmp(computer,'PCWIN') == 1
        AD.Directory.DataRoot = ['\\Als-filer\physdata\matlab\', AD.SubMachine, 'Data', filesep, ModeName, filesep];
    else
        AD.Directory.DataRoot = ['/home/als/physdata/matlab/', AD.SubMachine, 'Data', filesep, ModeName, filesep];
    end
    
    % Data Archive Directories
    AD.Directory.BPMData        = [AD.Directory.DataRoot 'BPM', filesep];
    AD.Directory.TuneData       = [AD.Directory.DataRoot 'Tune', filesep];
    AD.Directory.ChroData       = [AD.Directory.DataRoot 'Chromaticity', filesep];
    AD.Directory.DispData       = [AD.Directory.DataRoot 'Dispersion', filesep];
    AD.Directory.ConfigData     = [AD.Directory.DataRoot 'MachineConfig', filesep];
    
    % Response Matrix Directories
    AD.Directory.BPMResponse    = [AD.Directory.DataRoot 'Response', filesep, 'BPM', filesep];
    AD.Directory.TuneResponse   = [AD.Directory.DataRoot 'Response', filesep, 'Tune', filesep];
    AD.Directory.ChroResponse   = [AD.Directory.DataRoot 'Response', filesep, 'Chromaticity', filesep];
    AD.Directory.DispResponse   = [AD.Directory.DataRoot 'Response', filesep, 'Dispersion', filesep];
    AD.Directory.SkewResponse   = [AD.Directory.DataRoot 'Response', filesep, 'Skew', filesep];
    
    % If using the ALS filer, I'm assuming you want to be online
    switch2online;
    
    % Change defaults for LabCA if using it
    try
        if exist('lcaSetRetryCount','file')
            % read dummy pv to initialize labca
            % ChannelName = family2channel('BPMx');
            % lcaGet(family2channel(ChannelName(1,:));

            % Retry count
            RetryCountNew = 500;  % 1000 Default: 599-old labca, 299-labca_2_1_beta
            RetryCount = lcaGetRetryCount;
            lcaSetRetryCount(RetryCountNew);
            if RetryCount ~= RetryCountNew
                fprintf('   Setting LabCA retry count to %d (was %d)\n', RetryCountNew, RetryCount);
            end

            % Timeout
            TimeoutNew = .1;  % .005  Default: .05-old labca, .1-labca_2_1_beta
            Timeout = lcaGetTimeout;
            lcaSetTimeout(TimeoutNew);
            if abs(Timeout - TimeoutNew) > 1e-5
                fprintf('   Setting LabCA TimeOut to %f (was %f)\n', TimeoutNew, Timeout);
            end
            
            % To avoid UDF errors, set the WarnLevel to 4 (Default is 3)
            lcaSetSeverityWarnLevel(4);
            fprintf('   Setting lcaSetSeverityWarnLevel to 4 to avoid annoying UDF errors.\n');
        end
    catch
        fprintf('   LabCA Timeout not set, need to run lcaSetRetryCount(1000), lcaSetTimeout(.01).\n');
    end
end



% Circumference
AD.Circumference = findspos(THERING,length(THERING)+1);
setad(AD);


% Updates the AT indices in the MiddleLayer with the present AT lattice
updateatindex;


% Set the model energy
setenergymodel(AD.Energy);


% Cavity and radiation
setcavity off;
setradiation off;
fprintf('   Radiation and cavities are off.  Use setradiation / setcavity to modify. \n'); 


% Momentum compaction factor
AD.MCF = [];
% MCF = getmcf('Model');
% if isnan(MCF)
%     AD.MCF = [];
%     fprintf('   Model alpha calculation failed, middlelayer alpha set to  %f\n', AD.MCF);
% else
%     AD.MCF = MCF;
%     fprintf('   Middlelayer alpha set to %f (AT model).\n', AD.MCF);
% end
setad(AD);


%%%%%%%%%%%%%%%%%%%%%%
% Final mode changes %
%%%%%%%%%%%%%%%%%%%%%%
if ModeNumber == 1
    % User mode - 1.9 GeV Injection
else
end



fprintf('   Middlelayer setup for booster operational mode: %s\n', AD.OperationalMode);




function BuildOffsetAndGoldenOrbits


AO = getao;


Offset = [AO.BPMx.DeviceList zeros(size(AO.BPMx.DeviceList,1),1) zeros(size(AO.BPMx.DeviceList,1),1)];


Golden = [AO.BPMx.DeviceList zeros(size(AO.BPMx.DeviceList,1),1) zeros(size(AO.BPMx.DeviceList,1),1)];


% Save the data
AO = getao;


% Offset orbits
[i, iNotFound, iFoundList] = findrowindex(Offset(:,1:2), AO.BPMx.DeviceList);
if ~isempty(iNotFound)
    fprintf('\n   Warning:  BPMx offsets are specified that are not in the family (setoperationalmode)\n');
end
if size(AO.BPMx.DeviceList,1) ~= length(i)
    fprintf('\n   Warning:  Not all the offsets in the BPMx family are being specified (setoperationalmode)\n');
end
AO.BPMx.Offset = zeros(size(AO.BPMx.DeviceList,1),1);
AO.BPMx.Offset(i) = Offset(iFoundList,3);

[i, iNotFound, iFoundList] = findrowindex(Offset(:,1:2), AO.BPMy.DeviceList);
if ~isempty(iNotFound)
    fprintf('\n   Warning:  BPMy offsets are specified that are not in the family (setoperationalmode)\n');
end
if size(AO.BPMy.DeviceList,1) ~= length(i)
    fprintf('\n   Warning:  Not all the offsets in the BPMy family are being specified (setoperationalmode)\n');
end
AO.BPMy.Offset = zeros(size(AO.BPMy.DeviceList,1),1);
AO.BPMy.Offset(i) = Offset(iFoundList,4);


% Golden orbits
[i, iNotFound, iFoundList] = findrowindex(Golden(:,1:2), AO.BPMx.DeviceList);
if ~isempty(iNotFound)
    fprintf('\n   Warning:  BPMx golden values are specified that are not in the family (setoperationalmode)\n');
end
if size(AO.BPMx.DeviceList,1) ~= length(i)
    fprintf('\n   Warning:  Not all the golden orbits in the BPMx family are being specified (setoperationalmode)\n');
end
AO.BPMx.Golden = zeros(size(AO.BPMx.DeviceList,1),1);
AO.BPMx.Golden(i) = Golden(iFoundList,3);

[i, iNotFound, iFoundList] = findrowindex(Golden(:,1:2), AO.BPMy.DeviceList);
if ~isempty(iNotFound)
    fprintf('\n   Warning:  BPMy golden values are specified that are not in the family (setoperationalmode)\n');
end
if size(AO.BPMy.DeviceList,1) ~= length(i)
    fprintf('\n   Warning:  Not all the golden orbits in the BPMy family are being specified (setoperationalmode)\n');
end
AO.BPMy.Golden = zeros(size(AO.BPMy.DeviceList,1),1);
AO.BPMy.Golden(i) = Golden(iFoundList,4);

setao(AO);
