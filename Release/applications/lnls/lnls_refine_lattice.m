function NEWRING = lnls_refine_lattice(RING, max_length, varargin)
% REFINELATTICE - gera nova rede com elementos de comprimentos menores.
%
% Hist�rico:
%
% 2010-10-27: vers�o inicial do c�digo (Ximenes R. Resende)

NEWRING = struct([]);
if nargin>2, families = varargin{1}; else families = {}; end;

for i=1:length(RING)
    
    if    (~isfield(RING{i}, 'Length') || (RING{i}.Length <= max_length)) ... % length < max_length
       || (~isempty(families) && ~any(strcmpi(families, RING{i}.FamName)))    % specified family?
        NEWRING{end+1} = RING{i};
        continue;
    end
    
    
    nrsplits = ceil(RING{i}.Length / max_length);
    elem = RING{i};
    elem.Length = RING{i}.Length / nrsplits;
    
    % for ID Kicktables
    if isfield(RING{i}, 'PxGrid')
        elem.PxGrid = elem.PxGrid / ntsplits;
        elem.PyGrid = elem.PyGrid / ntsplits;
    end
        
    if isfield(RING{i}, 'BendingAngle')
        
        elem1 = elem;
        elem1.BendingAngle = RING{i}.BendingAngle / nrsplits;
        elem1.ExitAngle = 0;
        if isfield(elem1, 'FringeInt2'), elem1.FringeInt2 = 0; end;
        elem2 = elem;
        elem2.BendingAngle = RING{i}.BendingAngle / nrsplits;
        elem2.EntranceAngle = 0;
        elem2.ExitAngle = 0;
        if isfield(elem2, 'FringeInt1'), elem2.FringeInt1 = 0; end;
        if isfield(elem2, 'FringeInt2'), elem2.FringeInt2 = 0; end;
        elem3 = elem;
        elem3.BendingAngle = RING{i}.BendingAngle / nrsplits;
        elem3.EntranceAngle = 0;
        if isfield(elem3, 'FringeInt1'), elem3.FringeInt1 = 0; end;
       
        NEWRING{end+1} = elem1;
        for j=2:nrsplits-1
            NEWRING{end+1} = elem2;
        end
        NEWRING{end+1} = elem3;
    else
        for j=1:nrsplits
            NEWRING{end+1} = elem;
        end
    end
end

