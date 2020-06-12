function [PL_g] = SUIg(fc_MHz, d, d0,htx, hrx, O_sui, s)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b

%"Extension" of Okumura-Hata to accommodate the following frequency range:
%fc_MHz should be >=2000 && <=3500 MHz
%htx should be >= 10 && <= 80m
%htx should be >= 2 && <= 10m
%htx>hrx for this project (downlink)
d0=0.1;
lambda=(physconst('LightSpeed')/(fc_MHz*10^6));
A=FreeSpace(fc_MHz*10^6, d0, "Hzm");

%between 8.2 and 10.6 dB
%Atest=(FreeSpace(1,1, "MHzkm"))+(20.*log10(fc_GHz));
%A=FreeSpace(fc_MHz.*10^6, d0, "Hzm");
if isequal(O_sui, "A")
    a=4.6;
    b=0.0075; %in m^-1
    c=12.6; %in m
    Xhrx=-10.8*log10(hrx/2000); %correction factor for receiver heigth
elseif isequal(O_sui, "B")
    a=4;
    b=0.0065; %in m^-1
    c=17.1; %in m
    Xhrx=-10.8*log10(hrx/2000); %correction factor for receiver heigth
elseif isequal(O_sui, "C")
    a=3.6;
    b=0.005; %in m^-1
    c=20; %in m
    Xhrx=-20*log10(hrx/2000); %correction factor for receiver heigth
end
gamma=a-b*htx+c/htx; %path loss exponent
Xfc=6*log10(fc_MHz/2000); %correction factor for frequency in MHz


sized=size(d);
for col=1:sized(2)
    for row=1:sized(1)
        %if (d(row, col)<0.1)
         %   PL_sui(row,col)=FreeSpace(fc_MHz, d(row,col), "MHzkm");
        %else
            PL_sui(row,col)=A+10.*gamma.*log10(d(row,col)/d0)+Xfc+Xhrx+s;
        %end
    end
end
PL_g=PL_sui;
end