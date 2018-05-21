function [LocoMeasData, BPMData, CMData, RINGData, FitParameters, LocoFlags] = buildlocoinput(FileName)
%BUILDLOCOFITPARAMETERS - SPS LOCO fit parameters
%
%  [LocoMeasData, BPMData, CMData, RINGData, FitParameters, LocoFlags] = buildlocoinput(FileName)



%%%%%%%%%%%%%%
% Input file %
%%%%%%%%%%%%%%
if nargin == 0
    [FileName, DirectoryName, FilterIndex] = uigetfile('*.mat','Select a LOCO input file');
    if FilterIndex == 0 
        return;
    end
    FileName = [DirectoryName, FileName];
end

load(FileName);



%%%%%%%%%%%%%%%%%%%%%%
% Remove bad devices %
%%%%%%%%%%%%%%%%%%%%%%
RemoveHCMDeviceList = [];
RemoveVCMDeviceList = [];

RemoveHBPMDeviceList = [];
RemoveVBPMDeviceList = [];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is only works on the first iteration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist('BPMData','var') && length(BPMData)>1
    BPMData = BPMData(1);
end
if exist('CMData','var') && length(CMData)>1
    CMData = CMData(1);
end
if exist('FitParameters','var') && length(FitParameters)>1
    FitParameters = FitParameters(1);
end
if exist('LocoFlags','var') && length(LocoFlags)>1
    LocoFlags = LocoFlags(1);
end
if exist('LocoModel','var') && length(LocoModel)>1
    LocoModel = LocoModel(1);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make sure the start point in loaded in the AT model %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(FitParameters)
    for i = 1:length(FitParameters.Params)
        RINGData = locosetlatticeparam(RINGData, FitParameters.Params{i}, FitParameters.Values(i));
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tune up a few parameters based on the MachineConfig %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    if isfield(LocoMeasData, 'MachineConfig')
        % Sextupoles
        if all(MachineConfig.SF.Setpoint.Data == 0)
            fprintf('   Turning SF family off in the LOCO model.\n');
            ATIndex = findcells(RINGData.Lattice,'FamName','SF')';
            for i = 1:length(ATIndex)
                RINGData.Lattice{ATIndex(i)}.PolynomB(3) = 0;
            end
        end
        if all(MachineConfig.SD.Setpoint.Data == 0)
            fprintf('   Turning SD family off in the LOCO model.\n');
            ATIndex = findcells(RINGData.Lattice,'FamName','SD')';
            for i = 1:length(ATIndex)
                RINGData.Lattice{ATIndex(i)}.PolynomB(3) = 0;
            end
        end
    end
catch
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LocoFlags to change from the default %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LocoFlags.Threshold = 1e-5;
% LocoFlags.OutlierFactor = 10;
% LocoFlags.SVmethod = 1e-2;
% LocoFlags.HorizontalDispersionWeight = 12.5;
% LocoFlags.VerticalDispersionWeight = 12.5;
% LocoFlags.AutoCorrectDelta = 'Yes';
% LocoFlags.Coupling = 'No';
% LocoFlags.Dispersion = 'No';
% LocoFlags.Normalize = 'Yes';
% LocoFlags.ResponseMatrixCalculatorFlag1 = 'Linear';
% LocoFlags.ResponseMatrixCalculatorFlag2 = 'FixedPathLength';
% LocoFlags.CalculateSigma = 'No';
% LocoFlags.SinglePrecision = 'Yes';

% CMData.FitKicks    = 'Yes';
% CMData.FitCoupling = 'No';
% 
% BPMData.FitGains    = 'Yes';
% BPMData.FitCoupling = 'No';


% CMs to disable
j = findrowindex(RemoveHCMDeviceList, LocoMeasData.HCM.DeviceList);
if ~isempty(j)
    irm = findrowindex(j(:),CMData.HCMGoodDataIndex(:));
    CMData.HCMGoodDataIndex(irm) = [];
end

