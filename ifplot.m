function ifplot(sortDist_km, PL, loop)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b
global celltype
global cbx_out_text
    a=1;
    hcode=[rgb('RoyalBlue'),rgb('DarkGreen'),rgb('Tomato'),rgb('Turquoise'), rgb('Gold'),rgb('DeepPink'), rgb('DarkRed')];	

    
    for i=1:length(loop)
            if isequal(double(loop(i)), 1)
                plot(sort(sortDist_km(:)),  sort(PL(i,:)),'Color',hcode(a:a+2), 'LineWidth', 1);
                a=a+3;
                hold on
            end
    end

    isequal_legendfinal(loop, cbx_out_text)
    xlim([min(sort(sortDist_km(:))) max(sort(sortDist_km(:)))])
    xlabel('Distance (km)')
    ylabel('Path Loss (dB)')
    axis tight
    title(string(celltype)+" "+ "Path Loss versus Distance")
    %hold off

end