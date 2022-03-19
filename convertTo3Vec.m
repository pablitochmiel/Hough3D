function [x,y,z] = convertTo3Vec(data)
max=sum(sum(sum(data==1)));
x=zeros(max,0);
y=zeros(max,0);
z=zeros(max,0);
sz=size(data);
index=1;

for i = 1:sz(1)
    for j = 1:sz(2)
       for k = 1:sz(3)
           if(data(i,j,k)==1)
               x(index)=i;
               y(index)=j;
               z(index)=k;
               index=index+1;
           end
       end
    end
end