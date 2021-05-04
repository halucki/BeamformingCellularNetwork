% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 5-June-2020
% Developed in Matlab R2019b

close all
clear 

%% SET PARAMETERS
global U
[U, Iter, R]=PickCell; %Number of users, Number of Iterations and Radius

%R is the radius (centre to vertice) of Hexagon in km. 
r=sqrt(3)*R/2;  %r is the  centre to edge in km. 

[B_MHz, fc_MHz, Ptx, htx, hrx]=UserInput; %create dialog box with predefined 
%values that can be changed. If the value inserted by the user is invalid,
%it creates a warning. 

%% Cell type
global celltype
if R>=1.2
    celltype="Macrocell:";
elseif R>0.2 && R<1.2
    celltype="Microcell:";
elseif R<=0.2 && fc_MHz>25000
    celltype="mmWave Picocell:";
elseif R<=0.2 && fc_MHz<=20000
    celltype="Picocell:";
end 

%% Centre at the origin (0,0)
Cxo=0;   
Cyo=0; 

%% Vertices of the hexagon. Angles in degrees: 0, 60, 120, 180, 240, 300, 360. 
t=(0:pi/3:2*pi); %angles. increment of pi/3 (60 degrees)
xv=Cxo+R*cos(t);   
yv=Cyo+R*sin(t);
figure(1)

%% Define x and y coordinates of U_store random users. 
%UNIFORM distribution of U,
%since there is a chance they may be outside the hexagon region
% & at least U users need to be inside the hexagon
global U_store
U_store=Iter*U; %maximum number of coordinates being stored (if all users
%actually are inside the region)

% preallocating the size of the matrix
xqtrial=zeros(Iter,U);
yqtrial=zeros(Iter,U);
xoriginal=zeros(Iter,U);
yoriginal=zeros(Iter,U);
for i=1:Iter
        xqtrial(i,:)=Cxo+R-(R+R)*rand(1, U);  % U random numbers in the 
        %interval (a,b) with the formula k = a + (b-a)*rand(1,U),
        %in this case U_store random numbers in the interval (-R, R),which 
        %are the horizontal extremes (vertices)
        %the formula is k=R+(R-(-R))*rand(1,U_store)

        yqtrial(i,:)=Cyo+r-(r+r)*rand(1, U);  % U_store random numbers 
        %in the interval (-r, r) because the extreme height of hexagon is r, 
        %so k=r+(r-(-r)).*rand(1,U_store)
        xoriginal=xqtrial;
        yoriginal=xqtrial;
end

[in,on]=inpolygon(xqtrial, yqtrial, xv, yv);
xypassornot=in; %indicates whether that index passed the polygon test or not
for u=1:U
    for i=1:Iter
        while isequal(in(i,u),0) %if it didn't pass the test, replace it by
            %a new random coordinate
            xqtrial(i,u)=Cxo+R-(R+R)*rand(1, 1);
            yqtrial(i,u)=Cxo+r-(r+r)*rand(1, 1);
            [in,on]=inpolygon(xqtrial, yqtrial, xv, yv); %check if it 
            %passed the test in order to exit the loop
        end   
    end 
end

