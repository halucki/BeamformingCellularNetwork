function [etalim, C_Userlim, C_Celllim, SINRlim_dB, eta, C_User,C_Cell]=Throughputs(SINR_dB,B_User_MHz, U_store, U)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 24-May-2020
% Developed in Matlab R2019b

%% eta, the Bandwidth Efficiency in bits per second per Hz (bps/Hz)
eta=log2(1+db2pow(SINR_dB));

%% User throughput in Mbits per second
C_User=eta.*B_User_MHz; 

C_Cell=zeros(7,U_store/U);
    for i=1:floor(U_store/U) %rounds down
        %Iter=U_store/U
        p=1+U*(i-1);
        q=U+U*(i-1);
        for model=1:7
            C_Cell(model,i)=sum(C_User(model, p:q));
        end
    end

%% SINR limited metrics: eta, User throughput and Cell throughput
SINRmax=30;
SINRlim_dB=zeros(7,U_store);
for U_s=1:U_store
    for model=1:7
        if SINR_dB(model, U_s)<=SINRmax
            SINRlim_dB(model, U_s)=SINR_dB(model, U_s);
        elseif SINR_dB(model, U_s)>SINRmax
            SINRlim_dB(model, U_s)=SINRmax; 
        end
    end
end
etalim=log2(1+db2pow(SINRlim_dB));

C_Userlim=etalim.*B_User_MHz;
C_Celllim=zeros(7,U_store/U);
for i=1:floor(U_store/U) %rounds down.
    %Iter=U_store/U
    p=1+U*(i-1);
    q=U+U*(i-1);
    for model=1:7
        C_Celllim(model,i)=sum(C_Userlim(model, p:q));
    end
end
    
end