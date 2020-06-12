function plotecdf(ISO, a, b, c, d, e, f, g,loop, cbx_out_text, insertxlabel, celltype)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 24-May-2020
% Developed in Matlab R2019b
    linestyle=[ '-', '-.', '-', '--', "-"]; 
   
    en=0;
    for n=1:length(loop)
        if loop(n)==1
                 en=[en,n];
        end
    end
    if en(1)==0
        en(1)=[];
    end
    
   for u=1:length(en)
      count=1;
     if sum(loop)==7
        subplot(3,3,u);
      elseif sum(loop)<7 && sum(loop)>4
          subplot(2,3,u)
      elseif sum(loop)<=4 && sum(loop)>2
          subplot(2,2,u)
      elseif sum(loop)<=2 
          subplot(1,2,u)
      end
    v=en(u);
 
    p(:,1)=cdfplot(ISO(v,:));       
    hold on
    p(:,2)=cdfplot(a(v,:));
    p(:,3)=cdfplot(b(v,:));
    p(:,4)=cdfplot(c(v,:));
     
    if d~='n'
      p(:,5)=cdfplot(d(v,:));
      maxi=5;
      linestyle=[ '-', '-', '-.', '--', "-"]; 

    hcode(1,:)=[rgb('Silver'),rgb('PowderBlue'),rgb('DeepSkyBlue'), rgb('DodgerBlue'), rgb('Blue')];
    hcode(2,:)=[rgb('Silver'),rgb('PaleGreen'),rgb('LimeGreen'), rgb('YellowGreen'), rgb('MediumSeaGreen')];
    hcode(3,:)=[rgb('Silver'),rgb('SandyBrown'), rgb('Orange'), rgb('Tomato'), rgb('OrangeRed')];
    hcode(4,:)=[rgb('Silver'),rgb('Aquamarine'),rgb('PaleTurquoise'), rgb('Turquoise'), rgb('LightSeaGreen')];
    hcode(5,:)=[rgb('Silver'),rgb('Yellow'),rgb('Khaki'),  rgb('Gold'), rgb('Goldenrod')];
    hcode(6,:)=[rgb('Silver'),rgb('LightPink'), rgb('HotPink'), rgb('DeepPink'), rgb('PaleVioletRed')];
    hcode(7,:)=[rgb('Silver'),rgb('Red'), rgb('IndianRed'), rgb('Brown'),rgb('Maroon')];	
    else
      maxi=4;
    end
    
     if e~='n'
      p(:,6)=cdfplot(e(v,:));
      maxi=6;
     end
     
     if f~='n'
      p(:,7)=cdfplot(f(v,:));
      maxi=7;
     end
     
     if g~='n'
      p(:,8)=cdfplot(g(v,:));
      maxi=8;
      linestyle=[ '-', '-.', '-', '-.', "-",'-.', '-', "-."];     
  
    hcode8(1,:)=[rgb('Silver'),rgb('PowderBlue'),rgb('DeepSkyBlue'), rgb('DodgerBlue'), rgb('Blue'), rgb('DarkBlue'), rgb('RoyalBlue'),rgb('MidnightBlue') ];
    hcode8(2,:)=[rgb('Silver'),rgb('YellowGreen'),rgb('LimeGreen'), rgb('DarkGreen'), rgb('MediumSeaGreen'), rgb('SeaGreen'), rgb('DarkOliveGreen'), rgb('OliveDrab')];	    
    hcode8(3,:)=[rgb('Silver'),rgb('SandyBrown'), rgb('Orange'), rgb('Tomato'), rgb('Coral'), rgb('OrangeRed'), rgb('DarkOrange'),rgb('DarkOrange')];	
    hcode8(4,:)=[rgb('Silver'),rgb('Aquamarine'),rgb('PaleTurquoise'), rgb('Turquoise'), rgb('LightSeaGreen'), rgb('DarkCyan'), rgb('Turquoise'), rgb('LightSeaGreen')];
    hcode8(5,:)=[rgb('Silver'),rgb('Yellow'),rgb('Khaki'),  rgb('Gold'), rgb('Goldenrod'), rgb('DarkGoldenrod'), rgb('Peru'), rgb('Sienna')];	
    hcode8(6,:)=[rgb('Silver'),rgb('LightPink'), rgb('HotPink'), rgb('DeepPink'), rgb('PaleVioletRed'), rgb('MediumVioletRed'), rgb('Violet'), rgb('Orchid')];	
    hcode8(7,:)=[rgb('Silver'),rgb('Red'), rgb('IndianRed'), rgb('Brown'),rgb('Maroon'), rgb('DarkRed'), rgb('Maroon'), rgb('DarkRed')];
     end
 
     
     for i=1:maxi
         if maxi==8
            p(:,i).Color=hcode8(v,(count:count+2));
         else
              p(:,i).Color=hcode(v,(count:count+2));
         end
            xlim([-inf inf])
            %p(:,i).Marker=markerstyle(i);
            p(:,i).LineStyle=linestyle(i);
            p(:,i).LineWidth=1;
   
            count=count+3;
            hold on
            ylabel('CDF')
            title(string(celltype)+" "+string(cbx_out_text(v)))
            xlabel(string(insertxlabel))     
            if maxi==8
               legend("Isotropic","M=2, K=4","M=4, K=4","M=4, K=8", "M=8, K=8", "M=8, K=16", "M=16, K=16", "M=16, K=32")
            elseif maxi==5
               legend("Isotropic", "Case A", "Case B", "Case C", "Case D")
            else
               legend("Isotropic", "TX", "TX RX: SNR exhaustive search", "TX RX: SINR exhaustive search")
            end
     end
   end
end
            
 


   
       