% turns xqtrial and yqtrial into 1 x U_store vectors (row vectors)
% the first row is allocated exactly as it was on the qtrial version and the
% rows below are placed on the right hand side of the first row 
% [row 1
%  row 2
%  ...
%  row Iter]
%  becomes [row 1 row 2 ... row Iter]
xqlin=reshape(xqtrial',[1,U_store]);
yqlin=reshape(yqtrial',[1,U_store]);

%% Plot Cellular Network
% ensures that there are only U out of U_store points on the plot. 
% only the 1st iteration is plotted
for u = 1 : U
    %plot the users (dots) according to their x and y coordinates
    plot(xqlin(1, u), yqlin(1, u), 'b*');
    %only the 1st iteration is plotted
    hold on; 
end

% Random Colour
randColour=randomColour(1); %returns the vector of colours in a random order

% Central cell
patchplot(xv, yv, Cxo, Cyo, randColour(1));

% Lower left cell - 1st tier interferer
Cxll=Cxo-sqrt(3)*r;
Cyll=Cyo-r;
patchplot(xv-sqrt(3)*r, yv-r, Cxll, Cyll, randColour(1));

% Lower right cell - 1st tier interferer
Cxlr=Cxo+sqrt(3)*r;
Cylr=Cyo-r;
patchplot(xv+sqrt(3)*r, yv-r, Cxlr, Cylr, randColour(1));

% Upper right cell - 1st tier interferer
Cxur=Cxo+sqrt(3)*r;
Cyur=Cyo+r;
patchplot(xv+sqrt(3)*r, yv+r, Cxur, Cyur, randColour(1));

% Upper left cell - 1st tier interferer
Cxul=Cxo-sqrt(3)*r;
Cyul=Cyo+r;
patchplot(xv-sqrt(3)*r, yv+r, Cxul, Cyul, randColour(1));

% Lower cell - 1st tier interferer
Cxl=Cxo;
Cyl=Cyo-2*r;
patchplot(xv, yv-2*r, Cxl, Cyl, randColour(1));

% Upper cell - 1st tier interferer
Cxu=Cxo;
Cyu=Cyo+2*r;
patchplot(xv, yv+2*r, Cxu, Cyu, randColour(1));

axis square; %Use axis lines with equal lengths
title(string(celltype)+" "+'Hexagonal model for a 7-cell cellular network'+...
'(1st tier interferers)');
hold off;

%% Basestation centres
Cxi=[Cxll, Cxlr, Cxur, Cxul, Cxl, Cxu];
Cyi=[Cyll, Cylr, Cyur, Cxul, Cyl, Cyu];

%% Calculates the distance and azimuth angle of departure between the central 
% Basestation and User
global d_U2BSo
d_U2BSo=zeros(U_store,1); 
d_U2BSocheck=zeros(U_store,1); 
angledep_centralBSUE=zeros(U_store,1);
anglearriv_centralBSUE=zeros(U_store,1);
for U_s=1:U_store
       [d_U2BSo(U_s,1), angledep_centralBSUE(U_s,1),...
           anglearriv_centralBSUE(U_s,1)]=distanceangle([Cxo Cyo],...
           [xqlin(U_s) yqlin(U_s)]); 
       %calculates the distance between central BS and UE, angle of
       %departure and angle of arrival in degrees
end 
sortDist=sort(d_U2BSo); %sorts the elements of d_U2BSo in ascending order

%% Distance between each user and each of the 6 base stations
global d_U2BSi
d_U2BSi=zeros(U_store,6); %preallocating size by creating a U_store x 6 matrix
angledep_interfBSUE=zeros(U_store,6);
anglearriv_interfBSUE=zeros(U_store,6);

for U_s=1:U_store 
     for b=1:6 %6 neighbours cells
        [d_U2BSi(U_s,b), angledep_interfBSUE(U_s,b),...
            anglearriv_interfBSUE(U_s,b)]=distanceangle([Cxi(b) Cyi(b)],...
            [xqlin(U_s), yqlin(U_s)]); 
        %calculates the distance between each of the interfering BS and a
        %central UE, the angle of departure and angle of arrival in degrees
     end
     %each of the U_s users has its own row. each column is the distance 
     %between the user and one of b the basestations
     %U_s rows, b columns
end

%% Thermal Noise
T = 290; %this is the standardized temperature in Kelvin. 16.85 in  Celsius
k = physconst('Boltzmann'); %Boltzmann constant: 1.38*10^-23 J/K
NF=10; %Noise figure value set to 10dB

global Ptx_dBm
Ptx_dBm=pow2dbm(Ptx); %converting transmitted power to dBm
B=B_MHz*10^6; %converting bandwidth to Hz
fc=fc_MHz*10^6; %converting carrier frequency to Hz

% Thermal noise floor (considering the figure of noise)
Noise=k*T*B*10^(NF/10); %in Watts
Noise_dB=10*log10(k*T*B)+NF; %in dB
Noise_dBm=Noise_dB+30; %in dBm.
%Thermal noise as ­173.9 dBm/Hz (without the NF), which is the amount of 
%noise in 1 Hz bandwidth.

%% Models
global otherInputs
otherInputs=[50, 30, 0]; %creates a 1-by-3 matrix of zeros, which are 
%parameters of the Non-LOS Cost231-Walfish-Ikegami model
global cbx_out_text
[cbx_out_value, cbx_out_text, bg_out_text]=checkboxPLmodels; %check the path loss
%models that you would like to use

% if the model was ticked it returns 1, otherwise it returns 0
fs=cbx_out_value(1); 
oh=cbx_out_value(2);
c231h=cbx_out_value(3); 
LoS=cbx_out_value(4); 
nonLoS=cbx_out_value(5);
c231wi=cbx_out_value(6); 
sui=cbx_out_value(7);
ecc33=cbx_out_value(8);

% returns the city or environment selected for the model as a  string
env_oh=bg_out_text(1);     %Urban, Suburban or Open area
city_oh=bg_out_text(2);    %Large or Small/Medium
env_c231h=bg_out_text(3);  %Metropolitan centres or Medium city/Suburban
city_c231h=bg_out_text(4); %Large or Small/Medium
env_c231wi=bg_out_text(5); %Urban or Suburban
city_sui=bg_out_text(6);   %A, B or C 

if isequal(LoS, 1)&&isequal(c231wi,1)
    c231wiLoS=1;
else
    c231wiLoS=0;
end
if isequal(nonLoS, 1)&&isequal(c231wi,1)
    c231winonLoS=1;
else
    c231winonLoS=0;
end

%% Path loss calculations

% FSPL
PL_fs=FreeSpace(fc_MHz, d_U2BSo, "MHzkm");

% Okumura-Hata
global O_oh
O_oh=[string(env_oh), string(city_oh)];
PL_oh=OkumuraHata(fc_MHz, d_U2BSo, htx, hrx, O_oh);

% Cost231-Hata
global O_c231h
O_c231h=[string(env_c231h), string(city_c231h)];
PL_c231h=Cost231Hata(fc_MHz, d_U2BSo, htx, hrx, O_c231h);

% Cost231-Walfish-Ikegami
global O_c231wi
O_c231wi=string(env_c231wi);
PL_c231wi_LoS=Cost231WalfishIkegami(fc_MHz, d_U2BSo, htx, hrx, PL_fs,...
    "LoS", O_c231wi, otherInputs);
PL_c231wi_nonLoS=Cost231WalfishIkegami(fc_MHz, d_U2BSo, htx, hrx, PL_fs,...
    "Non-LoS", O_c231wi, otherInputs);

% SUI
global O_sui
O_sui=string(city_sui);
global s
if O_sui=="A"
    s=10.6; %for urban
elseif O_sui=="C" || O_sui=="B"
    s=8.2; %for rural
else
    s=8.2+((10.6-8.2)*rand(1,1)); %lognormally distributed factor to account
%for shadow fading
end
PL_sui=SUI(fc_MHz, d_U2BSo, htx, hrx, O_sui, s);

% ECC33
PL_ecc33=ECC33(fc_MHz, d_U2BSo, htx, hrx);

% turns the PLs into a 7xU_store matrix (7 is the number of models)
PL(1,:)=PL_fs(:);            %model 1 is FSPL
PL(2,:)=PL_oh(:);            %model 2 is Okumura-Hata 
PL(3,:)=PL_c231h(:);         %model 3 is Cost231-Hata
PL(4,:)=PL_c231wi_LoS(:);    %model 4 is LOS Cost231-Walfish-Ikegami
PL(5,:)=PL_c231wi_nonLoS(:); %model 5 is Non-LOS Cost231-Walfish-Ikegami
PL(6,:)=PL_sui(:);           %model 6 is SUI
PL(7,:)=PL_ecc33(:);         %model 7 is ECC33

figure(2)
% Path Loss versus Distance
loop=[fs, oh, c231h, c231wiLoS, c231winonLoS, sui, ecc33];

ifplot(sortDist, PL, loop)
hold off
xlim([0 R]);

%% Bandwidths
B_Cell_MHz=B_MHz; %bandwidth of each of the 7 cells
global B_User_MHz
B_User_MHz=B_Cell_MHz/U; %user bandwidth in MHz

%% %%%%%%%%%%%%%%%%%%%%%%%%%% ISOTROPIC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ISOTROPIC / NO  GAIN -> Antenna gain is always  1
%% Sum of the received powers of the 6 BSs (the ones surrounding the central BS)
ISO_gain=ones(6,U_store);
PrxsumISO=sumInter(fc_MHz, Ptx_dBm,U_store, ISO_gain, htx,hrx);

%% SNR & SINR 
Gtx=1; %no beamforming. Isotropic antennas
Grx=1; %no beamforming. Isotropic antennas
[PrxISO_dBm, SNRISO_dB, SINRISO_dB]=SNR_SINR(Ptx_dBm, PL, Noise, Noise_dBm,...
    PrxsumISO, Gtx, Grx);

%% SINR (30dB limited) limited metrics:
%%eta(Bandwidth Efficiency), User Throughput, Cell Throughput and SINR
[etaISOlim, C_UserISOlim, C_CellISOlim, SINRISOlim_dB, ~,~,...
    ~]=Throughputs(SINRISO_dB, B_User_MHz, U_store, U);

figure(3)
subplot(1,4,1)
ifecdf(SNRISO_dB, loop, 'SNR(dB)')

subplot(1,4,2)
ifecdf(SINRISOlim_dB, loop, 'SINR(dB)')

subplot(1,4,3)
ifecdf(C_UserISOlim, loop, 'User throughput in Mbits/sec')

subplot(1,4,4)
ifecdf(C_CellISOlim, loop, 'Cell throughput in Mbits/sec')
hold off

%% Gain according to the angle between each user and each of the base stations
   % M = 4, M is the number of antenna elements
   % K = 8, K is the number of beam  patterns
[best_gain48, best_idx48, worst_gain48, worst_idx48, rand_gain48, rand_idx48,...
    ~]=beamforming3c720(fc_MHz, angledep_centralBSUE, 4, 8, "Not", 100);
%relative to  the central cell

[best_gain48i, best_idx48i, worst_gain48i, worst_idx48i, rand_gain48i, ...
    rand_idx48i,~]=beamforming3c720(fc_MHz, angledep_interfBSUE, 4, 8,...
    "Not", 100); 
%i stands for interferers (the 6 cells surrounding  the main cell)


%% %%%%%%%%%%%%%%%%%%%%%%%%%% CASE A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% "BEST BEAM COMBINATION" / "MAXIMUM SINR TRANSMITTING BEAMFORMING" CASE ->
% Antenna gains of the 6 interfering cells are as low as possible (so the 
% interference is low) and antenna gain of the central cell is maximised 
% (improves SINR)
%% Sum of the received powers of the 6 BSs (the ones surrounding the central BS)
PrxsumA=sumInter(fc_MHz, Ptx_dBm, U_store, worst_gain48i, htx, hrx);

% beamforming at the transmitters of  the other  6 BSs. picks the beam with
% the worst gain amongst the available beams
%% SNR & SINR 
GtxA=best_gain48; %beamforming at the transmitter. picks the beam with
% the best gain amongst the available beams
GrxA=1; %no beamforming on RX side
[PrxA_dBm, SNRA_dB, SINRA_dB]=SNR_SINR(Ptx_dBm, PL, Noise, Noise_dBm,...
    PrxsumA, GtxA, GrxA);

%% SINR (30dB limited) limited metrics:
%%eta(Bandwidth Efficiency), User Throughput, Cell Throughput and SINR
[etaAlim, C_UserAlim, C_CellAlim, SINRAlim_dB, ~,~,...
    ~]=Throughputs(SINRA_dB, B_User_MHz, U_store, U);

%% %%%%%%%%%%%%%%%%%%%%%%%%%% CASE B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RANDOM CASE -> Antenna gains of the 6 interfering cells are random 
% and antenna gain of the central cell is also random
%% Sum of the received powers of the 6 BSs (the ones surrounding the central BS)
PrxB=sumInter(fc_MHz, Ptx_dBm,U_store, rand_gain48i, htx, hrx);

%beamforming at the transmitters of  the other  6 BSs. picks a random beam 
%% SNR & SINR 
GtxB=rand_gain48; %beamforming at the transmitter. picks a random beam
GrxB=1; %no beamforming on RX side
[PrxB_dBm, SNRB_dB, SINRB_dB]=SNR_SINR(Ptx_dBm, PL, Noise, Noise_dBm,...
    PrxB, GtxB, GrxB);

%% SINR (30dB limited) limited metrics:
% eta(Bandwidth Efficiency), User Throughput, Cell Throughput and SINR
[etaBlim, C_UserBlim, C_CellBlim, SINRBlim_dB, ~,~,...
    ~]=Throughputs(SINRB_dB, B_User_MHz, U_store, U);

%% %%%%%%%%%%%%%%%%%%%%%%%%%% CASE C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UNCOORDINATED CASE -> Antenna gains of the 6 interfering cells are maximised
% (so the interference is  increased). Antenna gain of the central cell
% is also maximised. Each BS is trying to look after its own users.

%% Sum of the received powers of the 6 BSs (the ones surrounding the central BS)
PrxsumC=sumInter(fc_MHz, Ptx_dBm, U_store, best_gain48i, htx, hrx);

% beamforming at the transmitters of  the other  6 BSs. picks the beam with
% the best gain amongst the available beams
%% SNR & SINR 
GtxC=best_gain48; %beamforming at the transmitter. picks the beam with
% the best gain amongst the available beams
GrxC=1; %no beamforming on RX side
[PrxC_dBm, SNRC_dB,SINRC_dB]=SNR_SINR(Ptx_dBm, PL, Noise, Noise_dBm, ...
    PrxsumC, GtxC, GrxC);

%% SINR (30dB limited) limited metrics:
% eta(Bandwidth Efficiency), User Throughput, Cell Throughput and SINR
[etaClim, C_UserClim, C_CellClim, SINRClim_dB, ~,~,...
    ~]=Throughputs(SINRC_dB, B_User_MHz, U_store, U);

%% %%%%%%%%%%%%%%%%%%%%%%%%%% CASE D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REALISTIC UNCOORDINATED CASE -> Antenna gains of the 6 interfering cells 
% are random and antenna gain of the central cell is maximised (improves SINR)
% The selected beam of each user of the interfering beams is random. 
% Each BS is trying to look after its own users.

%% Sum of the received powers of the 6 BSs (the ones surrounding the central BS)
PrxsumD=sumInter(fc_MHz, Ptx_dBm,U_store, rand_gain48i, htx, hrx);

%% SNR & SINR 
GtxD=best_gain48; %beamforming at the transmitter. picks the beam with
% the best gain amongst the available beams
GrxD=1; %no beamforming on RX side
[PrxD_dBm, SNRD_dB, SINRD_dB]=SNR_SINR(Ptx_dBm, PL, Noise, Noise_dBm,...
    PrxsumD, GtxD, GrxD);

%% SINR (30dB limited) limited metrics:
% eta(Bandwidth Efficiency), User Throughput, Cell Throughput and SINR
[etaDlim, C_UserDlim, C_CellDlim, SINRDlim_dB, ~,~,...
    ~]=Throughputs(SINRD_dB, B_User_MHz, U_store, U);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5)
plotecdf(SNRISO_dB,SNRA_dB, SNRB_dB, SNRC_dB, SNRD_dB,'n','n','n',loop, ...
    cbx_out_text, 'SNR(dB)', celltype);

figure(6)
plotecdf(SINRISOlim_dB,SINRAlim_dB, SINRBlim_dB, SINRClim_dB, ...
    SINRDlim_dB,'n','n','n',loop, cbx_out_text, 'SINR(dB)', celltype);

figure(7)
plotecdf(C_UserISOlim,C_UserAlim, C_UserBlim, C_UserClim, C_UserDlim,...
    'n','n','n',loop,cbx_out_text, 'User throughput in Mbits/sec', celltype);

figure(8)
plotecdf(C_CellISOlim,C_CellAlim, C_CellBlim, C_CellClim, C_CellDlim,...
    'n','n','n',loop,cbx_out_text, 'Cell throughput in Mbits/sec', celltype);

%% %%%%%%%%%%%%%%%%%%%%%%%%%% CASE D with different M and K %%%%%%%%%%%%%%%
%% REALISTIC UNCOORDINATED CASE -> Antenna gains of the 6 interfering cells 
% are random and antenna gain of the central cell is maximised (improves SINR)
% The selected beam of each user of the interfering beams is random. 
% Each BS is trying to look after its own users.

%% Gain according to the angle between each user and each of the base stations
% for different M and K values

%% M=2, K=4
[best_gain24, best_idx24, worst_gain24, worst_idx24, rand_gain24, rand_idx24,...
    ~]=beamforming3c720(fc_MHz, angledep_centralBSUE, 2, 4, "Not", 98);
% relative to  the central cell

[best_gain24i, best_idx24i, worst_gain24i, worst_idx24i,rand_gain24i, ...
    rand_idx24i,~]=beamforming3c720(fc_MHz, angledep_interfBSUE, 2, 4, "Not", 98); 
% i stands for interferers (the 6 cells surrounding  the main cell)

%% M=4, K=4
[best_gain44, best_idx44, worst_gain44, worst_idx44, rand_gain44, rand_idx44,...
    ~]=beamforming3c720(fc_MHz, angledep_centralBSUE, 4, 4, "Not",99);
% relative to  the central cell

[best_gain44i, best_idx44i, worst_gain44i, worst_idx44i, rand_gain44i,...
    rand_idx44i,~]=beamforming3c720(fc_MHz, angledep_interfBSUE, 4, 4, "Not",99); 
% i stands for interferers (the 6 cells surrounding  the main cell)

%% M=8, K=8
[best_gain88, best_idx88, worst_gain88, worst_idx88, rand_gain88, rand_idx88,...
    ~]=beamforming3c720(fc_MHz, angledep_centralBSUE, 8, 8, "Not",101);
% relative to  the central cell

[best_gain88i, best_idx88i, worst_gain88i, worst_idx88i, rand_gain88i, rand_idx88i,...
    ~]=beamforming3c720(fc_MHz, angledep_interfBSUE, 8, 8, "Not",101); 
% i stands for interferers (the 6 cells surrounding  the main cell)

%% M=8, K=16
[best_gain816, best_idx816, worst_gain816, worst_idx816, rand_gain816, ...
    rand_idx816,~]=beamforming3c720(fc_MHz, angledep_centralBSUE, 8, 16, "Not",102);
% relative to  the central cell

[best_gain816i, best_idx816i, worst_gain816i, worst_idx816i, rand_gain816i,...
    rand_idx816i,~]=beamforming3c720(fc_MHz, angledep_interfBSUE, 8, 16, "Not",102); 
% i stands for interferers (the 6 cells surrounding  the main cell)

%% M=16, K=16
[best_gain1616, best_idx1616, worst_gain1616, worst_idx1616,rand_gain1616,...
    rand_idx1616,~]=beamforming3c720(fc_MHz, angledep_centralBSUE, 16, 16, "Not",103);
% relative to  the central cell

[best_gain1616i, best_idx1616i, worst_gain1616i, worst_idx1616i, rand_gain1616i, ...
    rand_idx1616i,~]=beamforming3c720(fc_MHz, angledep_interfBSUE, 16, 16, "Not",103); 
% i stands for interferers (the 6 cells surrounding  the main cell)

%% M=16, K=32
[best_gain1632, best_idx1632, worst_gain1632, worst_idx1632, rand_gain1632,...
    rand_idx1632,~]=beamforming3c720(fc_MHz, angledep_centralBSUE, 16, 32, "Not",104);
% relative to  the central cell

[best_gain1632i, best_idx1632i, worst_gain1632i, worst_idx1632i, rand_gain1632i,...
    rand_idx1632i,~]=beamforming3c720(fc_MHz, angledep_interfBSUE, 16, 32, "Not",104); 
% i stands for interferers (the 6 cells surrounding  the main cell)


%% SNR & SINR: without adjusting randomness
[SNRD_dB24,SINRDlim_dB24,C_UserDlim24,C_CellDlim24]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gain24i, htx, hrx, best_gain24, 1,1);

