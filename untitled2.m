clc;clear;
data=zeros(100,100,50);

r=10;
rr1=r*r-2;
rr2=r*r+2;

parfor (i = 15:35,4) %r=10 x=25 y=75
    for j = 65:85
       for k = 15:35
           a=i-25;
           b=j-75;
           c=k-25;
           radius=a*a+b*b+c*c;
           if(radius>rr1 && radius < rr2)
               data(i,j,k)=1;
           end
       end
    end
end

[X,Y,Z]=ind2sub(size(data),find(data));