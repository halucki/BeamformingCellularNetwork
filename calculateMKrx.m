function [SNRD_dBMK,SINRDlim_dBMK,C_UserDlimMK,C_CellDlimMK]=calculateMKrx(U, PL, Noise, Noise_dBm, fc_MHz, Ptx_dBm, U_store, rand_gainsi, htx, hrx, best_gains, rx_gains, rx_gainsi)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 24-May-2020
% Developed in Matlab R2019b 
 
    global B_User_MHz
    PrxsumDMK=sumInterRX(fc_MHz, Ptx_dBm,U_store, rand_gainsi, rx_gainsi, htx, hrx);
   
    Gtx=best_gains; %beamforming at the transmitter. picks the beam with
    %the best gain amongst the available beams
    Grx=rx_gains;
    [~, SNRD_dBMK, SINRD_dBMK]=SNR_SINR(Ptx_dBm, PL, Noise,...
        Noise_dBm, PrxsumDMK, Gtx, Grx);
    
    
    [~, C_UserDlimMK, C_CellDlimMK, SINRDlim_dBMK, ~,~,...
    ~]=Throughputs(SINRD_dBMK, B_User_MHz, U_store, U);
    
end