[SNRD_dB44,SINRDlim_dB44,C_UserDlim44,C_CellDlim44]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gain44i, htx, hrx,  best_gain44,1,1);

[SNRD_dB88,SINRDlim_dB88,C_UserDlim88,C_CellDlim88]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gain88i, htx, hrx,  best_gain88,1,1);

[SNRD_dB816,SINRDlim_dB816,C_UserDlim816,C_CellDlim816]=calculateMK(U, PL, Noise,...
    Noise_dBm,fc_MHz, Ptx_dBm, U_store, rand_gain816i, htx, hrx,  best_gain816,1,1);

[SNRD_dB1616,SINRDlim_dB1616,C_UserDlim1616,C_CellDlim1616]=calculateMK(U, PL, Noise,...
    Noise_dBm,fc_MHz, Ptx_dBm, U_store, rand_gain1616i, htx, hrx, best_gain1616,1,1);

[SNRD_dB1632,SINRDlim_dB1632,C_UserDlim1632,C_CellDlim1632]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gain1632i, htx, hrx, best_gain1632,1,1);

SNRD_dB48=SNRD_dB; SINRDlim_dB48=SINRDlim_dB; 
C_UserDlim48=C_UserDlim; C_CellDlim48=C_CellDlim;

%% Plot Case D varying M & K
figure(10)
plotecdf(SNRISO_dB, SNRD_dB24, SNRD_dB44, SNRD_dB48, SNRD_dB88,SNRD_dB816,...
    SNRD_dB1616, SNRD_dB1632,loop, cbx_out_text, 'SNR(dB)', celltype);

