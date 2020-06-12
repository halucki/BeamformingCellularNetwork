function plotecdfRXTX(ISO,caseD, caseDRXS, caseDRXI,caseD8,loop, cbx_out_text, insertxlabel, celltype)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 5-June-2020
% Developed in Matlab R2019b
    linestyle=[ '-', '-.', '-', '-', "-."]; 
   
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
    p(:,2)=cdfplot(caseD(v,:));
    p(:,3)=cdfplot(caseDRXS(v,:));
    p(:,4)=cdfplot(caseDRXI(v,:));
    p(:,5)=cdfplot(caseD8(v,:));
    maxi=5;

    hcode(1,:)=[rgb('Silver'),rgb('PowderBlue'),rgb('DeepSkyBlue'), rgb('DodgerBlue'), rgb('Blue'), rgb('DarkBlue'), rgb('RoyalBlue'),rgb('MidnightBlue') ];
    hcode(2,:)=[rgb('Silver'),rgb('YellowGreen'),rgb('LimeGreen'), rgb('DarkGreen'), rgb('MediumSeaGreen'), rgb('SeaGreen'), rgb('DarkOliveGreen'), rgb('OliveDrab')];	    
    hcode(3,:)=[rgb('Silver'),rgb('SandyBrown'), rgb('Orange'), rgb('Tomato'), rgb('Coral'), rgb('OrangeRed'), rgb('OrangeRed'),rgb('OrangeRed')];	
    hcode(4,:)=[rgb('Silver'),rgb('Aquamarine'),rgb('PaleTurquoise'), rgb('Turquoise'), rgb('LightSeaGreen'), rgb('DarkCyan'), rgb('Turquoise'), rgb('LightSeaGreen'),];
    hcode(5,:)=[rgb('Silver'),rgb('Yellow'),rgb('Khaki'),  rgb('Gold'), rgb('Goldenrod'), rgb('DarkGoldenrod'), rgb('Peru'), rgb('Sienna')];	
    hcode(6,:)=[rgb('Silver'),rgb('LightPink'),rgb('Fuchsia'),rgb('MediumVioletRed'),  rgb('Violet'), rgb('DeepPink'),  rgb('Violet'), rgb('Orchid')];	
    hcode(7,:)=[rgb('Silver'),rgb('Red'), rgb('IndianRed'), rgb('Brown'),rgb('Maroon'), rgb('DarkRed'), rgb('Maroon'), rgb('DarkRed')];
     
     for i=1:maxi
            p(:,i).Color=hcode(v,(count:count+2));
            xlim([-inf inf])
            %p(:,i).Marker=markerstyle(i);
            p(:,i).LineStyle=linestyle(i);
            p(:,i).LineWidth=1;
   
            count=count+3;
            hold on
            ylabel('CDF')
            title(string(celltype)+" "+string(cbx_out_text(v)))
            xlabel(string(insertxlabel))     
            
            legend("Isotropic", "TX", "TX RX: SNR", "TX RX: SINR", "TX: 2x Antennas");
     end
   end
end
            
 


   
       