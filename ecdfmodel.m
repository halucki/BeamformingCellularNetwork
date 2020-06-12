function ecdfmodel(ISO, a, b, c, d, e, f, g, cbx_out_text, insertxlabel, model, celltype)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b
    linestyle=[ '-', '-.', '-', '--', "-"]; 
     
    hcode(1,:)=[rgb('Silver'),rgb('PowderBlue'),rgb('DeepSkyBlue'), rgb('DodgerBlue'), rgb('Blue'), rgb('DarkBlue'), rgb('RoyalBlue'),rgb('MidnightBlue') ];
    hcode(2,:)=[rgb('Silver'),rgb('YellowGreen'),rgb('LimeGreen'), rgb('DarkGreen'), rgb('MediumSeaGreen'), rgb('SeaGreen'), rgb('DarkOliveGreen'), rgb('OliveDrab')];	    
    hcode(3,:)=[rgb('Silver'),rgb('SandyBrown'), rgb('Orange'), rgb('Tomato'), rgb('Coral'), rgb('OrangeRed'), rgb('OrangeRed'),rgb('OrangeRed')];	
    hcode(4,:)=[rgb('Silver'),rgb('Aquamarine'),rgb('PaleTurquoise'), rgb('Turquoise'), rgb('LightSeaGreen'), rgb('DarkCyan'), rgb('Turquoise'), rgb('LightSeaGreen'),];
    hcode(5,:)=[rgb('Silver'),rgb('Yellow'),rgb('Khaki'),  rgb('Gold'), rgb('Goldenrod'), rgb('DarkGoldenrod'), rgb('Peru'), rgb('Sienna')];	
    hcode(6,:)=[rgb('Silver'),rgb('LightPink'), rgb('HotPink'), rgb('DeepPink'), rgb('PaleVioletRed'), rgb('MediumVioletRed'), rgb('Violet'), rgb('Orchid')];	
    hcode(7,:)=[rgb('Silver'),rgb('Red'), rgb('IndianRed'), rgb('Brown'),rgb('Maroon'), rgb('DarkRed'), rgb('Maroon'), rgb('DarkRed')];	
    
 
    p(:,1)=cdfplot(ISO(model,:));       
    hold on
    p(:,2)=cdfplot(a(model,:));
    p(:,3)=cdfplot(b(model,:));
    p(:,4)=cdfplot(c(model,:));
     a=1;
     
    if d~='n'
      p(:,5)=cdfplot(d(model,:));
      maxi=5;
      linestyle=[ '-', '-', '-.', '--', "-"]; 

    else
      maxi=4;
    end
    
     if e~='n'
      p(:,6)=cdfplot(e(model,:));
      maxi=6;
     end
     
     if f~='n'
      p(:,7)=cdfplot(f(model,:));
      maxi=7;
     end
     
     if g~='n'
      p(:,8)=cdfplot(g(model,:));
      maxi=8;
      linestyle=[ '-', '-.', '-', '-.', "-",'-.', '-', "-."]; 
     end
 
     
     for i=1:maxi
            p(:,i).Color=hcode(model,(a:a+2));
            xlim([-inf inf])
            %p(:,i).Marker=markerstyle(i);
            p(:,i).LineStyle=linestyle(i);
            p(:,i).LineWidth=1;
   
            a=a+3;
            hold on
            ylabel('CDF')
            title(string(celltype)+" "+string(cbx_out_text(model)))
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
            
 


   
       