figure(11)
plotecdf(SINRISOlim_dB, SINRDlim_dB24,SINRDlim_dB44,SINRDlim_dB48,...
    SINRDlim_dB88, SINRDlim_dB816, SINRDlim_dB1616, SINRDlim_dB1632,loop,...
    cbx_out_text, 'SINR(dB)', celltype);

figure(12)
plotecdf(C_UserISOlim, C_UserDlim24,C_UserDlim44,C_UserDlim48,...
    C_UserDlim88, C_UserDlim816, C_UserDlim1616, C_UserDlim1632, loop,...
    cbx_out_text, 'User throughput in Mbits/sec', celltype);

figure(13)
plotecdf(C_CellISOlim, C_CellDlim24,C_CellDlim44,C_CellDlim48,...
    C_CellDlim88, C_CellDlim816, C_CellDlim1616, C_CellDlim1632,loop,...
    cbx_out_text, 'Cell throughput in Mbits/sec', celltype);

figure(14)
plotHEATMAPmodels(SINRISOlim_dB, xqlin, yqlin, r, loop, cbx_out_text,...
    "SINR (dB)", celltype)

[ ~ , model]=pickModel; %select MAIN model


figure(15)
subplot(2,2,1)
ecdfmodel(SNRISO_dB, SNRD_dB24, SNRD_dB44, SNRD_dB48, SNRD_dB88, SNRD_dB816,...
    SNRD_dB1616, SNRD_dB1632, cbx_out_text, 'SNR(dB)', model, celltype);
