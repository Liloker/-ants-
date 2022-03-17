function new_r = get_neighbour( r,n )


a=2+floor(rand*(length(r)-1));
b=a;
new_r = r;
while(a==b) 
    b=2+floor(rand*(length(new_r)-1));
end;

tmp = new_r(a);
new_r(a)=new_r(b);
new_r(b) = tmp;

inx = 1;

for i=1:length(new_r)
    if(new_r(i)<=n)
       new_r(i) = inx;
       inx = inx +1;
    end    
end

%dalsze s¹siedztwo
if(rand>0.7)
    %display('G³êbokie s¹siedztwo');
    new_r = get_neighbour( new_r,n );
end;

end

