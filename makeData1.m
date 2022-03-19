function [data] = makeData1()
data=zeros(50,100,50);
sz=size(data);

for i = 1:sz(1)
    for j = 1:sz(2)
       for k = 1:sz(3)
           a=i-25;
           b=j-25;
           c=k-25;
           radius=a*a+b*b+c*c;
           if(radius>98 && radius < 102)
               data(i,j,k)=1;
           end
       end
    end
end

data(10:40,60,10)=1;
data(10:40,60,40)=1;
data(10:40,90,10)=1;
data(10:40,90,40)=1;
data(10,60:90,10)=1;
data(10,60:90,40)=1;
data(40,60:90,10)=1;
data(40,60:90,40)=1;
data(40,60,10:40)=1;
data(10,60,10:40)=1;
data(40,90,10:40)=1;
data(10,90,10:40)=1;