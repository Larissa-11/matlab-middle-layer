function at2mml(ATFamilies)
% Convert FamilyNames do modelo AT para FamilyNames do MML
%
% Hist�rico:
%
% 2010-09-16: coment�rios iniciais do c�digo (Ximenes R. Resende)

global THERING

for i=1:length(ATFamilies)
    MMLFamily = findmemberof(ATFamilies{i});
    for j=1:length(MMLFamily)
        Family = MMLFamily{j};
        ATIndex = getfamilydata(Family, 'AT', 'ATIndex');
        ATIndex = ATIndex(:);
        THERING = setcellstruct(THERING, 'FamName', ATIndex, MMLFamily{j});
    end
end
