function barminmaxmeanMK(iso, mk24, mk44, mk48, mk88, mk816, mk1616, mk1632,cbx_out_text, metric,model, celltype)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b

x1 = categorical({'Isotropic','M=2, K=4','M=4, K=4', 'M=4, K=8', 'M=8, K=8','M=8, K=16','M=16, K=16', 'M=16, K=32'});
X1 = reordercats(x1,{'Isotropic','M=2, K=4','M=4, K=4', 'M=4, K=8', 'M=8, K=8','M=8, K=16','M=16, K=16', 'M=16, K=32'});

    vals = [min(iso(model,:)) mean(iso(model,:)) max(iso(model,:));...
        min(mk24(model,:)) mean(mk24(model,:)) max(mk24(model,:));...
        min(mk44(model,:)) mean(mk44(model,:)) max(mk44(model,:));...
        min(mk48(model,:)) mean(mk48(model,:)) max(mk48(model,:));...
        min(mk88(model,:)) mean(mk88(model,:)) max(mk88(model,:));...
        min(mk816(model,:)) mean(mk816(model,:)) max(mk816(model,:));...
        min(mk1616(model,:)) mean(mk1616(model,:)) max(mk1616(model,:));...
        min(mk1632(model,:)) mean(mk1632(model,:)) max(mk1632(model,:))];
   
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
