function [Prxsum,Prxsumt]=sumInterRX(fc_MHz, Ptx_dBm, U_store, Gaintx, Gainrx, htx, hrx)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 12-May-2020
% Developed in Matlab R2019b
    global s
    global d_U2BSi
    global O_oh
    global O_c231h
    global O_c231wi
    global O_sui
    otherInputs=[50 30 0];
    PLinter_fs=zeros(U_store, 6); 
    PLinter_oh=zeros(U_store, 6); 
    PLinter_c231h=zeros(U_store, 6); 
    PLinter_c231wi_LoS=zeros(U_store, 6);
    PLinter_c231wi_nonLoS=zeros(U_store, 6);
    PLinter_sui=zeros(U_store, 6);
    PLinter_ecc33=zeros(U_store, 6);
    Prxi_fs=zeros(U_store, 6); 
    Prxi_oh=zeros(U_store, 6); 
    Prxi_c231h=zeros(U_store, 6);
    Prxi_c231wi_LoS=zeros(U_store, 6); 
    Prxi_c231wi_nonLoS=zeros(U_store, 6); 
    Prxi_sui=zeros(U_store, 6); 
    Prxi_ecc33=zeros(U_store, 6); 
    Prxsum=zeros(7, U_store);

    for U_s=1:U_store 
        for b=1:6
            if Gainrx==1
                Grx=1;
            else
                Grx=Gainrx(b,U_s);
            end
            PLinter_fs(U_s,b)=FreeSpace(fc_MHz, d_U2BSi(U_s,b), "MHzkm");
            Prxi_fs(U_s,b)=linkbudget(Ptx_dBm, PLinter_fs(U_s,b), Gaintx(b,U_s), Grx);

            
            PLinter_oh(U_s,b)=OkumuraHata(fc_MHz, d_U2BSi(U_s,b), htx, hrx, O_oh);
            Prxi_oh(U_s,b)=linkbudget(Ptx_dBm, PLinter_oh(U_s,b), Gaintx(b,U_s), Grx);


            PLinter_c231h(U_s,b)=Cost231Hata(fc_MHz, ...
                d_U2BSi(U_s,b),htx, hrx, O_c231h);
            Prxi_c231h(U_s,b)=linkbudget(Ptx_dBm, PLinter_c231h(U_s,b), Gaintx(b,U_s), Grx);


            PLinter_c231wi_LoS(U_s,b)=Cost231WalfishIkegami(fc_MHz, ...
                d_U2BSi(U_s,b), htx, hrx, PLinter_fs(U_s,b),"LoS",...
                O_c231wi, otherInputs);
            Prxi_c231wi_LoS(U_s,b)=linkbudget(Ptx_dBm, PLinter_c231wi_LoS(U_s,b), Gaintx(b,U_s), Grx);


            PLinter_c231wi_nonLoS(U_s,b)=Cost231WalfishIkegami(fc_MHz, ...
                d_U2BSi(U_s,b),htx, hrx, PLinter_fs(U_s,b),"Non-LoS",...
                O_c231wi, otherInputs);
            Prxi_c231wi_nonLoS(U_s,b)=linkbudget(Ptx_dBm, PLinter_c231wi_nonLoS(U_s,b), Gaintx(b,U_s), Grx);

            
            PLinter_sui(U_s,b)=SUI(fc_MHz, d_U2BSi(U_s,b), htx, hrx, O_sui, s);
            Prxi_sui(U_s,b)=linkbudget(Ptx_dBm, PLinter_sui(U_s,b), Gaintx(b,U_s), Grx);
       
            
            PLinter_ecc33(U_s,b)=ECC33(fc_MHz, d_U2BSi(U_s,b), htx, hrx);
            Prxi_ecc33(U_s,b)=linkbudget(Ptx_dBm, PLinter_ecc33(U_s,b), Gaintx(b,U_s), Grx);
            
        end
        %calculates the sum of neighbours received power (interference) of each
        %model. the 1:7 index here is the number of the model, NOT the number 
        %of basestations. So it is Prxsum(model, U_s)
        Prxsum(1,U_s)=sum(Prxi_fs(U_s,:));
        Prxsum(2,U_s)=sum(Prxi_oh(U_s,:)); 
        Prxsum(3,U_s)=sum(Prxi_c231h(U_s,:)); 
        Prxsum(4,U_s)=sum(Prxi_c231wi_LoS(U_s,:)); 
        Prxsum(5,U_s)=sum(Prxi_c231wi_nonLoS(U_s,:)); 
        Prxsum(6,U_s)=sum(Prxi_sui(U_s,:)); 
        Prxsum(7,U_s)=sum(Prxi_ecc33(U_s,:)); 
    end 
end