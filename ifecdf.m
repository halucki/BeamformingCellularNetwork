function ifecdf(metric, loop, insertxlabel)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b
global cbx_out_text
global celltype
    hcode=[rgb('RoyalBlue'),rgb('DarkGreen'),rgb('Tomato'),rgb('Turquoise'), rgb('Gold'),rgb('DeepPink'), rgb('DarkRed')];	
    a=1;

    for i=1:length(loop)
        if isequal(double(loop(i)), 1)
            p(:,i)=cdfplot(metric(i,:));
            hold on

        end
            
    end
    
    for i=1:length(loop)
        if isequal(double(loop(i)), 1)
            p(:,i).Color=hcode(a:a+2);
            p(:,i).LineWidth=1;

            a=a+3;
            hold on
        end
    end
    xlim([bounds(metric,'all') inf])
    xlabel(string(insertxlabel))
    isequal_legendfinal(loop, cbx_out_text);

    xlim([bounds(metric,'all') inf])
    ylabel('CDF')
    title(string(celltype))
end
