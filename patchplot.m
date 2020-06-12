function patchplot(x, y, Cx_basestation, Cy_basestation, i)

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b

    %plot(x, y); 
    patch(x, y, i, 'LineStyle', '-','FaceAlpha', .2); 
    plot(Cx_basestation, Cy_basestation,'+')
end
