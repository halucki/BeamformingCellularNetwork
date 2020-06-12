function [Prx_dBm, SNR_dB, SINR_dB]=SNR_SINR(Ptx_dBm, PL, Noise, Noise_dBm, Prxsum, Gtx, Grx)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b

    [Prx, Prx_dBm]=linkbudget(Ptx_dBm, PL, Gtx, Grx);
    SNR_dB=pow2db(Prx./Noise);
    %SNR_dBcheck=Prx_dBm-Noise_dBm;
    SNR=Prx./Noise;
    SINR=Prx./(Noise+Prxsum);
    SINR_dB=pow2db(SINR);
end