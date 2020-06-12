function plotHEATMAPmodels(metricmodels, xqlin, yqlin, r, loop, cbx_out_text, insertxlabel, celltype)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b
    en=0;
    for n=1:length(loop)
        if loop(n)==1
                 en=[en,n];
        end
    end
    if en(1)==0
        en(1)=[];
    end
   stringtitles=cbx_out_text+" "+string(insertxlabel);

   for u=1:length(en)
      a=1;
      if sum(loop)==7
        subplot(3,3,u);
      elseif sum(loop)<7 && sum(loop)>4
          subplot(2,3,u)
      elseif sum(loop)<=4
          subplot(2,2,u)
      elseif sum(loop)<=2
          subplot(1,2,u)
      elseif sum(loop)==1
          subplot(1,1,u)
      end
      
    v=en(u);
    scatter(xqlin,yqlin,1,metricmodels(v,:))
    colormap jet
    cbar=colorbar;
    hold on
    scatter(xqlin,yqlin+2*r,1,metricmodels(v,:))
    scatter(xqlin,yqlin-2*r,1,metricmodels(v,:))
    scatter(xqlin-sqrt(3)*r,yqlin-r,1,metricmodels(v,:))
    scatter(xqlin+sqrt(3)*r,yqlin-r,1,metricmodels(v,:))
    scatter(xqlin+sqrt(3)*r,yqlin+r,1,metricmodels(v,:))
    scatter(xqlin-sqrt(3)*r,yqlin+r,1,metricmodels(v,:))
    title(string(celltype)+" "+stringtitles(v));  
    
    cbar.Label.String = 'SINR (dB)';
    axis square
    grid on
          
   end

end
   
       
       
      
     
