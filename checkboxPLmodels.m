function [cbx_out_value, cbx_out_text, bg_out_text]=checkboxPLmodels
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 12-May-2020
% Developed in Matlab R2019b

% Opens a user interface check box with default states (only FSPL ticked), 
% allowing the read to check the boxes of the path loss models he/she would
% like to see the results of and to select the desired environment settings
% by pressing on the corresponding radio buttons. Has logical restrictions
% (e.g.: if Cost-231 Walfish-Ikegami is checked but both LoS and non-LoS are
% not, it returns an error). 

fig = uifigure('Position',[680 678 375 430]);
label1 = uilabel(fig,'Position',[25 405 300 15],'Text',....
    'Tick the path loss models you want to plot:');	
% [25 405 300 15] are [left bottom width height]

cbx1 = uicheckbox(fig, 'Text','Free Space Path Loss (FSPL)','FontWeight',...
    'bold', 'Value', 1,'Position',[25 365 250 15],'ValueChangedFcn',...
    @(cbx1,event) cbx1BoxChanged(cbx1));
%% Okumura-Hata
bg1_out='Urban';
bg1 = uibuttongroup(fig,'Position',[25 315 327 25],'SelectionChangedFcn',@bg1selection);  

rb1 = uiradiobutton(bg1,'Position',[5 5 50 15], 'Text', 'Urban', 'Enable', 'off');
rb2 = uiradiobutton(bg1,'Position',[85 5 75 15], 'Text', 'Suburban', 'Enable', 'off');
rb3 = uiradiobutton(bg1,'Position',[185 5 80 15], 'Text', 'Open area', 'Enable', 'off');
bg2_out='Large';
bg2 = uibuttongroup(fig,'Position',[25 287.5 327 25],'SelectionChangedFcn',@bg2selection);

rb4 = uiradiobutton(bg2,'Position',[5 5 50 15], 'Text','Large', 'Enable', 'off');
rb5 = uiradiobutton(bg2,'Position',[85 5 100 15], 'Text', 'Small/Medium', 'Enable', 'off');
             
              
cbx2 = uicheckbox(fig, 'Text','Okumura-Hata','FontWeight', 'bold','Value',...
    0,'Position',[25 345 250 15],'ValueChangedFcn',...
    @(cbx2,event) cbx2BoxChanged(cbx2,rb1,rb2,rb3,rb4,rb5));
%% Cost-231 Hata
bg3_out='Metropolitan centres'; 
bg4_out='Large'; 
bg3 = uibuttongroup(fig,'Position',[25 235 327 25],'SelectionChangedFcn',@bg3selection);  

rb6 = uiradiobutton(bg3,'Position',[5 5 150 15], 'Text', 'Metropolitan centres', 'Enable', 'off');
rb7 = uiradiobutton(bg3,'Position',[185 5 200 15], 'Text', 'Medium city/Suburban', 'Enable', 'off');

bg4 = uibuttongroup(fig,'Position',[25 207.5 327 25],'SelectionChangedFcn',@bg4selection);

rb8 = uiradiobutton(bg4,'Position',[5 5 50 15], 'Text','Large', 'Enable', 'off');
rb9 = uiradiobutton(bg4,'Position',[85 5 100 15], 'Text', 'Small/Medium', 'Enable', 'off');

cbx3 = uicheckbox(fig, 'Text','Cost-231 Hata','FontWeight', 'bold','Value',...
    0,'Position',[25 265 250 15],'ValueChangedFcn',...
    @(cbx3,event) cbx3BoxChanged(cbx3,rb6,rb7,rb8,rb9));
 
%% Cost-231 Walfisch-Ikegami
pnl = uipanel(fig,'Position',[25 155 327 25]);
bg5_out='Urban';
bg5 = uibuttongroup(fig,'Position',[25 127.5 327 25],'SelectionChangedFcn',@bg5selection);  

rb10 = uiradiobutton(bg5,'Position',[5 5 50 15], 'Text', 'Urban', 'Enable', 'off');
rb11 = uiradiobutton(bg5,'Position',[85 5 75 15], 'Text', 'Suburban', 'Enable', 'off');

cbx4 = uicheckbox(fig, 'Text','LoS','Value', 1,'Position',[30 160 50 15], ...
    'ValueChangedFcn',@(cbx4,event) cbx4BoxChanged(cbx4),'Enable', 'off');
cbx5 = uicheckbox(fig, 'Text','Non-LoS','Value', 1,'Position',[110 160 75 15], ...
    'ValueChangedFcn',@(cbx5,event) cbx5BoxChanged(cbx5),'Enable', 'off');
              
cbx6 = uicheckbox(fig, 'Text','Cost-231 Walfisch-Ikegami','FontWeight',...
    'bold','Value', 0,'Position',[25 185 250 15], 'ValueChangedFcn',...
    @(cbx6,event) cbx6BoxChanged(cbx4,cbx5,cbx6,rb10,rb11));
%% SUI
bg6_out='A';
bg6 = uibuttongroup(fig,'Position',[25 75 327 25],'SelectionChangedFcn',@bg6selection);

rb12 = uiradiobutton(bg6,'Position',[5 5 150 15], 'Text','A', 'Enable', 'off');
rb13 = uiradiobutton(bg6,'Position',[85 5 100 15], 'Text', 'B', 'Enable', 'off');
rb14 = uiradiobutton(bg6,'Position',[185 5 100 15], 'Text', 'C', 'Enable', 'off');
cbx7 = uicheckbox(fig, 'Text','Stanford University Interim (SUI)',...
    'FontWeight', 'bold','Value', 0,'Position',[25 105 250 15],...
    'ValueChangedFcn',@(cbx7,event) cbx7BoxChanged(cbx7,rb12,rb13,rb14));
