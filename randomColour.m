function [randColour] = randomColour(N)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 5-June-2020
% Developed in Matlab R2019b

%this function returns a random colour
%%  Vector of colours that can be allocated to a frequency group
%using string (" "), NOT char (' ')!
Colour=["green", "yellow", "magenta", "cyan", "red", "blue", "black"];
randColour = Colour(randperm(length(Colour)));  %returns a vector with the colours in a randomly permutated order
%%
if isequal(N,1) %if cluster size is 1
    for l=1:(length(randColour))
        randColour(l)=randColour(1); %all the colours are the same
    end
end 

end