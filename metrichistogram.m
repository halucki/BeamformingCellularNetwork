function metrichistogram(iso,a,b,c,d,e,f,cbx_out_text,metric,model,celltype)
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
Color2(6,1:3)=rgb('HotPink');
Color2(7,1:3)=rgb('IndianRed');  

Color3(1,1:3)=rgb('DodgerBlue');
Color3(2,1:3)=rgb('MediumSeaGreen');
Color3(3,1:3)=rgb('Tomato');
Color3(4,1:3)=rgb('LightSeaGreen');
Color3(5,1:3)=rgb('Gold');
Color3(6,1:3)=rgb('PaleVioletRed');
Color3(7,1:3)=rgb('Brown'); 

Color4(1,1:3)=rgb('Blue');
Color4(2,1:3)=rgb('DarkGreen');
Color4(3,1:3)=rgb('Coral');
Color4(4,1:3)=rgb('Turquoise');
Color4(5,1:3)=rgb('GoldenRod');
Color4(6,1:3)=rgb('DeepPink');
Color4(7,1:3)=rgb('Maroon'); 

if f~='n'
    subplot(1,3,1)
    h1=histogram(iso(model,:));
    hold on
    h2=histogram(a(model,:));
    hold on
    h3=histogram(b(model,:));
    title(string(celltype)+" "+cbx_out_text(model)+" M=4 "+ string(metric))
    legend("Isotropic","M=4, K=4", "M=4, K=8")
    xlim([-inf inf])
    grid  on
    xlabel(metric)

    subplot(1,3,2)
    h11=histogram(iso(model,:));
    hold on
    h4=histogram(c(model,:));
    hold on
    h5=histogram(d(model,:));
    h5.Normalization='probability';
    title(string(celltype)+" "+cbx_out_text(model)+" M=8 "+ string(metric))
    legend("Isotropic","M=8, K=8", "M=8, K=16")
    xlim([-inf  inf])
    grid  on
    xlabel(metric)

    subplot(1,3,3)
    h111=histogram(iso(model,:));
    hold on
    h6=histogram(e(model,:));
    hold on
    h7=histogram(f(model,:));
    h6.Normalization='probability';
    h7.Normalization='probability';
    title(string(celltype)+" "+cbx_out_text(model)+" M=16 "+ string(metric))
    legend("Isotropic","M=16, K=16", "M=16, K=32")
    xlim([-inf  inf])
    grid  on
    xlabel(metric)

    h3.FaceColor=Color1(model,1:3);
    h5.FaceColor=Color1(model,1:3);
    h7.FaceColor=Color1(model,1:3);

    h2.FaceColor=Color4(model,1:3);
    h4.FaceColor=Color4(model,1:3);
    h6.FaceColor=Color4(model,1:3);
elseif f=='n' 
    if d~='n'
        subplot(1,4,1)
        h1=histogram(iso(model,:));
        hold on
        h2=histogram(a(model,:));
        title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
        legend("Isotropic","Case A")
        xlim([-inf  inf])
        grid  on
        xlabel(metric)

        subplot(1,4,2)
        h11=histogram(iso(model,:));
        hold on
        h3=histogram(b(model,:));
        title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
        legend("Isotropic","Case B")
        xlim([-inf  inf])
        grid  on
        xlabel(metric)

        subplot(1,4,3)
        h111=histogram(iso(model,:));
        hold on
        h4=histogram(c(model,:));
        title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
        legend("Isotropic","Case C")
        xlim([-inf  inf])
        grid  on
        xlabel(metric)

        subplot(1,4,4)
        h1111=histogram(iso(model,:));
        hold on
        h5=histogram(d(model,:));
        title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
        legend("Isotropic","Case D")
        xlim([-inf  inf])
        grid  on
        xlabel(metric)
        
        h5.Normalization='probability';
        h1111.Normalization='probability';

        h2.FaceColor=Color1(model,1:3);
        h3.FaceColor=Color2(model,1:3);
        h4.FaceColor=Color3(model,1:3);
        h5.FaceColor=Color4(model,1:3);
        h1111.FaceColor=rgb('Silver');
    elseif d=='n' 
        subplot(1,3,1)
        h1=histogram(iso(model,:));
        hold on
        h2=histogram(a(model,:));
        title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
        legend("Isotropic","TX")
        xlim([-inf  inf])
        grid  on
        xlabel(metric)

        subplot(1,3,2)
        h11=histogram(iso(model,:));
        hold on
        h3=histogram(b(model,:));
        title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
        legend("Isotropic","TX RX: SNR exhaustive search")
        xlim([-inf  inf])
        grid  on
        xlabel(metric)

        subplot(1,3,3)
        h111=histogram(iso(model,:));
        hold on
        h4=histogram(c(model,:));
        title(string(celltype)+" "+cbx_out_text(model)+" "+ string(metric))
        legend("Isotropic","TX RX: SINR exhaustive search")
        xlim([-inf  inf])
        grid on
        xlabel(metric)

      h2.FaceColor=Color1(model,1:3);
      h3.FaceColor=Color2(model,1:3);
      h4.FaceColor=Color4(model,1:3);
    end
end
h2.Normalization='probability';
h3.Normalization='probability';
h4.Normalization='probability';
h1.Normalization='probability';
h11.Normalization='probability';
h111.Normalization='probability';
h1.FaceColor=rgb('Silver');
h11.FaceColor=rgb('Silver');
h111.FaceColor=rgb('Silver');
end
