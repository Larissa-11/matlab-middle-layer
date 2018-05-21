%MEXCOMMAND Make mca.mexglx from mcamain.cpp


cd /home/als/physbase/matlab2004/mca
mex mca.cpp MCAError.cpp Channel.cpp ChannelAccess.cpp ...
    /home/als1/acct/alsbase/epics_release/R3.14.6/base-3.14.6/lib/linux-x86/libCom.so ...
    /home/als1/acct/alsbase/epics_release/R3.14.6/base-3.14.6/lib/linux-x86/libca.so ...
    -DDB_TEXT_GLBLSOURCE -DGCC -DEPICS_DLL_NO ...
    -I/home/als1/acct/alsbase/epics_release/R3.14.6/base-3.14.6/include ...
    -I/home/als1/acct/alsbase/epics_release/R3.14.6/base-3.14.6/include/os/Linux ...
    -v

mex timereval.cpp -v