subplot(2,2,2)
ecdfmodel(SINRISOlim_dB, SINRDlim_dB24,SINRDlim_dB44,SINRDlim_dB48, SINRDlim_dB88,...
    SINRDlim_dB816, SINRDlim_dB1616, SINRDlim_dB1632, cbx_out_text,...
    'SINR(dB)', model, celltype);
subplot(2,2,3)
ecdfmodel(C_UserISOlim, C_UserDlim24,C_UserDlim44,C_UserDlim48, C_UserDlim88,...
    C_UserDlim816, C_UserDlim1616, C_UserDlim1632,...
    cbx_out_text, 'User throughput in Mbits/sec', model, celltype);
subplot(2,2,4)
ecdfmodel(C_CellISOlim, C_CellDlim24,C_CellDlim44,C_CellDlim48,C_CellDlim88,...
    C_CellDlim816, C_CellDlim1616, C_CellDlim1632,...
    cbx_out_text, 'Cell throughput in Mbits/sec', model, celltype);

figure(16)
histogramprob(best_idx24, best_idx44, best_idx48, best_idx88, best_idx816,...
    best_idx1616, best_idx1632, worst_idx24, worst_idx44, worst_idx48,...
    worst_idx88,  worst_idx816, worst_idx1616, worst_idx1632,...
    celltype,"Best Gain Index", "Worst Gain Index", "Central Basestation", "red", "Yes")

