function RadiationElemIndex = getindex_radiationelements
% Retorna �ndices do modelo com elementos que geram radia��o.
%
% Hist�ria:
%
% 2010-09-16: coment�rios no c�digo.



% Get all the AT elements that add radiation
BendCell = findmemberof('BEND');
iBend = family2atindex(BendCell);
for ii = 1:length(iBend)
    if size(iBend{ii},2) > 1
        iBend{ii} = sort(iBend{ii}(:));
        nanindx = find(isnan(iBend{ii}));
        iBend{ii}(nanindx) = [];
    end
end
iBend = cell2mat(iBend(:));


QuadCell = findmemberof('QUAD');
iQuad = family2atindex(QuadCell);
for ii = 1:length(iQuad)
    if size(iQuad{ii},2) > 1
        iQuad{ii} = sort(iQuad{ii}(:));
        nanindx = find(isnan(iQuad{ii}));
        iQuad{ii}(nanindx) = [];
    end
end
iQuad = cell2mat(iQuad(:));


SextCell = findmemberof('SEXT');
iSext = family2atindex(SextCell);
for ii = 1:length(iSext)
    if size(iSext{ii},2) > 1
        iSext{ii} = sort(iSext{ii}(:));
        nanindx = find(isnan(iSext{ii}));
        iSext{ii}(nanindx) = [];
    end
end
iSext = cell2mat(iSext(:));


RadiationElemIndex = sort([iBend(:); iQuad(:); iSext(:)]');