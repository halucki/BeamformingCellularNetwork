function PL_c231wi =Cost231WalfishIkegami(fc_MHz, d, htx, hrx, PL_fs, LoSornot, O_c231wi, otherInputs)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b

%fc_MHz should be >=800 && <=2000 MHz
%d_km should be >=0.02 && <= 5km
%% Non-LoS version
%htx should be >= 4 && <= 50m
%hrx should be >= 1 && <= 3m

L0=PL_fs; %Free Space Path  Loss
b=otherInputs(1); %building separation in meters
if otherInputs(1)==0
    b = 20 + (30)*rand(1); %generates one random number between 20 and 50m (default values)
    %N random numbers in the interval (a,b) with the formula r = a + (b-a).*rand(N,1)
end
angle=otherInputs(2); %angle of incident wave with respect to street, in degrees
if isequal(otherInputs(2),0)
    angle=90;
end

if (angle>=0&&angle<=35)
    Lori=-10+0.345*angle;
elseif (angle>=35&&angle<=55)
    Lori=2.5+0.075*(angle-35);
elseif (angle>=55&&angle<=90)
    Lori=4+0.114*(angle-55);
end
    
    
w=b/2; %street width in meters

hroof=otherInputs(3); %roof height
if isequal(hroof,0)
%     roof=3; %standard value for pitch
%     %nfloor=randi(3); %random scalar integer between 1 and 3. so the max is  3 floors
%     %hroof=3*nfloor+roof;
    hroof=15;
end
dhtx=htx-hroof; 
dhrx=hroof-hrx; 
Lrts=-16.9-10*log10(w)+10*log10(fc_MHz)+20*log(dhrx)+Lori;

if htx>hroof
    Lbsh=-18.*log10(1+dhtx);
    ka=54;
    kd=18;
elseif htx<=hroof
    Lbsh=0;
    kd=18-15*dhtx/hroof;
    if d>=0.5
        ka=54-0.8.*dhtx;
    else
        ka=54-0.8.*dhtx.*d/0.5;
    end
end

if isequal(O_c231wi, "Urban")
        kf=-4+1.5*(fc_MHz/925 -1);
elseif isequal(O_c231wi, "Suburban")
        kf=-4+0.7*(fc_MHz/925 -1);
end

Lmsd=Lbsh+ka+kd*log10(d)+kf*log10(fc_MHz)-9*log10(fc_MHz)-9*log10(b);

sum=Lrts+Lmsd;

PL_nonLoS=L0+Lrts+Lmsd;
if sum>=0
    PL_nonLoS=L0+Lrts+Lmsd;
elseif sum<0
    PL_nonLoS=L0;
end

%% LoS version
PL_LoS=42.6+26*log10(d)+20*log10(fc_MHz);
%same as FSPL at a distance of 0.02km
%%

if isequal(LoSornot, "LoS")
    PL_c231wi=PL_LoS;
elseif isequal(LoSornot, "Non-LoS")
    PL_c231wi=PL_nonLoS;
end
    

end