figure(17)
histogramprob(best_idx24, best_idx44, best_idx48, best_idx88, best_idx816,...
    best_idx1616, best_idx1632, best_idx24i, best_idx44i, best_idx48i,...
    best_idx88i,  best_idx816i, best_idx1616i, best_idx1632i,...
    celltype,"Central BS", "Interfering BSs", "Highest Gain", "purple", "Yes")

figure(18)
metrichistogram(SNRISO_dB, SNRD_dB44, SNRD_dB48, SNRD_dB88, SNRD_dB816,...
    SNRD_dB1616,SNRD_dB1632, cbx_out_text, 'SNR(dB)', model, celltype)

figure(19)
metrichistogram(SINRISOlim_dB, SINRDlim_dB44, SINRDlim_dB48, SINRDlim_dB88,...
    SINRDlim_dB816,  SINRDlim_dB1616,SINRDlim_dB1632, cbx_out_text,"SINR(dB)", model, celltype)

figure(20)
metrichistogram(C_UserISOlim, C_UserDlim44, C_UserDlim48, C_UserDlim88,...
    C_UserDlim816, C_UserDlim1616, C_UserDlim1632, cbx_out_text, ...
    'User throughput in Mbits/sec', model, celltype)

figure(21)
metrichistogram(C_CellISOlim, C_CellDlim44, C_CellDlim48, C_CellDlim88,...
    C_CellDlim816,  C_CellDlim1616,C_CellDlim1632, cbx_out_text, ...
    'Cell throughput in Mbits/sec', model, celltype)

figure(22)
barminmaxmeanMK(SNRISO_dB,SNRD_dB24, SNRD_dB44, SNRD_dB48, SNRD_dB88, SNRD_dB816,...
    SNRD_dB1616,SNRD_dB1632, cbx_out_text, 'SNR(dB)', model, celltype)

figure(23)
barminmaxmeanMK(SINRISOlim_dB, SINRDlim_dB24,SINRDlim_dB44, SINRDlim_dB48, SINRDlim_dB88,...
    SINRDlim_dB816,  SINRDlim_dB1616,SINRDlim_dB1632, cbx_out_text,"SINR(dB)", model, celltype)

figure(24)
barminmaxmeanMK(C_UserISOlim, C_UserDlim24, C_UserDlim44, C_UserDlim48, C_UserDlim88,...
    C_UserDlim816, C_UserDlim1616, C_UserDlim1632, cbx_out_text, ...
    'User throughput in Mbits/sec', model, celltype)

figure(25)
barminmaxmeanMK(C_CellISOlim,C_CellDlim24, C_CellDlim44, C_CellDlim48, C_CellDlim88,...
    C_CellDlim816,  C_CellDlim1616,C_CellDlim1632, cbx_out_text, ...
    'Cell throughput in Mbits/sec', model, celltype)

% %% %%%%%%%%%%%%%%%%%%%%%%%%%% CASE D* with different M and K %%%%%%%%%%%%%%%
% 
% %adjusted random gain so that both K=M and K=2M have the same random gain
% for U_s=1:U_store
%     for b=1:6
%       randc_gain24i(b,U_s)=rand_gain24i(b,U_s);
%       randc_gain44i(b,U_s)=(rand_gain48i(b,U_s)+rand_gain44i(b,U_s))/2;
%       randc_gain48i(b,U_s)=(rand_gain48i(b,U_s)+rand_gain44i(b,U_s))/2;
%       randc_gain88i(b,U_s)=(rand_gain88i(b,U_s)+rand_gain816i(b,U_s))/2;
%       randc_gain816i(b,U_s)=(rand_gain88i(b,U_s)+rand_gain816i(b,U_s))/2;
%       randc_gain1616i(b,U_s)=(rand_gain1616i(b,U_s)+rand_gain1632i(b,U_s))/2;
%       randc_gain1632i(b,U_s)=(rand_gain1616i(b,U_s)+rand_gain1632i(b,U_s))/2;
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plot CASES

figure(26)
subplot(2,2,1)
ecdfmodel(SNRISO_dB,SNRA_dB, SNRB_dB, SNRC_dB, SNRD_dB,'n','n','n',cbx_out_text, ...
    'SNR(dB)', model, celltype);
hold on
subplot(2,2,2)
ecdfmodel(SINRISOlim_dB,SINRAlim_dB, SINRBlim_dB, SINRClim_dB, SINRDlim_dB,...
    'n','n','n',cbx_out_text, 'SINR(dB)', model, celltype);
subplot(2,2,3)
ecdfmodel(C_UserISOlim,C_UserAlim, C_UserBlim, C_UserClim, C_UserDlim,...
    'n','n','n',cbx_out_text, 'User throughput in Mbits/sec', model, celltype);
