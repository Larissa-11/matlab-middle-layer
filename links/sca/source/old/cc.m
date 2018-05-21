function cc(fn)
% cc(filename)
%
%  Version 5, Linux compiling function
%


disp(['Compiling: ',fn]);

if strncmp(computer,'PC',2)

    cmdstr = [...
        'mex', ...
        ' -Iz:\include\controls\epics\r13 ', ...
        fn, ...
        ' -Lz:\lib32\controls\epics\r13\release\sca3.lib'];

elseif strncmp(computer, 'GLNX', 4)

    cmdstr = [...
        'mex', ...
        ' -I/home/als/alsbase/matlab7/extern/include', ...
        ' -I/home/als2/prod/scaIII/linux-x86/src ', ...
        fn, ...
        ' -L/home/als2/prod/scaIII/linux-x86/lib', ...
        ' /home/als2/prod/scaIII/linux-x86/lib/libsca.o', ...
        ' /home/als2/prod/scaIII/linux-x86/lib/libca.a', ...
        ' /home/als2/prod/scaIII/linux-x86/lib/libCom.a'];

    % I blindly added libsca.a on 9-26-03 after Eric added it to the library directory T.Scarvie    (it didn't appear to help)

elseif strncmp(computer, 'SOL', 3)

    cmdstr = [...
        'mex', ...
        ' -I/home/als2/prod/scaIII/include ', ...
        fn, ...
        ' -L/home/als2/prod/scaIII/lib', ...
        ' /home/als2/prod/scaIII/lib/libsca.so'];

else

    error('Unknown computer type');
    

end


disp(cmdstr);
eval(cmdstr);