j = findrowindex(RemoveVCMDeviceList, LocoMeasData.VCM.DeviceList);
if ~isempty(j)
    irm = findrowindex(j(:),CMData.VCMGoodDataIndex(:));
    CMData.VCMGoodDataIndex(irm) = [];
end


% BPMs to disable
j = findrowindex(RemoveHBPMDeviceList, LocoMeasData.HBPM.DeviceList);
if ~isempty(j)
    irm = findrowindex(j(:),BPMData.HBPMGoodDataIndex(:));
    BPMData.HBPMGoodDataIndex(irm) = [];
end

j = findrowindex(RemoveVBPMDeviceList, LocoMeasData.VBPM.DeviceList);
if ~isempty(j)
    irm = findrowindex(j(:),BPMData.VBPMGoodDataIndex(:));
    BPMData.VBPMGoodDataIndex(irm) = [];
end



%%%%%%%%%%%%%%%%%
% FitParameters %
%%%%%%%%%%%%%%%%%

% Individual magnets
% For each parameter which is fit in the model a numerical response matrix
% gradient needs to be determined.  The FitParameters data structure determines what
% parameter in the model get varied and how are they grouped.  For no parameter fits, set
% FitParameters.Params to an empty vector.
%     FitParameters.Params = parameter group definition (cell array for AT)
%     FitParameters.Values = Starting value for the parameter fit
%     FitParameters.Deltas = change in parameter value used to compute the gradient (NaN forces loco to choose, see auto-correct delta flag below)
%     FitParameters.FitRFFrequency = ('Yes'/'No') Fit the RF frequency?
%     FitParameters.DeltaRF = Change in RF frequency when measuring "dispersion".
%                             If the RF frequency is being fit the output is stored here.
%
% The FitParameters structure also contains the standard deviations of the fits:
%     LocoValuesSTD
%     FitParameters.DeltaRFSTD
%
% Note: FitParameters.DeltaRF is used when including dispersion in the response matrix.
%       LocoMeasData.DeltaRF is not used directly in loco.  Usually one would set
%       FitParameters.DeltaRF = LocoMeasData.DeltaRF as a starting point for the RF frequency.


global THERING

