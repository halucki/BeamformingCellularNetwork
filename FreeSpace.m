function [PL_fs]=FreeSpace(fc, d, unit) 

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b


%this function calculates the Free Space Path Loss FSPL
%only applies for systems with strong LoS (line of sight)

c=physconst('LightSpeed');

G=1; %G: antenna gain in an isotropic source G=1

%lambda: carrier wavelength. relates to  c=f*lambda
lambda=c/fc;
        
%Effective Area  of Antenna in m^2
Ai=G*lambda^2/(4*pi);
        
Ssphere=4*pi*d.^2; %area of a sphere  is 4*pi*d^2
PL_fs=10.*log10(Ssphere./Ai); %free space path loss in dB

if isequal(unit, "Hzm")
    PL_fs=PL_fs;
elseif isequal(unit, "MHzkm")
    PL_fs=PL_fs+180;
end    
      
end 