subplot(2,2,4)
ecdfmodel(C_CellISOlim,C_CellAlim, C_CellBlim, C_CellClim, C_CellDlim,...
    'n','n','n',cbx_out_text, 'Cell throughput in Mbits/sec', model, celltype);

figure(27)
barminmaxmeanCASES(SNRISO_dB,SNRA_dB, SNRB_dB, SNRC_dB, SNRD_dB, cbx_out_text,...
    'SNR(dB)', model, celltype)

figure(28)
barminmaxmeanCASES(SINRISOlim_dB,SINRAlim_dB, SINRBlim_dB, SINRClim_dB, SINRDlim_dB,...
    cbx_out_text,"SINR(dB)", model, celltype)

figure(29)
barminmaxmeanCASES(C_UserISOlim,C_UserAlim, C_UserBlim, C_UserClim, C_UserDlim,...
    cbx_out_text,'User throughput in Mbits/sec', model, celltype)

figure(30)
barminmaxmeanCASES(C_CellISOlim,C_CellAlim, C_CellBlim, C_CellClim, C_CellDlim,...
    cbx_out_text,'Cell throughput in Mbits/sec', model, celltype)

figure(31)
metrichistogram(SNRISO_dB,SNRA_dB, SNRB_dB, SNRC_dB, SNRD_dB,'n','n', cbx_out_text,...
    'SNR(dB)', model, celltype)

figure(32)
metrichistogram(SINRISOlim_dB,SINRAlim_dB, SINRBlim_dB, SINRClim_dB, SINRDlim_dB,...
    'n','n', cbx_out_text,"SINR(dB)", model, celltype)

figure(33)
metrichistogram(C_UserISOlim,C_UserAlim, C_UserBlim, C_UserClim, C_UserDlim,...
    'n','n', cbx_out_text, 'User throughput in Mbits/sec', model, celltype)

figure(34)
metrichistogram(C_CellISOlim,C_CellAlim, C_CellBlim, C_CellClim, C_CellDlim,...
    'n','n', cbx_out_text, 'Cell throughput in Mbits/sec', model, celltype)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(35)
plot(angledep_centralBSUE, pow2db(best_gain24), '.')
hold on
plot(angledep_centralBSUE, pow2db(best_gain44), '.')
plot(angledep_centralBSUE, pow2db(best_gain48), '.')
plot(angledep_centralBSUE, pow2db(best_gain88), '.')
plot(angledep_centralBSUE, pow2db(best_gain816), '.')
plot(angledep_centralBSUE, pow2db(best_gain1616), '.')
plot(angledep_centralBSUE, pow2db(best_gain1632), '.')
ylabel("Highest Antenna Gain (dBi)")
xlabel("Angle of departure (degrees)")
grid on
xlim([0 360])
legend("M=2 K=4", "M=4 K=4", "M=4 K=8", "M=8 K=8", "M=8 K=16", "M=16 K=16", "M=16 K=32")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% M=2, K=4 on the RX side
[best_gain24rx, best_idx24rx, ~,~, ~,~, ~, ArrayFactor, ArrayFactorRX,...
    ~]=beamforming3c720(fc_MHz, anglearriv_centralBSUE, 2, 4, "Not",98);

[best_gain24rxi, best_idx24rxi, ArrayFactorRX1i,ArrayFactorRX2i, ArrayFactorRX3i,...
    ArrayFactorRX4i]=beamforming3c720rxi(fc_MHz,anglearriv_interfBSUE, 2, 4, "Not");
% one matrix for each beam pattern number, as there are 6 basestations that
% represent each row and each user is represented by a column

%% For max-SNR
tic;
for U_s=1:U_store
    if best_idx24rx(1,U_s)==1
        best_gainSNRi(:,U_s)=ArrayFactorRX1i(:,U_s);
    elseif best_idx24rx(1,U_s)==2
        best_gainSNRi(:,U_s)=ArrayFactorRX2i(:,U_s);
    elseif best_idx24rx(1,U_s)==3
        best_gainSNRi(:,U_s)=ArrayFactorRX3i(:,U_s);
    elseif best_idx24rx(1,U_s)==4
        best_gainSNRi(:,U_s)=ArrayFactorRX4i(:,U_s);
    end
end
    
[SNR_SRX_dB,SINR_SRXlim_dB,C_User_SRXlim,C_Cell_SRXlim]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gain48i, htx, hrx, best_gain48, best_gain24rx,best_gainSNRi);
tSNR=toc; %time taken using max-SNR method 


%% For max-SINR exhaustive search
tic;
[SNRD_dBB1,SINRDlim_dBB1,C_UserDlimB1,C_CellDlimB1]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gain48i, htx, hrx, best_gain48, ArrayFactorRX(1,:), ArrayFactorRX1i);

[SNRD_dBB2,SINRDlim_dBB2,C_UserDlimB2,C_CellDlimB2]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store,rand_gain48i, htx, hrx, best_gain48, ArrayFactorRX(2,:), ArrayFactorRX2i);

[SNRD_dBB3,SINRDlim_dBB3,C_UserDlimB3,C_CellDlimB3]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gain48i, htx, hrx, best_gain48, ArrayFactorRX(3,:),  ArrayFactorRX3i);

[SNRD_dBB4,SINRDlim_dBB4,C_UserDlimB4,C_CellDlimB4]=calculateMK(U, PL,Noise,...
    Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gain48i, htx, hrx, best_gain48, ArrayFactorRX(4,:), ArrayFactorRX4i);

