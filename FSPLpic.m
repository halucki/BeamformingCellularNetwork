function FSPLpic 

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b

freq=[500, 1000, 3500, 5200, 17000, 28000, 60000]; %in MHz

distances=linspace(0.1, 3, 2000); %in km

figure(40);

for i=1:length(freq)
    FreeSpacePL=FreeSpace(freq(i), distances, "MHzkm");
        
    semilogx(distances, FreeSpacePL, 'LineWidth', 1);
        
    hold on;     
end

xlabel('Distance (km)');
ylabel('Path Loss (dB)'); 
title("Path Loss as a function of Carrier Frequency and Distance")
legend("500 MHz","1 GHz", "3.5 GHz", "5.2 GHz", "17 GHz", "28 GHz", "60 GHz")
axis tight
grid on
hold off;
end 







