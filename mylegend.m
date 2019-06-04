% take 2 cell arrays as arg's
% 1st is the legend
% 2nd is the userdata for matlabfrag
function l=mylegend(lgnds,usrdta_in)

l=legend(lgnds);

if nargin>1 % userdata is given
   % make sure the legend and the userdata are the same length
   usrdta=lgnds;
   for i=1:min(length(usrdta),length(usrdta_in))
	  usrdta{i} = usrdta_in{i};
   end
    
   lchild=get(l,'children');
   i_max=length(usrdta);
  
   for i=1:i_max
       i_child=3*i_max-(i-1)*3 ;
       %fprintf('i_child=%d i=%d\n',i_child,i);
       set(lchild(i_child),'Userdata',sprintf('matlabfrag:%s',usrdta{i}));
       %fprintf('%s\n',get(lchild(i_child),'UserData'));
   end
  
end


end
