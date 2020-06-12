function barminmaxmeanRXTX(iso, caseD, caseDRXS, caseDRXI, caseD8, cbx_out_text, metric,model, celltype)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b

x1 = categorical({'Isotropic','Tx only','Tx+Rx: max-SNR', 'Tx Rx: max-SINR','Tx only: 2x Antennas'});
X1 = reordercats(x1,{'Isotropic','Tx only', 'Tx+Rx: max-SNR', 'Tx Rx: max-SINR', 'Tx only: 2x Antennas'});

    vals = [min(iso(model,:)) mean(iso(model,:)) max(iso(model,:));...
        min(caseD(model,:)) mean(caseD(model,:)) max(caseD(model,:));...
        min(caseDRXS(model,:)) mean(caseDRXS(model,:)) max(caseDRXS(model,:));...
        min(caseDRXI(model,:)) mean(caseDRXI(model,:)) max(caseDRXI(model,:));...
        min(caseD8(model,:)) mean(caseD8(model,:)) max(caseD8(model,:))];   
     b=bar(X1,vals);
     legend({'Min', 'Mean', 'Max'})

xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips3 = b(3).XEndPoints;
ytips3 = b(3).YEndPoints;
labels3 = string(b(3).YData);
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

grid on
ylabel(metric)
title(string(celltype)+" "+cbx_out_text(model)+" "+ metric)

b(1).FaceColor=rgb('Red');
b(2).FaceColor=rgb('Gold');
b(3).FaceColor=[0.4660, 0.6740, 0.1880];
end
