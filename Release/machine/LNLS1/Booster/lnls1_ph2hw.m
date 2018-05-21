function Amps = lnls1_ph2hw(Family, Field, k, DeviceList, Energy)
%lnls1_ph2hw - Converts simulator values to amperes
%  Amps = lnls1_ph2hw(Family, Field, K, DeviceList, Energy)
%
%  INPUTS
%  1. Family - Family name
%  2. Field - Sub-field (like 'Setpoint')
%  3. K - "K-value" (AT convention)
%          For dipole:      K = B / Brho
%          For quadrupole:  K = B'/ Brho
%          For sextupole:   K = B"/ Brho / 2
%  4. DeviceList - Device list (Amps and DeviceList must have the same number of rows)
%  5. Energy - Energy in GeV {Default: getenergy}
%              If Energy is a vector, each output column will correspond to that energy.
%              Energy can be anything getenergy accepts, like 'Model' or 'Online'.
%              (Note: If Energy is a vector, then Amps can only have 1 column)
%
%  OUTPUTS
%  1. Amps - Ampere (or real hardware units)
%
%  See also lnls1_hw2ph, hw2physics, physics2hw


if nargin < 3
    error('At least 3 input required');
end

if isempty(Field)
    Field = 'Setpoint';
end

if nargin < 4
    DeviceList = [];
end
if isempty(DeviceList)
    DeviceList = family2dev(Family);
end

if nargin < 5
    Energy = [];
end
if isempty(Energy)
    Energy = getenergy;
elseif ischar(Energy)
    Energy = getenergy(Energy);
end


if size(k,1) == 1 && length(DeviceList) > 1
    k = ones(size(DeviceList,1),1) * k;
elseif size(k,1) ~= size(DeviceList,1)
    error('Rows in K must equal rows in DeviceList or be a scalar');
end


if all(isnan(k))
    Amps = k;
    B = k;
    return
end


% Force Energy and K to have the same number of columns
if all(size(Energy) > 1)
    error('Energy can only be a scalar or vector');
end
Energy = Energy(:)';

if length(Energy) > 1
    if size(k,2) == size(Energy,2)
        % OK
    elseif size(k,2) > 1
        error('If Energy is a vector, then K can only have 1 column.');
    else
        % K has one column, expand to the size of Energy
        k = k * ones(1,size(Energy,2));
    end
else
    Energy = Energy * ones(1,size(k,2));
end


ElementsIndex = dev2elem(Family,DeviceList);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setpoint and Monitor Fields %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if any(strcmpi(Field, {'Setpoint','Monitor'}))
    Brho = getbrho(Energy);
    if any(strcmpi(Family, {'HCM','VCM','KICKER'}))
        ExcData = getfamilydata(Family, 'ExcitationCurves');
        Amps=zeros(size(k,1),1);
        for i=1:length(ElementsIndex)
            idx = ElementsIndex(i);
            Amps(i) = interp1(ExcData.data{idx}(:,2), ExcData.data{idx}(:,1), k(i) * Brho);
        end
    elseif any(strcmpi(Family, findmemberof('QUAD')))
        EffLength = getleff(Family, DeviceList); 
        ExcData = getfamilydata(Family, 'ExcitationCurves');
        Amps=zeros(size(k,1),1);
        for i=1:length(ElementsIndex)
            idx = ElementsIndex(i);
            Amps(i) = interp1(ExcData.data{idx}(:,2), ExcData.data{idx}(:,1), k(i) * EffLength(i) * Brho);
        end
    elseif any(strcmpi(Family, findmemberof('SEXT')))
        EffLength = getleff(Family, DeviceList); 
        ExcData = getfamilydata(Family, 'ExcitationCurves');
        Amps=zeros(size(k,1),1);
        for i=1:length(ElementsIndex)
            idx = ElementsIndex(i);
            Amps(i) = interp1(ExcData.data{idx}(:,2), ExcData.data{idx}(:,1), k(i) * 2 * EffLength(i) * Brho);
        end
    else
        Amps = k;
    end
    return
end


% If you made it to here, I don't know how to convert it
Amps = k;
return
