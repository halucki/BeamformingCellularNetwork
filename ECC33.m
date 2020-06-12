function [PL_ECC33] = ECC33(fc_MHz, d, htx, hrx)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b


%fc_MHz should be >=700 && <=3500 MHz
%htx should be >= 30 && <= 200m
%hrx should be >= 1 && <= 10m
%d_km should be >=1 && <= 20km
    fc_GHz=fc_MHz*10^-3;

    Afs=92.4+(20.*log10(d))+(20.*log10(fc_GHz));
    Abm=20.41+(9.83.*log10(d))+(7.894*log10(fc_GHz))+(9.56*(log10(fc_GHz)).^2);
    Gt=log10(htx/200)*(13.98+(5.8.*(log10(d).^2)));
    Gr=(42.57+13.7*log10(fc_GHz)).*(log10(hrx)-0.585); %for medium cities
    
    PL_ECC33=Afs+Abm-Gt-Gr;
end          