function [data] = makeData3()
data=zeros(50, 50,50);

r1=10;
r2=15;
r3=12;

for i = 1:50 
    for j = 1:50
       for k = 1:50
           a=i-25;
           b=j-25;
           c=k-25;
           sum=a*a/r1/r1+b*b/r2/r2+c*c/r3/r3;
           if(sum>0.985 && sum < 1.015)
               data(i,j,k)=1;
           end
       end
    end
end

