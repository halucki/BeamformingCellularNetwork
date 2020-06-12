function ecdfRXTXmodel(ISO, caseD, caseDRXS, caseDRXI,caseD8, cbx_out_text, insertxlabel, model, celltype)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b
    linestyle=[ '-', '-.', '-', '-', "-."]; 
    
    hcode(1,:)=[rgb('Silver'),rgb('PowderBlue'),rgb('DeepSkyBlue'), rgb('DodgerBlue'), rgb('Blue'), rgb('DarkBlue'), rgb('RoyalBlue'),rgb('MidnightBlue') ];
    hcode(2,:)=[rgb('Silver'),rgb('YellowGreen'),rgb('LimeGreen'), rgb('DarkGreen'), rgb('MediumSeaGreen'), rgb('SeaGreen'), rgb('DarkOliveGreen'), rgb('OliveDrab')];	    
    hcode(3,:)=[rgb('Silver'),rgb('SandyBrown'), rgb('Orange'), rgb('Tomato'), rgb('Coral'), rgb('OrangeRed'), rgb('OrangeRed'),rgb('OrangeRed')];	
    hcode(4,:)=[rgb('Silver'),rgb('Aquamarine'),rgb('PaleTurquoise'), rgb('Turquoise'), rgb('LightSeaGreen'), rgb('DarkCyan'), rgb('Turquoise'), rgb('LightSeaGreen'),];
    hcode(5,:)=[rgb('Silver'),rgb('Yellow'),rgb('Khaki'),  rgb('Gold'), rgb('Goldenrod'), rgb('DarkGoldenrod'), rgb('Peru'), rgb('Sienna')];	
    hcode(6,:)=[rgb('Silver'),rgb('LightPink'),rgb('Fuchsia'),rgb('MediumVioletRed'),  rgb('Violet'), rgb('DeepPink'),  rgb('Violet'), rgb('Orchid')];	
    hcode(7,:)=[rgb('Silver'),rgb('Red'), rgb('IndianRed'), rgb('Brown'),rgb('Maroon'), rgb('DarkRed'), rgb('Maroon'), rgb('DarkRed')];
        
        
    p(:,1)=cdfplot(ISO(model,:));       
    hold on
    p(:,2)=cdfplot(caseD(model,:));
    p(:,3)=cdfplot(caseDRXS(model,:));
    p(:,4)=cdfplot(caseDRXI(model,:));
    p(:,5)=cdfplot(caseD8(model,:));

     a=1;
     for i=1:5

            p(:,i).Color=hcode(model,(a:a+2));
            xlim([-inf inf])
            %p(:,i).Marker=markerstyle(i);
            p(:,i).LineStyle=linestyle(i);
            p(:,i).LineWidth=1;
   
            a=a+3;
            hold on
            ylabel('CDF')
            legend("Isotropic", "Tx only", "Tx+Rx: max-SNR", "Tx+Rx: max-SINR", "Tx only: 2x Antennas");
            title(string(celltype)+" "+string(cbx_out_text(model)))
            xlabel(string(insertxlabel))

     end
   end
            
 


   
       