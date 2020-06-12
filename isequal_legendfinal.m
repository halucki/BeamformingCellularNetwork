function isequal_legendfinal(loop, cbx_out_text)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 15-May-2020
% Developed in Matlab R2019b

str=cbx_out_text;

l=length(loop);
for n=1:l
    if isequal(loop(n),1)
        str(n)=cbx_out_text(n);
    
    elseif isequal(loop(n),0)
            str(n)="";
 
    end
end
for m=1:7
l=length(str);
    for n=1:l
        if length(str)>=n
            if isequal(str(n),"")
                str(n)=[];
            end
            if n>=2
                if isequal(str(n-1),"")
                    str(n-1)=[];
                end
            end     
        end       
    end
end
% ll=length(str);
% for n=1:ll
%     if length(str)>=ll
%         if isequal(str(n),"")
%             str(n)=[];
%         end
%     end
% end    
%     
% if isequal(str(1),"")
%     str(1)=[];
% end


if sum(loop)==7
     legend(string(str(1)), string(str(2)), string(str(3)), string(str(4)), string(str(5)), string(str(6)), string(str(7)))
elseif sum(loop)==6
     legend(string(str(1)), string(str(2)), string(str(3)), string(str(4)), string(str(5)), string(str(6)))
elseif sum(loop)==5
     legend(string(str(1)), string(str(2)), string(str(3)), string(str(4)), string(str(5)))
elseif sum(loop)==4
     legend(str(1), str(2), str(3), str(4))
elseif sum(loop)==3
     legend(str(1),str(2),str(3))
elseif  sum(loop)==2
    legend(string(str(1)), string(str(2)))
elseif sum(loop)==1
    legend(string(str(1)))
end

end
