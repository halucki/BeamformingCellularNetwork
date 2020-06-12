function [PL_c231h] = Cost231Hata(fc_MHz, d, htx, hrx, O_c231h)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 12-May-2020
% Developed in Matlab R2019b

%"Extension" of Okumura-Hata to accommodate the following frequency range:
%fc_MHz should be >=1500 && <=2000 MHz
%htx should be >= 30 && <= 200m
%hrx should be >= 1 && <= 10m
%d should be >=1 && <= 20km

    Output=O_c231h; %Output=(city, environment)

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

    %Cost231-Hata model: Path Loss calculated in dB
    PL_c231h=46.3+33.91*log10(fc_MHz)-13.82*log10(htx)+(44.9-6.55*log10(htx))*log10(d)-ahrx; 

    if isequal(Output(1), "Metropolitan centres")
            PL_c231h=PL_c231h+3;
    end

end          