%% ECC33
cbx8 = uicheckbox(fig, 'Text','ECC33','FontWeight', 'bold','Value', 0,...
    'Position',[25 52.5 250 15],'ValueChangedFcn',@(cbx8,event) cbx8BoxChanged(cbx8));              

function bg1selection(source,event)
       bg1_out=event.NewValue.Text;
end
function bg2selection(source,event)
       bg2_out=event.NewValue.Text;
end
function bg3selection(source,event)
       bg3_out=event.NewValue.Text;
end
function bg4selection(source,event)
       bg4_out=event.NewValue.Text;
end
function bg5selection(source,event)
       bg5_out=event.NewValue.Text;
end
function bg6selection(source,event)
       bg6_out=event.NewValue.Text;
end
btn = uibutton(fig,'Text','OK','Position',[140.5 15 100 20],...
    'ButtonPushedFcn', {@ButtonPushed, fig});
uiwait(fig);
if isgraphics(fig)
    cbx1_out=cbx1.Value;
    cbx2_out=cbx2.Value;
    cbx3_out=cbx3.Value;
    cbx4_out=cbx4.Value;
    cbx5_out=cbx5.Value;
    cbx6_out=cbx6.Value;
    cbx7_out=cbx7.Value;
    cbx8_out=cbx8.Value;
    if isequal(cbx1_out,1)
        cbx1_out=cbx1.Value;
    end
    if isequal(cbx2_out,1)
        cbx2_out=cbx2.Value;
    end
    if isequal(cbx3_out,1)
        cbx3_out=cbx3.Value;
    end
    if isequal(cbx4_out,1)
        cbx4_out=cbx4.Value;
    end
    if isequal(cbx5_out,1)
        cbx5_out=cbx5.Value;
    end   
    if isequal(cbx7_out,1)
        cbx7_out=cbx7.Value;
    end   
    if isequal(cbx8_out,1)
        cbx8_out=cbx8.Value;
    end     
    while isequal(cbx6_out,1)&&isequal(cbx4_out,0)&&isequal(cbx5_out,0)
        opts=struct('WindowStyle', 'modal', 'Interpreter','tex');
        error = errordlg('At least one of the LoS/non-LoS boxes must be ticked if Cost-231 Walfisch-Ikegami is selected!',...
             'Error', opts);
        waitfor(error);
        [cbx1_out, cbx2_out, bg1_out, bg2_out, cbx3_out, bg3_out, bg4_out, cbx4_out, cbx5_out, cbx6_out, bg5_out, cbx7_out, bg6_out, cbx8_out]=checkbox;
    end  
    if isequal(cbx6_out,1)
        cbx6_out=cbx6.Value;
    end    
    cbx_out_value(1,:)=[cbx1_out, cbx2_out, cbx3_out, cbx4_out, cbx5_out, cbx6_out, cbx7_out, cbx8_out];
    cbx_out_text(1,:)=[string(cbx1.Text), string(cbx2.Text), string(cbx3.Text), string(cbx4.Text)+" Cost-231 Walfisch-Ikegami", string(cbx5.Text)+" Cost-231 Walfisch-Ikegami", string(cbx7.Text), string(cbx8.Text)];
    bg_out_text(1,:)=[string(bg1_out),string(bg2_out),string(bg3_out),string(bg4_out), string(bg5_out), string(bg6_out)];
    delete(fig)
else 
end
end
% Create the function for the ValueChangedFcn callback:
function cbx1BoxChanged(cbx1)
val = cbx1.Value;
end
function cbx2BoxChanged(cbx2,rb1,rb2,rb3,rb4,rb5)
val = cbx2.Value;
if isequal(val,0)
    rb1.Enable = 'off';
    rb2.Enable = 'off';
    rb3.Enable = 'off';
    rb4.Enable = 'off';
    rb5.Enable = 'off'; 
elseif isequal(val,1)
    rb1.Enable = 'on';
    rb2.Enable = 'on';
    rb3.Enable = 'on';
    rb4.Enable = 'on';
    rb5.Enable = 'on';  
end
end
function cbx3BoxChanged(cbx3,rb6,rb7,rb8,rb9)
val = cbx3.Value;
if isequal(val,0)
    rb6.Enable = 'off';
    rb7.Enable = 'off';
    rb8.Enable = 'off';
    rb9.Enable = 'off';
elseif isequal(val,1)
    rb6.Enable = 'on';
    rb7.Enable = 'on'; 
    rb8.Enable = 'on';
    rb9.Enable = 'on'; 
end
end

function cbx4BoxChanged(cbx4)
val = cbx4.Value;
end
function cbx5BoxChanged(cbx5)
val = cbx5.Value;
end
function cbx6BoxChanged(cbx4,cbx5,cbx6,rb10,rb11)
val = cbx6.Value;
if isequal(val,0)
    rb10.Enable = 'off';
    rb11.Enable = 'off'; 
    cbx4.Enable = 'off';
    cbx5.Enable = 'off';
elseif isequal(val,1)
    rb10.Enable = 'on';
    rb11.Enable = 'on'; 
    cbx4.Enable = 'on';
    cbx5.Enable = 'on'; 
end
end
function cbx7BoxChanged(cbx7,rb12,rb13,rb14)
val = cbx7.Value;
if isequal(val,0)
    rb12.Enable = 'off';
    rb13.Enable = 'off'; 
    rb14.Enable = 'off';
elseif isequal(val,1)
    rb12.Enable = 'on';
    rb13.Enable = 'on';
    rb14.Enable = 'on';
end
end
function cbx8BoxChanged(cbx8)
val = cbx8.Value;
end
function ButtonPushed(btn, EventData, fig)
uiresume(fig);
end
