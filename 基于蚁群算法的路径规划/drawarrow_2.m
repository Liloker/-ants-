function drawarrow_2(x1,x2,y1,y2,len, arrow_color)
%DRAWARROW connecting two points with a line with arrowhead
%	drawarrow(x1,x2,y1,y2,len) draw an arrowed line from (x1,y1) to (x2,y2),and len is the length of the arrow side.
%	(x1,y1)-->(x2,y2)

cita=pi/12; % default angle between the two sides of arrow is 30
cos_cita=cos(cita);
sin_cita=sin(cita);
if(nargin~=6)
    arrow_color = 'k';
end
    
x=[x1 x2];
y=[y1 y2];

r=len/sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)); % r is the ratio of the length of arrow side to the distance between the two points.
% hdl_line=line(x,y,'color',arrow_color); % you can change the color of line here,default color is black
line(x,y,'color',arrow_color); % you can change the color of line here,default color is black
p1_x=x2;
p1_y=y2;
p2_x=x2+r*(cos_cita*(x1-x2)-sin_cita*(y1-y2));
p2_y=y2+r*(cos_cita*(y1-y2)+sin_cita*(x1-x2));
p3_x=x2+r*(cos_cita*(x1-x2)+sin_cita*(y1-y2));
p3_y=y2+r*(cos_cita*(y1-y2)-sin_cita*(x1-x2));
% hdl_head=patch([p1_x p2_x p3_x],[p1_y p2_y p3_y],arrow_color); % you can change the color of arrow here,default color is black
patch([p1_x p2_x p3_x],[p1_y p2_y p3_y],arrow_color); % you can change the color of arrow here,default color is black


% hline2 = line(t+.06,sin(t),'LineWidth',4,'Color',[.8 .8 .8]);
% 
% % Finally, pull the first line to the front:
% 
% set(gca,'Children',[hline1 hline2])