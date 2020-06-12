function [max_gain, max_idx,ArrayFactorRX1i, ArrayFactorRX2i, ArrayFactorRX3i,...
  ArrayFactorRX4i]=beamforming3c720rxi(fc_MHz,angle,  M,  K, adjustedornot)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 17-May-2020
% Developed in Matlab R2019b

    steps=720; %each index is 0.5. index 1 is supposed to be 0 degrees, 
    % so that is why there are 721 indexes. 
    % index 2 is 1 degree, index 3 is 1.5 degree and so on. 
    % M=4; %number of antenna elements
    % K=8; %number of beam  patterns
    p=zeros(M,K);
    W=zeros(M,K);
    
    c = physconst('LightSpeed'); % Propagation speed in meters/second)
    lambda = c/(fc_MHz*10^6);               % wavelength in meters
    d = lambda/2;                % antenna element spacing in meters
    %d/lambda=0.5
    
    if adjustedornot=="Adjusted"
        for k=0:K-1
            for m=0:M-1
              if (K>=M)
                p(m+1,k+1) = (m*mod(k+(K/2),K)/(K/4));

                if k==M-1 || k==K-1
                     W(m+1,k+1)=1j.^fix(p(m+1,k+1));
                else
                     W(m+1,k+1)=1j.^round(p(m+1,k+1));
                end
              elseif K==M/2
                  if k==0
                     p(m+1,k+1) = mod(m,k);
                     W(m+1, k+1)=(-1j)^(p(m+1, k+1));
                  elseif k>0
                     p(m+1,k+1) = (m*mod(k+(K/2),K)/(K/4));
                     W(m+1, k+1)=(-1)^floor(p(m+1, k+1));
                  end
              end
            end
        end
    elseif adjustedornot=="Not"
        for k=0:K-1
            for m=0:M-1
              if (K>=M)
                p(m+1,k+1) = (m*mod(k+(K/2),K)/(K/4));
                W(m+1,k+1)=1j.^floor(p(m+1,k+1));
              elseif K==M/2
                  if k==0
                     p(m+1,k+1) = mod(m,k);
                     W(m+1, k+1)=(-1j)^(p(m+1, k+1));
                  elseif k>0
                     p(m+1,k+1) = (m*mod(k+(K/2),K)/(K/4));
                     W(m+1, k+1)=(-1)^floor(p(m+1, k+1));
                  end
              end
            end
        end
    end
    
    theta_rad=linspace(0,2*pi,steps+1);
    theta_deg=linspace(0,360,steps+1);

    AF=zeros(length(theta_deg),K); 
    af=zeros(M,K); 
    for i=1:length(theta_deg) 
        for n=0:M-1
            af(n+1,:)=W(n+1,:)*exp(1j*n*2*pi*(d/lambda)*sin(theta_deg(i)*pi/180));
            AF(i,:)=sum(af); 
        end
    end 

    omega=zeros(M,M); 
    for m=0:M-1
        for n=0:M-1
            if m==n
                omega(n+1, m+1)=1;
            else
                omega(n+1, m+1)=sin(2*pi*(d/lambda)*(n-m))/(2*pi*(d/lambda)*(n-m));
            end
        end
    end

    bottom=0j;
    for m=0:M-1
          for n=0:M-1
              bottom=bottom+((W(m+1,:)').*omega(m+1,n+1).*W(n+1,:));
          end
    end

    maxAF=max(AF);
    top=(maxAF.^2);

    directivity=10.*log10(top./max(bottom));
    

    hcode=[rgb('MediumSlateBlue'),rgb('OrangeRed'), rgb('LimeGreen'),rgb('DeepPink'), rgb('Firebrick'),rgb('DarkTurquoise'),rgb('Gold'),rgb('DarkSlateGray'), ...
         rgb('Aqua'),rgb('Red'),rgb('Blue'),...
       rgb('LightSteelBlue'),rgb('SaddleBrown'), rgb('Indigo'), rgb('Fuchsia'),rgb('Teal'),rgb('MediumSlateBlue'),rgb('OrangeRed'), rgb('LimeGreen'),rgb('DeepPink'), rgb('Firebrick'),rgb('DarkTurquoise'),rgb('Gold'),rgb('DarkSlateGray'), ...
         rgb('Aqua'),rgb('Red'),rgb('Blue'),...
       rgb('LightSteelBlue'),rgb('SaddleBrown'), rgb('Indigo'), rgb('Fuchsia'),rgb('Teal')];	
    

    absAF=abs(AF);
    ArrayFactor=zeros(K, length(theta_deg));
    figure(9)
    a=1;
    for n=1:K
        ArrayFactor(n,:)=absAF(:,n);
        polarplot(theta_rad,ArrayFactor(n,:),'Color',hcode(a:a+2), 'LineWidth',1);
        a=a+3;
        hold on
    end
    hold off
    

    thetamax=zeros(length(theta_rad), K);
    
    for i=1:length(theta_rad) 
        for k=1:K
            if AF(i,k)==maxAF(1,k)
                if theta_rad(i)>pi && theta_rad(i)<2*pi 
                    thetamax(i,k)=theta_rad(i)-pi/2;
                elseif theta_rad(i)==2*pi 
                    thetamax(i,k)=theta_rad(i)-pi/2;
                else
                    thetamax(i,k)=pi/2-theta_rad(i);
                end
            end
        end
    end
    maxtheta_rad=max(thetamax);
    maxtheta_deg=rad2deg(maxtheta_rad);
    
        function result=floorceil(angle, forc)
            if forc=="f"
              result=(floor(2.*angle)); % ROUNDS DOWN: rounds to the nearest 
              % integer less than or equal to the angle
            elseif forc=="c"

              result=(ceil(2.*angle)); % ROUNDS UP: rounds to the nearest integer
              % greater than or equal to the angle
            end
        end
    
        Sizeangle=size(angle);
        rand_idx=randi(K,flip(Sizeangle));
        for U_s=1:Sizeangle(1)
            for b=1:Sizeangle(2)
                rand_gain(b,U_s)=ArrayFactor(rand_idx(b,U_s), floorceil(angle(U_s,b), "f")+1);
                [max_gain(b, U_s),max_idx(b, U_s)] = max(ArrayFactor(:,floorceil(angle(U_s,b),"f")+1));
                [min_gain(b, U_s),min_idx(b, U_s)] = min(ArrayFactor(:,floorceil(angle(U_s,b),"f")+1));
                if 10*log10(rand_gain(b,U_s))>100||10*log10(rand_gain(b,U_s))<-100
                    rand_gain(b,U_s)=ArrayFactor(rand_idx(b,U_s), floorceil(angle(U_s,b), "c")+1);
                    [max_gain(b, U_s),max_idx(b, U_s)] = max(ArrayFactor(:,floorceil(angle(U_s,b),"c")+1));
                    [min_gain(b, U_s),min_idx(b, U_s)] = min(ArrayFactor(:,floorceil(angle(U_s,b),"c")+1));
                end
            end
        end
        for U_s=1:Sizeangle(1)
            for b=1:6
            ArrayFactorRX1i(b,U_s)=ArrayFactor(1, floorceil(angle(U_s,b), "f")+1);
            ArrayFactorRX2i(b,U_s)=ArrayFactor(2, floorceil(angle(U_s,b), "f")+1);
            ArrayFactorRX3i(b,U_s)=ArrayFactor(3, floorceil(angle(U_s,b), "f")+1);
            ArrayFactorRX4i(b,U_s)=ArrayFactor(4, floorceil(angle(U_s,b), "f")+1);
            end
        end
end
