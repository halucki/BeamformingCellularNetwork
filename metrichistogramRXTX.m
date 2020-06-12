function metrichistogramRXTX(iso,caseD,caseDRXS,caseDRXI,caseD8, cbx_out_text,metric,model,celltype)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b

Color1(1,1:3)=rgb('PowderBlue');
Color1(2,1:3)=rgb('Lime');
Color1(3,1:3)=rgb('SandyBrown');
Color1(4,1:3)=rgb('Aquamarine');
Color1(5,1:3)=rgb('Yellow');
Color1(6,1:3)=rgb('LightPink');
Color1(7,1:3)=rgb('Red');

Color2(1,1:3)=rgb('DeepSkyBlue');
Color2(2,1:3)=rgb('YellowGreen');
Color2(3,1:3)=rgb('Orange');
Color2(4,1:3)=rgb('PaleTurquoise');
Color2(5,1:3)=rgb('Khaki');
Color2(6,1:3)=rgb('Fuchsia');
Color2(7,1:3)=rgb('IndianRed');  

Color3(1,1:3)=rgb('DodgerBlue');
Color3(2,1:3)=rgb('MediumSeaGreen');
Color3(3,1:3)=rgb('Tomato');
Color3(4,1:3)=rgb('LightSeaGreen');
Color3(5,1:3)=rgb('Gold');
Color3(6,1:3)=rgb('MediumVioletRed');
Color3(7,1:3)=rgb('Brown'); 

Color4(1,1:3)=rgb('Blue');
Color4(2,1:3)=rgb('DarkGreen');
Color4(3,1:3)=rgb('Coral');
Color4(4,1:3)=rgb('Turquoise');
Color4(5,1:3)=rgb('GoldenRod');
Color4(6,1:3)=rgb('Violet');
Color4(7,1:3)=rgb('Maroon'); 
 
subplot(1,4,1)
h1=histogram(iso(model,:));
hold on
h2=histogram(caseD(model,:));
title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
legend("Isotropic","Tx only")
xlim([-inf  inf])
grid  on
xlabel(metric)

subplot(1,4,2)
h11=histogram(iso(model,:));
hold on
h3=histogram(caseDRXS(model,:));
title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
legend("Isotropic","Tx+Rx: max-SNR")
xlim([-inf inf])
grid  on
xlabel(metric)

subplot(1,4,3)
h111=histogram(iso(model,:));
hold on
h4=histogram(caseDRXI(model,:));
title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
legend("Isotropic","Tx+Rx: max-SINR")
xlim([-inf  inf])
grid  on
xlabel(metric)

subplot(1,4,4)
h1111=histogram(iso(model,:));
hold on
h5=histogram(caseD8(model,:));
title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
legend("Isotropic","Tx only: 2x Antennas")
xlim([-inf  inf])
grid  on
xlabel(metric)

h1.Normalization='probability';
h2.Normalization='probability';
h3.Normalization='probability';
h4.Normalization='probability';
h5.Normalization='probability';
h11.Normalization='probability';
h111.Normalization='probability';
h1111.Normalization='probability';


h1.FaceColor=rgb('Silver');
h2.FaceColor=Color1(model,1:3);
h3.FaceColor=Color2(model,1:3);
h4.FaceColor=Color3(model,1:3);
h5.FaceColor=Color4(model,1:3);
h11.FaceColor=rgb('Silver');
h111.FaceColor=rgb('Silver');
h1111.FaceColor=rgb('Silver');

end