ModeCell = {'Fit QL1 - QM1 Magnets by Power Supply','Fit QL1 - QM1 by Magnet','No Parameter Setup'};
[ButtonName, OKFlag] = listdlg('Name','BUILDLOCOINPUT','PromptString','Fit Parameter Selection:', 'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [350 125]);
if OKFlag ~= 1
    ButtonName = 1;
end
drawnow;
FitParameters = [];
N = 0;
switch ButtonName
    case 1 %'Fit by Power Supply'

        fprintf('\n   Fit Quadupoles by Power Supply\n');

        % QL1 K-values
        iAT = findcells(THERING,'FamName','QL1');
        N = N + 1;
        FitParameters.Params{N} = mkparamgroup(THERING,iAT,'K');
        FitParameters.Values = getcellstruct(THERING,'K',iAT(1));
        FitParameters.Deltas = NaN;

        % QL2 K-values
        iAT = findcells(THERING,'FamName','QL2');
        N = N + 1;
        FitParameters.Params{N} = mkparamgroup(THERING,iAT,'K');
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT(1))];
        FitParameters.Deltas = [FitParameters.Deltas; NaN];

        % QL3 K-values
        iAT = findcells(THERING,'FamName','QL3');
        N = N + 1;
        FitParameters.Params{N} = mkparamgroup(THERING,iAT,'K');
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT(1))];
        FitParameters.Deltas = [FitParameters.Deltas; NaN];

        % QH1 K-values
        iAT = findcells(THERING,'FamName','QH1');
        N = N + 1;
        FitParameters.Params{N} = mkparamgroup(THERING,iAT,'K');
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT(1))];
        FitParameters.Deltas = [FitParameters.Deltas; NaN];

        % QH2 K-values
        iAT = findcells(THERING,'FamName','QH2');
        N = N + 1;
        FitParameters.Params{N} = mkparamgroup(THERING,iAT,'K');
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT(1))];
        FitParameters.Deltas = [FitParameters.Deltas; NaN];
        
        % QM1 K-values
        iAT = findcells(THERING,'FamName','QM1');
        N = N + 1;
        FitParameters.Params{N} = mkparamgroup(THERING,iAT,'K');
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT(1))];
        FitParameters.Deltas = [FitParameters.Deltas; NaN];

        % QM2 K-values
        iAT = findcells(THERING,'FamName','QM2');
        N = N + 1;
        FitParameters.Params{N} = mkparamgroup(THERING,iAT,'K');
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT(1))];
        FitParameters.Deltas = [FitParameters.Deltas; NaN];

    case 2 %'Fit by Magnet'

        fprintf('\n   Fits Quadrupoles by Magnet\n');

        % QL1 K-values
        iAT = findcells(THERING,'FamName','QL1');
        for loop=1:length(iAT)
            N = N + 1;
            FitParameters.Params{N} = mkparamgroup(THERING,iAT(loop),'K');
        end
        FitParameters.Values = getcellstruct(THERING,'K',iAT);
        FitParameters.Deltas = NaN * ones(length(iAT),1);

        % QL2 K-values
        iAT = findcells(THERING,'FamName','QL2');
        for loop=1:length(iAT)
            N = N + 1;
            FitParameters.Params{N} = mkparamgroup(THERING,iAT(loop),'K');
        end
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT)];
        FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(iAT),1)];

        % QL3 K-values
        iAT = findcells(THERING,'FamName','QL3');
        for loop=1:length(iAT)
            N = N + 1;
            FitParameters.Params{N} = mkparamgroup(THERING,iAT(loop),'K');
        end
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT)];
        FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(iAT),1)];

        % QH1 K-values
        iAT = findcells(THERING,'FamName','QH1');
        for loop=1:length(iAT)
            N = N + 1;
            FitParameters.Params{N} = mkparamgroup(THERING,iAT(loop),'K');
        end
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT)];
        FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(iAT),1)];

        % QH2 K-values
        iAT = findcells(THERING,'FamName','QH2');
        for loop=1:length(iAT)
            N = N + 1;
            FitParameters.Params{N} = mkparamgroup(THERING,iAT(loop),'K');
        end
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT)];
        FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(iAT),1)];

        % QH3 K-values
        iAT = findcells(THERING,'FamName','QH3');
        for loop=1:length(iAT)
            N = N + 1;
            FitParameters.Params{N} = mkparamgroup(THERING,iAT(loop),'K');
        end
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT)];
        FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(iAT),1)];

        % QM1 K-values
        iAT = findcells(THERING,'FamName','QM1');
        for loop=1:length(iAT)
            N = N + 1;
            FitParameters.Params{N} = mkparamgroup(THERING,iAT(loop),'K');
        end
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT)];
        FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(iAT),1)];

        % QM2 K-values
        iAT = findcells(THERING,'FamName','QM2');
        for loop=1:length(iAT)
            N = N + 1;
            FitParameters.Params{N} = mkparamgroup(THERING,iAT(loop),'K');
        end
        FitParameters.Values = [FitParameters.Values; getcellstruct(THERING,'K',iAT)];
        FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(iAT),1)];
end


% Starting point for the deltas (automatic delta determination does not work if starting value is 0)
%FitParameters.Deltas = 0.0001 * ones(size(FitParameters.Values));


% RF parameter fit setup (There is a flag to actually do the fit)
if isempty(LocoMeasData.DeltaRF)
    FitParameters.DeltaRF = 500;  % It's good to have something here so that LOCO will compute a model dispersion
else
    FitParameters.DeltaRF = LocoMeasData.DeltaRF;
end


% File check
[BPMData, CMData, LocoMeasData, LocoModel, FitParameters, LocoFlags, RINGData] = locofilecheck({BPMData, CMData, LocoMeasData, LocoModel, FitParameters, LocoFlags, RINGData});


% Save
save(FileName, 'LocoModel', 'FitParameters', 'BPMData', 'CMData', 'RINGData', 'LocoMeasData', 'LocoFlags');


