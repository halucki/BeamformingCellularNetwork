function [Prx, Prx_dBm]=linkbudget(Ptx_dBm, PL, Gtx, Grx)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 12-May-2020
% Developed in Matlab R2019b

%link budget to calculate the received power Prx in Watts and in dBm
    %Ptx=dbm2pow(Ptx_dBm);
    %Prx=(Ptx*Gtx*Grx)/db2pow(PL);   %calculation in Watts
    Gtx_dBi=pow2db(Gtx);
    Grx_dBi=pow2db(Grx);
    Prx_dBm=Ptx_dBm+Gtx_dBi+Grx_dBi-PL;
    
    Prx=dbm2pow(Prx_dBm);
end
