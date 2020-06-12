function [d, departureangle, arrivalangle] = distanceangle(pointBS, pointUE)
% Author: Hannah Andrade Lucki
% University email: ha17181@bristol.ac.uk 
% Personal email: hannah.lucki@outlook.com
% May 2020; Last revision: 12-May-2020
% Developed in Matlab R2019b
    xBS=pointBS(1);
    yBS=pointBS(2);
    xUE=pointUE(1);
    yUE=pointUE(2);

    d=sqrt((xUE-xBS).^2+(yUE-yBS).^2); %Euclidean distance between BS and UE

    %angle=azimuth(yBS, xBS, yUE, xUE);

    y=yBS-yUE;
    x=xBS-xUE;
       
    departureangle=atan(y/x);
    arrivalangle=atan2(y,x);

    departureangle=rad2deg(departureangle);
    arrivalangle=rad2deg(arrivalangle); 
    
  if departureangle>0 
      if xBS<xUE
          arrivalangle=arrivalangle+180;
      elseif xBS>xUE
          departureangle=departureangle+180;
      end

  elseif departureangle<0  %all angles need to be positive
        if xBS<xUE
            departureangle=departureangle+360;
            arrivalangle=arrivalangle+180;
        elseif xBS>xUE
             departureangle=departureangle+180;
             arrivalangle=arrivalangle+360;
        end 
  end
    
   if  departureangle>180
         arrivalangle=departureangle-180;
   elseif  departureangle<180 %all angles need to be positive
        arrivalangle=departureangle+180;
   end

end          