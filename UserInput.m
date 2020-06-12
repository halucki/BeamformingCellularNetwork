function [B_MHz, fc_MHz, Ptx, htx, hrx] = UserInput

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b

prompt = {"Cell's Bandwidth in MHz", 'Carrier frequency in MHz', 'Transmitted power in Watts','Transmitter height in meters', 'Receiver heigth in meters'}; 
dlgtitle = 'Input';
dims = [1 30];
definput = {'10','1000', '40', '36', '1.5'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
B_MHz = str2num(answer{1}); 
fc_MHz = str2num(answer{2}); 
Ptx = str2num(answer{3}); %basestation transmitted power in Watts
htx = str2num(answer{4}); %basestation (transmitter) height in meters
hrx = str2num(answer{5}); %user (receiver) heigth in meters
answers=[B_MHz, fc_MHz, Ptx, htx, hrx];
while (htx < hrx) 
    opts=struct('WindowStyle', 'modal', 'Interpreter','tex');
    error1 = errordlg('The heigth of the transmitter cannot be smaller than the heigth of the receiver!',...
             'Error', opts);
    waitfor(error1);
    answer = inputdlg({'Transmitter height in meters', 'Receiver heigth in meters'});  
    htx = str2num(answer{1}); %basestation (transmitter) height in meters
    hrx = str2num(answer{2}); %user (receiver) heigth in meters
end

while (fc_MHz < 150) 
    opts=struct('WindowStyle', 'modal', 'Interpreter','tex');
    error2 = errordlg('The carrier frequency has to be >150MHz',...
             'Error', opts);
    waitfor(error2);
    answer = inputdlg({'Carrier frequency in MHz'});  
    fc_MHz = str2num(answer{1}); 
end
for i=1:length(answers)
    while (answers(i) <= 0) 
        opts=struct('WindowStyle', 'modal', 'Interpreter','tex');
        error1 = errordlg('The values have to be positive!',...
             'Error', opts);
        waitfor(error1);
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        B_MHz = str2num(answer{1}); 
        fc_MHz = str2num(answer{2}); 
        Ptx = str2num(answer{3}); %basestation (transmitter) height in meters
        htx = str2num(answer{4}); %basestation (transmitter) height in meters
        hrx = str2num(answer{5}); %user (receiver) heigth in meters
        answers=[B_MHz, fc_MHz, Ptx, htx, hrx];
    end
end
end
