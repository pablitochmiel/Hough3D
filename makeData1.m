function [data] = makeData1()
data=zeros(100,100,65);

for i = 1:50
    for j = 1:50
       for k = 1:50
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

% data(65:85,28,12)=1;
% data(65:85,8,32)=1;
% for i = 0:20
%     data(65,28-i,12+i)=1;
%     data(85,28-i,12+i)=1;
% end
% for i = 0:30
%     data(65,8+i,32+i)=1;
%     data(65,28+i,12+i)=1;
%     data(85,8+i,32+i)=1;
%     data(85,28+i,12+i)=1;
% end
% data(65:85,38,62)=1;
% data(65:85,58,42)=1;
% for i = 0:20
%     data(65,58-i,42+i)=1;
%     data(85,58-i,42+i)=1;
% end
