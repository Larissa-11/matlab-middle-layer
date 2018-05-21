function lnls1_hwinit(varargin)
%LNLS1_HWINIT - Hardware initialization script
%
%Hist�ria
%
%2010-09-13: c�digo fonte com coment�rios iniciais.


DisplayFlag = 1;
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    end
end

