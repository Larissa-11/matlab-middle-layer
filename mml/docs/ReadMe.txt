%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     A Matlab Middle Layer (MML) for Accelerator Control                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
The Matlab Middle Layer (MML) software came out of a collaborative effort between Jeff Corbett, 
Andrei Terebilo, and myself at Spear3.  The roots of the middle layer software start at the ALS  
where Dave Robin and myself (and later Winni Decking, Christoph Steier, Tom Scarvie, Laurent Nadolski) 
wrote many of the basic physics functions.  Well, Dave actually didn't write much code but he did 
influence and majorly supported ($) the entire software package.  Now that the MML is running on
many accelerators world wide (at least 11), there are many authors of the new MML.  Many thanks 
to all the people who have made suggestions, written new functions, and fixed bugs.  I look forward 
more collaborations and I'm curious to see how things morph and improve as we move forward.

If isn't a zip file on my website send me an email and I'll update the MML and zip it.
Thanks,
Greg

Greg Portmann
gjportmann@lbl.gov
1-510-486-4105

Jeff Corbett
corbett@slac.stanford.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
You can download the MatlabMiddleLayerRelease.zip file on:
http://controls.als.lbl.gov/als_physics/portmann/MiddleLayer/
Usually, only the mml directory (and sub-directories) need to be updated.
Since I constantly improve the MML, email me if you want me to update 
the files on the website to the absolute latest.


Change History:
2009 - March
1. Bug fix in setorbitgui when changing the number of BPMs and using the RF frequency.
2. Updated the TLS machine directory
3. measrespmat - upstream elements zeroed for transport lines
4. Improved getlattice

2009 - February
1. viewfamily GUI
2. machineconfig GUI
3. getunits, getmode, family2channel made more robust when the field input is empty.  New findfirstfield function.

2009 - January
1. Mostly small changes added in the last couple months.  I'm start to add more functionality
   for transport line.
2. Added TLS, BESSY2, MLS and ELSA rings to the MML release.

2008 - September
1. Added ALBA to the distribution (setpathalba to try it)
2. Added the MLS accelerator (Bessy) to the distribution

2008 - July
1. Added Laurent's reson to /mml directory
2. Added Marc's TuneMovePanel to /mml/at directory (presently model only)
3. monbpm changed to pre-allocate memory
4. New function: [MachineName, MachineType] = whereami


2008 - June
1. measlocodata and monbpm changed to allow a 'model' input flag (as well as 'online' & 'simulator').
   This is useful for rapid testing of LOCO on the model.
2. modeldisp fixed when no RF cavity is present.

2008 - March
1. Changed measrespmat when using physics units to convert the .DeltaRespMat about the 
   present setpoint.  This should help with nonlinearities in hardware-to-physics conversions.
2. Added an attempt at a MML.gif and MML_Matlab.gif.  Any help here welcome.
3. New functions: getbrhoinv, concatenaterings, drawlattice2d, ismachine, monbpmpsd (still needs some work)
4. Added a handle output to drawlattice and drawlattice2d
5. xaxesposition, yaxesposition changes to handled linked positions (like with plotyy)
6. getpvmodel & setpvmodel updated to make it easier to set fields typically not needed in
   a model but nice to have for code checking.  For instances, the run flag for an HCM is usually
   not needed for modelly but some code you write may want to see it.  You could nowe set/get it with
       setpv('HCM','RunFlag',0); 
       getpv('HCM','RunFlag'); 

2008 - January
1. Small bug in mmlview when devices status is zero.
2. LocoMeasData.DeltaAmps got changed to physics units at some point, now is back to hardware units.

2007 - December
1. Small improvements to plotmemberof, hw2physics, physics2hw, getrunflag
2. Energy scaling of response matrices improved getpv, getpvonline, setpv, setpvonline handled strings better 
3. New ringpara function from Xiaobiao Huang (Spear) � like atsummary but it compares much better to MAD

2007 - October
1. Small improvements to plotmemberof, hw2physics, physics2hw, getrunflag
2. More LOCO fixes
3. Improved the plotting in modeltwiss, modeleta, modeldisp, etc.
4. New labca with a memory leak fix for lcaPutNoWait.

