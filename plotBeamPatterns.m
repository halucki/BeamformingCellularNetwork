function plotBeamPatterns(fc_MHz, M,K, adjustedornot, fign)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b

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
    
    theta_deg=0:1:360;
    theta_rad=deg2rad(theta_deg);

    AF=zeros(length(theta_rad),K); 
    af=zeros(M,K); 
    for i=1:length(theta_rad) 
        for n=0:M-1
            af(n+1,:)=W(n+1,:)*exp(1j*n*2*pi*(d/lambda)*sin(theta_rad(i)));
            AF(i,:)=sum(af); 
        end
    end 



       hcode=[rgb('MediumSlateBlue'),rgb('OrangeRed'), rgb('LimeGreen'),rgb('DeepPink'), rgb('Firebrick'),rgb('DarkTurquoise'),rgb('Gold'),rgb('DarkSlateGray'), ...
         rgb('Aqua'),rgb('Red'),rgb('Blue'),...
       rgb('LightSteelBlue'),rgb('SaddleBrown'), rgb('Indigo'), rgb('Fuchsia'),rgb('Teal'),rgb('MediumSlateBlue'),rgb('OrangeRed'), rgb('LimeGreen'),rgb('DeepPink'), rgb('Firebrick'),rgb('DarkTurquoise'),rgb('Gold'),rgb('DarkSlateGray'), ...
         rgb('Aqua'),rgb('Red'),rgb('Blue'),...
       rgb('LightSteelBlue'),rgb('SaddleBrown'), rgb('Indigo'), rgb('Fuchsia'),rgb('Teal')];
    figure(1)
    a=1;
    absAF=abs(AF);
    ArrayFactor=zeros(K, length(theta_rad));
    
    
    
   if K==8 || K==4
       col=2;
       row=K/2;
       
   elseif K==16
       col=4;
       row=4;
   elseif K==32
       col=4;
       row=8;
   end
   figure(fign)    
    a=1;
    for n=1:K
        subplot(col,row,n)
        ArrayFactor(n,:)=absAF(:,n);
        polarplot(theta_rad,ArrayFactor(n,:),'Color',hcode(a:a+2))
        title("M="+string(M)+", K="+string(K)+": Beam Pattern "+string(n));
        a=a+3;
    end
    
%     a=1;
%     for n=1:K
%         ArrayFactor(n,:)=absAF(:,n);
%         polarplot(theta_rad,ArrayFactor(n,:),'Color',hcode(a:a+2), 'LineWidth',1);
%         a=a+3;
%         hold on
%     end
end

    
