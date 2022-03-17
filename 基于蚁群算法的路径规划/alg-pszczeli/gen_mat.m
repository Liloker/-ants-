function m = gen_mat(size,n)
%m = gen_mat(size,n)
for i=1:(n+size-1)
   for j=1:i
       if (i==j)
          m(i,j)=inf; 
       elseif (i<=n & j<=n)
           m(i,j)=0;
           m(j,i)=0;
       else
           m(i,j)=rand;
           m(j,i)=m(i,j);           
       end
   end
end

for i=1:n
   m(i,n+1:size) = m(1,n+1:size);
   m(n+1:size,i) = m(n+1:size,1);
end

end