2007 - September
1. setorbitbumpgui - added more general editing of corrector magnets lists and removing a 
                     bump now can be done in steps.
2. AT - 64-bit linux binaries added
3. New LOCO code with new scaled Levenburg-Marquardt method (more to come)

2007 - August
1. getsigma('Physics') had a bug when the offset orbit was nonzero.
2. getdata and getrespmat check for default units and call hw2physics or physics2hw, if necessary.
3. AT no longer comes with .dll extensions.  If you need them they�re in <MMLRoot>\at\simulator\element\obsolete\dlls.  .mexw32 is the newer PC extension.  

2007 - July
1. findmemberof has an optional flag to return after the first family found.  This was 
   added to speed up functions like gethbpmfamily.
2. gethbpmfamily, getvbpmfamily, gethcmfamily, getvcmfamily will error if it cannot find the memberof field.
   Mandatory MemberOf Fields:  'HBPM', 'VBPM', 'HCM', 'VCM', 'Tune Corrector', 
                               'Chromaticity Corrector', 'Dispersion Corrector'
   MemberOf Fields sometimes used: 'BPM', 'COR', 'QUAD', 'SEXT', 'BEND', 'Magnet'
3. common2dev � Family output will only be one row if they are all the same
4. plotfamily � new bar graph, auto-scale is based only on the data visible in the plot, menu 
                to disable setpoint changes, and resize now changes the whole figure (normalized).
5. New functions: plotmemberof, plotquad, cdmachine
6. I added linkaxis(handle, 'x') a lot of places

2007 - June
1. Improved LOCO, plotfamily, getrespmat, incavityon, and a few more
2. XML "toolbox" added to the release
3. For EPICS users, a new labca (3.0) is available.
4. Standalone compile example in .../machine/ALS/StorageRing/Compile/StandAlone
5. 64-bit Solaris compiles included for AT and mysql toolboxes.

2007 - May
1. New LOCO files with parameter weighting.
2. The labca setpv default changed from lcaPutNoWait to lcaPut
3. setrf default device list changed to [] instead of [1 1]

2007 - April
1.  Beam based alignment of quadrupoles
    a. bpm2quad, quad2bpm now has a 'Upstream' and 'Downstream' flag
    b. quadcenter now works on transfer lines using downstream BPMs
2.  getbpmaverages needs a DeviceList input.  It can return all devices or 1 if empty.  
    This required small changes to setpv, getbpmsigma, monbpm, measlocodata, and 
    quadcenter.  To save cpu time, getbpmaverages often return only 1 device by default.
3.  orbitcorrection methods changed to use gethbpmfamily, and new outputs added.
4.  drawlattice changed for combined function sextupoles and correctors (like at ASP)
5.  setrf changed for multiple cavities (needed for simulator).
6.  changed measdisp for [1 1] -> [] for RF
7.  Added AD.Directory.QMS  = [AD.Directory.DataRoot, 'QMS', filesep]; to setmmldirectories (Eugene Tan)
8.  Changed the default units for the chromaticity functions, measchro, setchro, stepchro, to physics units.  
    Most people prefer physics units some people really don't like hardware units.  Note that the golden 
    has always been stored in physics units.  If you use the common menu of plotfamily for chromaticity 
    setting, you should update plotfamily.
9.  Small changes and bug fixes to plotfamily.
10. Output OCS. Incremental always is 0 in the output 1 of setorbit.  That way, OCS=setorbit('NoSetPV') 
    can be use to check what will be changed then directly use to correct the orbit (setorbit(OCS) or 
    setorbit(OCS,'NoGetPV')).  This worked before for absolute change but not incremental changes.
11. New mml/at functions written by ASP: machine_at, ffttunedisp2, printlattice, plottwiss 
12. New mml function: getnumberofsectors

2007 - March
1. New functions: 
   a. bpmresp2loco - to convert an MML response to LOCO units
   b. rmgolden, reoffset - to more easily remove the a golden or offset value
2. Made a same change to locodata when exporting response matrices to divide by the total magnitude
   of the kick and not just the in-plane kick strength.
3. getpv/setpv: a. SP-AM error printout 
                b. Empty Family or cell inputs return without error.
