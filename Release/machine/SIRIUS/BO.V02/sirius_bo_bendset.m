function ErrorFlag = sirius_bo_bendset(Family, Field, AM, DeviceList, WaitFlag)
%SIRIUS_BO_BENDGET - Decompose values of magnet excitation families power supplies values.
%
%Hist�ria
%
%2015-09-09

if size(AM,1) ~= size(DeviceList,1)
    if size(AM,1) == 1 && size(AM,2) == 1
        AM = ones(size(DeviceList,1),1) * AM;
    elseif size(AM,1) == 1 && size(AM,2) == size(DeviceList,1)
        AM = AM.';
    else
        error('Setpoint size must equal the device list size or be a scalar.');
    end
end

PowerSupplies = getfamilydata(Family, 'PowerSupplies');
bend_a = PowerSupplies(1,:);
bend_b = PowerSupplies(2,:);

setpv(bend_a, Field, AM/2.0);
setpv(bend_b, Field, AM/2.0);

if ~isempty(WaitFlag) && WaitFlag>0,  pause(WaitFlag); end

ErrorFlag = 0;

return;