for U_s=1:U_store
    %SINR exhaustive search
    uSINR=[SINRDlim_dBB1(:,U_s)'; SINRDlim_dBB2(:,U_s)'; SINRDlim_dBB3(:,U_s)'; SINRDlim_dBB4(:,U_s)'];
    [best_SINR(1,:), best_SINRidx(1,:)]=max(uSINR);
     for m=1:7
        if best_SINRidx(1,m)==1
            SNR_IRX_dB(m,U_s)=SNRD_dBB1(m,U_s);
            SINR_IRXlim_dB(m,U_s)=SINRDlim_dBB1(m,U_s);
        elseif best_SINRidx(1,m)==2
            SNR_IRX_dB(m,U_s)=SNRD_dBB2(m,U_s);
            SINR_IRXlim_dB(m,U_s)=SINRDlim_dBB2(m,U_s);
        elseif best_SINRidx(1,m)==3
            SNR_IRX_dB(m,U_s)=SNRD_dBB3(m,U_s);
            SINR_IRXlim_dB(m,U_s)=SINRDlim_dBB3(m,U_s);
        elseif best_SINRidx(1,m)==4
            SNR_IRX_dB(m,U_s)=SNRD_dBB4(m,U_s);
            SINR_IRXlim_dB(m,U_s)=SINRDlim_dBB4(m,U_s);
        end
    end
end
[eta_IRXlim, C_User_IRXlim, C_Cell_IRXlim, SINR_IRXlim_dB, ~,~,...
    ~]=Throughputs(SINR_IRXlim_dB, B_User_MHz, U_store, U);
tSINR=toc; %time taken using max-SINR method (exhaustive search)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot 

[stringmodel, model]=pickModel; %select MAIN model
figure(37)
subplot(2,2,1)
ecdfRXTXmodel(SNRISO_dB, SNRD_dB, SNR_SRX_dB, SNR_IRX_dB, SNRD_dB816, cbx_out_text,...
    'SNR(dB)', model, celltype);
subplot(2,2,2)
ecdfRXTXmodel(SINRISOlim_dB, SINRDlim_dB, SINR_SRXlim_dB, SINR_IRXlim_dB, SINRDlim_dB816,...
    cbx_out_text,'SINR(dB)', model, celltype);
subplot(2,2,3)
ecdfRXTXmodel(C_UserISOlim, C_UserDlim, C_User_SRXlim, C_User_IRXlim,C_UserDlim816,...
    cbx_out_text, 'User throughput in Mbits/sec', model, celltype);
subplot(2,2,4)
ecdfRXTXmodel(C_CellISOlim, C_CellDlim, C_Cell_SRXlim, C_Cell_IRXlim,C_CellDlim816,...
    cbx_out_text, 'Cell throughput in Mbits/sec', model, celltype);

figure(38)
barminmaxmeanRXTX(SNRISO_dB, SNRD_dB, SNR_SRX_dB, SNR_IRX_dB,SNRD_dB816,cbx_out_text,...
    'SNR(dB)', model, celltype)

figure(39)
barminmaxmeanRXTX(SINRISOlim_dB, SINRDlim_dB, SINR_SRXlim_dB, SINR_IRXlim_dB,SINRDlim_dB816,...
    cbx_out_text, 'SINR(dB)', model, celltype)

figure(40)
barminmaxmeanRXTX(C_UserISOlim, C_UserDlim, C_User_SRXlim, C_User_IRXlim,C_UserDlim816,...
    cbx_out_text,'User throughput in Mbits/sec', model, celltype)

figure(41)
barminmaxmeanRXTX(C_CellISOlim, C_CellDlim, C_Cell_SRXlim, C_Cell_IRXlim,C_CellDlim816, ...
    cbx_out_text,'Cell throughput in Mbits/sec', model, celltype)

figure(42)
metrichistogramRXTX(SNRISO_dB, SNRD_dB, SNR_SRX_dB, SNR_IRX_dB, SNRD_dB816, cbx_out_text,...
    'SNR(dB)', model, celltype);

figure(43)
metrichistogramRXTX(SINRISOlim_dB, SINRDlim_dB, SINR_SRXlim_dB, SINR_IRXlim_dB, SINRDlim_dB816,...
    cbx_out_text,'SINR(dB)', model, celltype);

figure(44)
metrichistogramRXTX(C_UserISOlim, C_UserDlim, C_User_SRXlim, C_User_IRXlim,C_UserDlim816,...
    cbx_out_text, 'User throughput in Mbits/sec', model, celltype);

figure(45)
metrichistogramRXTX(C_CellISOlim, C_CellDlim, C_Cell_SRXlim, C_Cell_IRXlim,C_CellDlim816,...
    cbx_out_text, 'Cell throughput in Mbits/sec', model, celltype);

figure(46)
plotecdfRXTX(SNRISO_dB, SNRD_dB, SNR_SRX_dB, SNR_IRX_dB, SNRD_dB816,loop, cbx_out_text,...
    'SNR(dB)', celltype);

figure(47)
plotecdfRXTX(SINRISOlim_dB, SINRDlim_dB, SINR_SRXlim_dB, SINR_IRXlim_dB, SINRDlim_dB816,...
    loop, cbx_out_text,'SINR(dB)', celltype);

figure(48)
plotecdfRXTX(C_UserISOlim, C_UserDlim, C_User_SRXlim, C_User_IRXlim,C_UserDlim816,...
    loop, cbx_out_text, 'User throughput in Mbits/sec', celltype);

figure(49)
plotecdfRXTX(C_CellISOlim, C_CellDlim, C_Cell_SRXlim, C_Cell_IRXlim,C_CellDlim816,...
    loop, cbx_out_text, 'Cell throughput in Mbits/sec', celltype);

figure(50)
plotBeamPatterns(fc_MHz, 2, 4, "Not", 50);