4. setorbit - added a tolerance check to limit the number of iterations.  
              OCS.NCorrections is the actual number of corrections done.
            - option to step the correctors & RF in multiple steps (also added to setorbitbumpgui.
            - OCS.IncrementalFlag (yes/no) changed to OCS.Incremental (1/0)
5. orbitcorrectionsmethods � added column weights
6  steprf now uses setpv with an �incremental� flag 

2007 - February
1. Made "help mml" more interesting.  Hypertext in the command window is often helpful (also see alsinfo)
2. New application: setorbitbumpgui (like always, there is a menu in plotfamily to it)
3. checklimits and setorbit updated for checking limits when maxsp<minsp.  Yes, this can happen
   when working in physics units.
4. Added a 'DrawLattice' flag to modeltwiss to draw the lattice on the plot.
5. Added a few sound functions: soundtada, sounderror, souddchord, soundquestion
6. Labca help files moved off the path since it interfered with compiling in standalone on unix.
7. meastuneresp did not have the proper delay (2.2*getfamilydata('TuneDelay')) after setting a quadupole family.
8. monmags made more time efficient by always getting data in hardware units and including an option 
   to exclude BPM data.  I also added a flag to plot after a raw2real is done.  In the future I plan
   to exclude a raw2real in getrunflag so that gain/offset difference between the setpoint & monitor
   can be removed and the .Tolerance field does not have to be increased.

2007 - January
1. plotfamily, mmlviewer, setorbitgui, drawlattice -> made small improvements like removed the 
   visibility of the handles.
2. modeltwiss - bug fix when Twiss parameters inputs are not in the AT model.
3. setpv - Added an Ignor condition for ErrorWarningLevel = -2 and a beep if the dialog box appears. 
4. Added ErrorWarningLevel = -2 to quadcenter.  It's gets reset on exit.  The default 
   ErrorWarningLevel is usually set in setoperationalmode.
5. LabCA - Changed setpvonline to use lcaPutNoWait.  It's much faster.  
           If anyone wants to use lcaPut as the default I could make it a setup flag.
           To speed up lcaGet, I would advise setting, 
           lcaSetRetryCount(1000);
           lcaSetTimeout(.005);
           I usually set this in setoperationalmode.
6. For EPICS users, I changed the LabCA distribution to the 2_1_beta release.
7. Bug fix in setorbitbump when the goal BPMs are the first or last BPMs in the ring.
8. New mysql database toolbox (this one handles BLOBs).
9. Changed setpv to wait 2.2*AD.TuneDelay on WaitFlag=-3 to be consistent with BPM delay.
   Usually, this variable is set in the setoperationalmode file.

2006 - December
1. plotfamily - Bug with reseting a setpoint change when selecting from list box #2. 

2006 - October
1. mmlviewer - a GUI for viewing the MML setup and lattice files. 
2. Calccoupling � Calculate and plot couple of in the AT model (written by James Safranek).  
   It is often run on a model that has been calibrated with LOCO.
3. Transfer lines � functions like getpvmodel, setpvmodel, getbpmresp, modeltwiss were updated to 
   handle transfer lines.  Add MML varable AD.MachineType = �Transfer� to make them work.  The default 
   is AD.MachineType = �StorageRing�.
   getpvmodel, setpvmodel changed to get/set the TwissData variable.  This is needed
   (Removed the old LaunchVector variable.)   If you have a transfer line function to contribute 
   to the MML release send it to me.
4. isstoragering, istransfer, isbooster
5. copychicaneresp copied to mml directory since a number of laboratories use it.
6. Removed AT .dll�s, the new windows mex file extension is mexw32.
7. getpv/setpv can now change variables in the MML setup structure (AO/AD) like
   setfamilydata and getfamilydata.
8. setorbitbump: fixed for units override, change the output arguments, change the definition
   of OCS.CM.Data when using the 'NoSetSP' flag (see help setorbit, note #4 for more details).
9. I converted many conditional statements that had "|" or "&" to "||" or "&&".  This caused
   a couple bugs.  I hope there are not more.  As always, let me know if you find anything
   wrong with any function.
10. When using structures there was a problem with some function getting the units from the input structure.  
    Like, AM1 = getx('Physics','Struct') is physics units.
          AM2 = getx(AM1) is also physics units.
    But, getgolden, getoffset, getgain, ... needed to be fixed to return the proper units.

2006 - September
1. setorbitgui - a GUI for running the setorbit program.  Use setorbitsetup to 
   custumize the setting for a particular accelerator.
2. Added a check for special functions to getpv/setpv when an 'online'
   input override is done.
3. Removed labca default changes from switch2online.  Put it in setoperationalmode
   if you need it.
4. Matlab release 2006b does not alow pack from within a function so 
   it was removed from loco. Other small changes were made to locogui.
5. Added buildlocoinput to the loco directory.  buildlocoinput is all the 
   accelerator independent stuff.  It will call buildlocofitparameters to
   get the accelerator dependent stuff.
7. Added a 'MinimumBeamCurrent' flag to measbpmresp and measrespmat. 
   For instance, measbpmresp('MinimumBeamCurrent', 32.1)  
   will pause at a beam current of 32.1 and prompt for a refill.
  
2006 - August
I've made lots of changes to the matlab middle layer software this month!
The main thing is you can't install it over an old installation!!!  This one 
has a whole new directory layout.  One way to do the installation is:
A. Rename the old middle layer root directory.
B. unzip MiddleLayerRelease.zip in the middle layer root directory <ROOT>
C. Rename your data directory to the new MML directory.  For the ALS storage
   ring I would rename ALSData to /machine/ALS/StorageRingData
D. "run <ROOT>mml\setpathmml" to select an accelerator or
   "run <ROOT>mml\setpath<NAME>" for your machine
E. I find plotfamily is a good program to test the new software.
F. If you need to copy old files in the the machine specific directory to the new
   location (<ROOT>machine\<NAME>) be careful not of overwrite files:
   aoinit, setoperationmode, plotfamilystartup, and maybe updateatindex.

Changes:
1. We (Eugene Tan and I) made it hopefully easier to have multiple accelerators running at
   at the same time.  There are many ways to do it so we will present 2 of them in with this
   release so that they can be experiemented with.

   a. Treat each accelerator independently:  AO, AD, AT deck
      ASP example:  LTB, Booster, BTS, StorageRing
      Comments: 
      1. The same families names can be used in each MML.  Like, BPMx, BPMy, BEND, QF, QD etc.
         This makes it easier to use the same function, like setorbit, work on different 
         types of accelerators.
      2. It's easier on functions like plotfamily and setmachineconfig to know what to do.  

   b. Combine mulitple accelerators in one AO, AD, but switch the AT deck depending on the MML family.
      ASP example:  Injector (combines the LTB, Booster, & BTS)
      Comments: 
      1. Functions that use say the Booster and BTS can be written without changing the MML.
         but it requires different family names.  This could make it more difficult to to 
         write machine independent applications.
      2. Saving the entire injector configuation can be done together (or not).
      3. The default plotfamily is the booster, use "plotfamily LTB" or "plotfamily BTS" to plot 
         the LTB or BTS.
      4. Fast switching of the AT model is done with a new AO field (ATModel) and prefilling
         global variable THERINGCELL with all the models.

2. plotfamily can be called with an input.  For example,
   plotfamily BTS
   will only plot families where BTS was a MemberOf that family.

3. New directory tree!  Look in the Install section below to see the new tree.
   Note: machine directories aoinit, setoperationalmode, and updateatindex were likely changed
         for the new MML release.

4. plotfamilystart - added a sector menu

5. BPMx, BPMy, HCM, VCM must be a MemberOf some family in order for defaults to work properly!

6. Added HTML help files (directory, <MML Root>\doc_html).  Files are automatically generated 
   using m2html which is freeware on MatlabCentral.  I think it's a good way to find functions 
   without having to look through directories.  This program takes the Matlab function help lines 
   (the comments at the top of the file) and turns them into HTML.  It also shows dependences.
   (Thanks to Laurent for introducing me to this application.)

7. I added more accelerators to the release (and more to come).

8. getrespmat had an error when replacing NaN's for missing actuators with limit checking
   when the DeviceList is empty.

9. Common names can now be used instead of family names.  I also improved the speed of 
   the functions that manipulate common names.

10. Improved the help at the top of many files.



2006 - July
1. steppv - bug fix when changing the mode as a keyword.  For instance, when working online, 
            stepsp('HCM','Simulator') would get the present setpoint from online and not the model.
2. setorbit - small changes to the graphics.


2006 - June
1. plotfamily - Added a slider and editbox to change setpoints.  Click on a lattice element
                to enable.  Click on a drift or BPM to turn off.
2. Bug fix in inputparsingffd for structure inputs.
3. Bug fix in LOCO when fitting energy shifts at correctors with noralization on.


2006 - May
1. New functions: gethbpmfamily,getvbpmfamily, gethcmfamily, getvcmfamily
   Use these function to get default family names.
2. getbpmresp/measbpmresp now uses MemberOf field to find default families.
   If anyone finds a function that does not use defaults properly, let me know.  
3. Fixed some bugs with measbpmresp and measrespmat (found by Diamond Light source, thanks).
4. Better limit checks added to measrespmat.
5. getturns, multiturnfft changed and improved.
6. plotfamily lattice location changed and callbacks added if clicked on.  Note:
   horizontal correctors on above the axis and vertical below.


2006 - March
1. setmachineconfig - option to interatively select what to set by using the 'Display' input.
2. mkparamgroup is distributed with AT.  Another, slightly different, version 
   was distributed with with the middlelayer now it's part of LOCO.
3. Expanded the Field input getpvmodel and setpvmodel to handle common model
   functions, like magnet tilts and setting multipole components.   
   'K','Quad','Quadrupole'
   'K2','Sext','Sextupole'
   'K3','Octupole'
   'KS1','SkewQuad','Skew'
   'Roll','Tilt' 

   getpvmodel also handles single turn data and tranport lines:
   'xturns', 'Pxturns', 'yturns', 'Pyturns', 'dpTurns', 'dLturns' 
   See help setpvmodel and help getpvmodel for more d tails. 


2006 - January
1. Fixed an error in plotfamily when changing the device list.
2. Added Christoph's function for analyzing single turn data: findfreq and calcphase   


2005 - December
1. When using fuction handles in hw2physics and physics2hw (HW2PhysicsFcn and Physics2HWFcn) 
   the energy input in passed as a vector instead of looping.  This allows for faster 
   execution times because vectorized math can now be done in the HW2PhysicsFcn and Physics2HWFcn 
   functions.  This may require users to add vectorized math to the lower level functions
   like amp2k and k2amp. 
2. Updated the AccObj directory.
   See MiddleLayerObjects.doc for infomation about objects.
   Using objects is just a fun experimental side-show of mine.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
1. Install directions:
   a.  There's a compressed file on http://controls.als.lbl.gov/als_physics/portmann/MiddleLayer/
       with the entire Matlab Middle Layer.  I also included the entire directory tree if 
       you just want select files.  The top level MML directory tree is the following.

       Matlab MiddelLayer Toolbox  (MML)
       <ROOT>\MML
       <ROOT>\MML\links
       <ROOT>\MML\at

       Machine Directories (using ALS as an example)
       <ROOT>\machine\ALS\Booster
       <ROOT>\machine\ALS\BoosterData
       <ROOT>\machine\ALS\BoosterOpsData
       <ROOT>\machine\ALS\BTS
       <ROOT>\machine\ALS\BTSData
       <ROOT>\machine\ALS\BTSOpsData
       <ROOT>\machine\ALS\LTB
       <ROOT>\machine\ALS\LTBData
       <ROOT>\machine\ALS\LTBOpsData
       <ROOT>\machine\ALS\Ring
       <ROOT>\machine\ALS\RingData
       <ROOT>\machine\ALS\RingOpsData

       Matlab to control system link libraries
       <ROOT>\links\mca
       <ROOT>\links\mca_asp
       <ROOT>\links\sca
       <ROOT>\links\ucode
       <ROOT>\links\tango

       Applications
       <ROOT>\applications\common
       <ROOT>\applications\loco
       <ROOT>\applications\orbit
       <ROOT>\applications\database\mym
       <ROOT>\applications\m2html
       (maybe more)

       AT - Accelerator Toolbox
       <ROOT>\at


   b.  Run the appropriate set path function.
       >>  run <ROOT>mml\setpathmml

       Or for a specific facility, like ALS,
       >>  run <ROOT>mml\setpathals

       As long as the MML subdirectory layout is not changed, the entire
       tree can be moved anywhere.  The path is set by the location of the 
       setpathmml or setpath<machine> function.

       A good test is to run plotfamily.  Try getting an orbit, adding the
       lattice drawing to the plot, etc.  There are about 15 rings presently simulated.
       Look in the machine directory to see which accelerators you have.
       Usually the ALS, ASP, Spear3, PLS, XRay, VUV, SPS are the accelerators distributed
       with the release.  If you want the setup files for another accelerator
       it's best to contact them directly.  I don't give out the setup software
       for other accelerators without their consent.

   c.  You might need to change which Matlab-to-control system link to use.
       Look in the acceleratorlink directory to see what's available.  These 
       packages are written by various people.  See the respective authors 
       for the lastest release.  The middle layer has been linked to other 
       control systems besides EPICS -- ucode & tango.  Contact me if you 
       want help connecting the Matlab Middle Layer to an unsupported system
       (it's usually not that difficult to do).
       
       1. MCA     (EPICS) - Andrei Terebilo at SLAC/SSRL
       2. MCA_ASP (EPICS) - Australian Light Source
       3. LabCA   (EPICS) - Till Straumann at SLAC
       4. SCAIII  (EPICS) - Greg Portmann at ALS
       5. Tango - Laurent Nadolski at Soleil (not in the distribution)
       6. UCODE - Just for Brookhaven  ational Laboratory
       7. SLC   - Just for SLAC (not in the distribution)

       Note: For EPICS users:
       1. MCA or MCA_ASP does not need any additions to environment variables.
       2. If using labCA or SCA the library path will need to be changed.
       For example:
          a. LabCA on Solaris, add to the LD_LIBRARY_PATH
             <MiddleLayerDirectory>acceleratorlink/labca/lib/solaris-sparc
          b. SCA on Solaris, add to the LD_LIBRARY_PATH
             <MiddleLayerDirectory>acceleratorlink/sca/lib/solaris-sparc

   d. The AT simulator and LOCO are not needed for the middle layer but it's very nice
      to have them working.  I include them in the distribution.  The AT version is the one I
      use and have tested with the Middle Layer and LOCO.  For the latest AT release and
      important information about changes to AT see Andrei's website.
                  http://www.slac.stanford.edu/~terebilo/at/
      The matlab version of LOCO was a collaborative effort between James SaFranek, Andrei
      Terebilo, and myself.  I distribute the latest version with the MML.  
      
      Note: The new AT does not work on linux when using a Matlab version
            less than 7.  I'm not sure why, but I prefer to upgrade Matlab or use
            an older AT version than to figure it out.  The setpath<machine> function
            will select the proper version.  However, if using an older AT, then
            the environmental variable ATROOT needs to be defined.
            ATROOT = <MiddleLayerDirectory>/at_old
            The new AT does not require an environmental variable ATROOT.

2. To create a setup for a new accelerator look at the ALS or a simpler ring like vuv for an
   example.  The basics tasks are the following.
   a. Write a setpath<machine> file in acceleratorcontrol
   b. Create new accelerator directories under the machine directory.
      Write a new aoinit, setoperationalmode, and updateatindex files as well
      as an AT deck.
   This process usually takes a couple days to get correct.  Look in the
   MiddleLayerManual.doc in the docs directory for some guidance.  Since the
   setup is not well documented feel free to contact Jeff Corbett or myself
   for more help.

3. If you find any bugs in the software please contact me.  I'm trying to make
   the software as bug free as possible.  Also, if you write a new function that 
   would be useful for other accelerators please send it to Jeff Corbett or 
   myself to be included in future releases.

4. Matlab versions:  I mainly use Matlab 7.2.0 (R2006a) on the Solaris (sol2),
                     Linux (glnx86), and Windows XP (pcwin).  I also use Matlab 6.5 on 
                     Windows XP.  I recommend using Matlab 7.2.  Applications written in 
                     Matlab 7.2 can also run in standalone mode with minimal effort (except 
                     that the toolbox to create standalone application is an expensive 
                     add-on to Matlab).

                     

