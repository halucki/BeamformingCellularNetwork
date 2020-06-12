function [PL_oh] = OkumuraHata(fc_MHz, d, htx, hrx, O_oh)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b

%fc_MHz should be >=150 && <=1500 MHz
%htx should be >= 30 && <= 200m
%hrx should be >= 1 && <= 10m
%d_km should be >=1 && <= 20km

    Output=O_oh; %Output=(city, environment)
    %htx>hrx for this project (downlink)

    if isequal(Output(2), "Small/Medium")
            ahrx=0.8-1.56*log10(fc_MHz)+(1.1*log10(fc_MHz)-0.7)*hrx;
    elseif isequal(Output(2), "Large")
            if fc_MHz>=150&&fc_MHz<=300 
                ahrx=8.29*(log10(1.54*hrx))^2 - 1.1;
            elseif fc_MHz>=300 
                ahrx=3.2*(log10(11.75*hrx))^2 - 4.97;
            end
    end


    PL_oh=69.55+26.16*log10(fc_MHz)-13.82*log10(htx)+(44.9-6.55*log10(htx))*log10(d)-ahrx; %urban
    %Okumura-Hata Path Loss in dB

    if isequal(Output(1), "Urban")
            PL_oh=PL_oh;
    elseif isequal(Output(1), "Suburban")
            PL_oh=PL_oh-5.4-2*log10(fc_MHz/28)^2;
    elseif isequal(Output(1), "Open area")
            PL_oh=PL_oh-40.97+(18.33-4.78*(log10(fc_MHz)))*log10(fc_MHz);
    end

end          