function [bg_out_model_text, model]=pickModel

% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 10-June-2020
% Developed in Matlab R2019b

    fig = uifigure('Position',[680 678 250 300], 'Name','Select ONE main model');
    bg_out='FSPL';
    bg = uibuttongroup(fig,'Position',[15 40 220 240], 'SelectionChangedFcn',@bgselection); 
    
    rb1 = uiradiobutton(bg,'Position',[10 210 140 20]);
    rb2 = uiradiobutton(bg,'Position',[10 180 140 20]);
    rb3 = uiradiobutton(bg,'Position',[10 150 140 20]);
    rb4 = uiradiobutton(bg,'Position',[10 120 190 20]);
    rb5 = uiradiobutton(bg,'Position',[10 90 210 20]);
    rb6 = uiradiobutton(bg,'Position',[10 60 190 20]);
    rb7 = uiradiobutton(bg,'Position',[10 30 140 20]);

    rb1.Text = 'FSPL';
    rb2.Text = 'Okumura-Hata';
    rb3.Text = 'Cost231-Hata';
    rb4.Text = 'LoS Cost231-Walfish-Ikegami';
    rb5.Text = 'Non-LoS Cost231-Walfish-Ikegami';
    rb6.Text = 'SUI';
    rb7.Text = 'ECC33';    
btn = uibutton(fig,'Text','OK','Position',[80 15 90 20],...
    'ButtonPushedFcn', {@ButtonPushed, fig});
function bgselection(~,event)
       bg_out=event.NewValue.Text;
end

uiwait(fig);
if isgraphics(fig)
  
    bg_out_model_text=string(bg_out);
    if bg_out_model_text==rb1.Text
        model=1;
    elseif bg_out_model_text==rb2.Text
        model=2;
    elseif bg_out_model_text==rb3.Text
        model=3;
    elseif bg_out_model_text==rb4.Text
        model=4;
    elseif bg_out_model_text==rb5.Text
        model=5;
    elseif bg_out_model_text==rb6.Text
        model=6;
    elseif bg_out_model_text==rb7.Text
        model=7;
    end
    delete(fig)
 
end
end



function ButtonPushed(btn, EventData, fig)
uiresume(fig);
end
