function [data] = makeData4()
data=zeros(50,100,50);
sz=size(data);

for i = 1:sz(1)
    for j = 1:sz(2)/2
       for k = 10:40
           a=i-25;
           b=j-25;
           radius=a*a+b*b;
           if((radius>390 && radius < 410))
               data(i,j,k)=1;
           end
           if((k==10 &&  radius < 410)||(k==40 &&  radius < 410))
               if(rem(i,2)==0 && rem(j,2)==0)
                    data(i,j,k)=1;
               end
           end
       end
    end
end