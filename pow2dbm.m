function [Ptx_dBm] = pow2dbm(Ptx)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 12-May-2020
% Developed in Matlab R2019b

% Ptx_dBm = pow2dbm(Ptx) expresses in decibel-milliwatt (dBm) the power 
% measurements specified in Ptx

%converts linear power (Watts) into dBm
    Ptx_dBm = 10.*log10(Ptx)+30;
    %pow2db(P)+30
    
end
