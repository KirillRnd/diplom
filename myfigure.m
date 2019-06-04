function h=myfigure(width,height)
% creates a figure with "width" and "height" in cm
%   based on cfigure() function taken from ... (I do not remember)

if nargin < 2 % if only width is given, compute the height
    height = width * 2/(1+sqrt(5)); % use the golden ratio
end


% Get the screen size in centimeters
set(0,'units','centimeters')
scrsz=get(0,'screensize');
% Calculate the position of the figure
position=[scrsz(3)/2-width/2 scrsz(4)/2-height/2 width height];
h=figure;
set(h,'units','centimeters')
% Place the figure
set(h,'position',position)
% Set screen and figure units back to pixels
set(0,'units','pixel')
set(h,'units','pixel')

