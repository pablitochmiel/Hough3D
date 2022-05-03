function [data] = makeData2()
data=zeros(100,100,50);

for i=10:40 %r=15 x=25 y=25
    for j=10:40
        a=i-25;
        b=j-25;
        radius=a*a+b*b;
        if(radius>223 && radius < 227)
            data(i,j,25)=1;
            %data(j,i,25)=1;
            data(i,25,j)=1;
            %data(j,25,i)=1;
            data(25,i,j)=1;
            %data(25,j,i)=1;
        end
    end
end

for i = 15:35 %r=10 x=25 y=75
    for j = 65:85
       for k = 15:35
           a=i-25;
           b=j-75;
           c=k-25;
           radius=a*a+b*b+c*c;
           if(radius>98 && radius < 102)
               data(i,j,k)=1;
           end
       end
    end
end

for i=55:95 %r=20 x=75 y=25
    for j=5:45
        a=i-75;
        b=j-25;
        radius=a*a+b*b;
        if(radius>398 && radius < 402)
            data(i,j,25)=1;
            %data(j,i,25)=1;
            data(i,25,j)=1;
            %data(j,25,i)=1;
            data(75,i-50,j)=1;
            %data(25,j,i)=1;
        end
    end
end

for i = 50:100 %r=25 x=75 y=75
    for j = 50:100
       for k = 1:50
           a=i-75;
           b=j-75;
           c=k-25;
           radius=a*a+b*b+c*c;
           if(radius>623 && radius < 627)
               data(i,j,k)=1;
           end
       end
    end
end

