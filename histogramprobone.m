function histogramprob(a,b,c,d,e,f,g,i,j,k,l,m,n,o,celltype,index1,index2, gaintype, redpurple, prob)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 18-May-2020
% Developed in Matlab R2019b


%celltype can be "Macrocell", "Microcell" or "mm-Wave Picocell"
%gaintype can be either "Central Basestation" or "Highest Gain"
%index1 can be either "Highest" or "Central BS"
%index2 can be either "Lowest" or "Interfering BS"
%redpurple can be either "red" or "purple"
subplot(2,4,1)
h1=histogram(a);
hold on
h2=histogram(i);
if prob=="Yes"
    h1.Normalization='probability';
    h2.Normalization='probability';
end
legend(index1,index2)
title(string(celltype)+" "+string(gaintype)+" Beam Pattern Number M=2, K=4")
xlabel('Beam Pattern Number')
grid on

subplot(2,4,2)
h3=histogram(c);
hold on
h4=histogram(k);
if prob=="Yes"
    h3.Normalization='probability';
    h4.Normalization='probability';
end
legend(index1,index2)
title(string(celltype)+" "+string(gaintype)+" Beam Pattern Number M=4, K=8")
xlabel('Beam Pattern Number')
grid on

subplot(2,4,3)
h5=histogram(e);
hold on
h6=histogram(m);
if prob=="Yes"
    h5.Normalization='probability';
    h6.Normalization='probability';
end
legend(index1,index2)
title(string(celltype)+" "+string(gaintype)+" Beam Pattern Number M=8, K=16")
xlabel('Beam Pattern Number')
grid on


subplot(2,4,4)
h7=histogram(g);
hold on
h8=histogram(o);
if prob=="Yes"
    h7.Normalization='probability';
    h8.Normalization='probability';
end
legend(index1,index2)
title(string(celltype)+" "+string(gaintype)+" Beam Pattern Number M=16, K=32")
xlabel('Beam Pattern Number')
grid on


subplot(2,4,5)
h9=histogram(b);
hold on
h10=histogram(j);
if prob=="Yes"
    h9.Normalization='probability';
    h10.Normalization='probability';
end
legend(index1,index2)
title(string(celltype)+" "+string(gaintype)+" Beam Pattern Number M=4, K=4")
xlabel('Beam Pattern Number')
grid on


subplot(2,4,6)
h11=histogram(d);
hold on
h12=histogram(l);
if prob=="Yes"
    h11.Normalization='probability';
    h12.Normalization='probability';
end
legend(index1,index2)
title(string(celltype)+" "+string(gaintype)+" Beam Pattern Number M=8, K=8")
xlabel('Beam Pattern Number')
grid on


subplot(2,4,7)
h13=histogram(f);
hold on
h14=histogram(n);
if prob=="Yes"
    h13.Normalization='probability';
    h14.Normalization='probability';
end
legend(index1,index2)
title(string(celltype)+" "+string(gaintype)+" Beam Pattern Number M=16, K=16")
xlabel('Beam Pattern Number')
grid on

if redpurple=="purple"
    h2.FaceColor=[0.4940 0.1840 0.5560];

    h4.FaceColor=[0.4940 0.1840 0.5560];

    h6.FaceColor=[0.4940 0.1840 0.5560];

    h8.FaceColor=[0.4940 0.1840 0.5560];

    h10.FaceColor=[0.4940 0.1840 0.5560];

    h12.FaceColor=[0.4940 0.1840 0.5560];

    h14.FaceColor=[0.4940 0.1840 0.5560];
end
end
