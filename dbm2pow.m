function [Ptx] = dbm2pow(Ptx_dBm)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 12-May-2020
% Developed in Matlab R2019b

% Ptx= dbm2pow(Ptx_dBm) returns the power measurements, Ptx, that
% correspond to the decibel-milliwatt (dBm) values speecified in Ptx_dBm

% converts dBm into linear power (Watts)
    Ptx = 10.^((Ptx_dBm-30)./10);
    
end
