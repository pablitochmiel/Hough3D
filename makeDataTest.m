function [data] = makeDataTest()

data=zeros(150,150,100,"uint8");
% %cuboid (30,30,30) x=25 y=75
% data(10:40,60,10)=1;
% data(10:40,60,40)=1;
% data(10:40,90,10)=1;
% data(10:40,90,40)=1;
% data(10,60:90,10)=1;
% data(10,60:90,40)=1;
% data(40,60:90,10)=1;
% data(40,60:90,40)=1;
% data(40,60,10:40)=1;
% data(10,60,10:40)=1;
% data(40,90,10:40)=1;
% data(10,90,10:40)=1;
% 
% %cuboid x=75 y=125
% ala=[65:2:95,95:-1:85,85:-2:55,55:65];
% kot=[110:125,125:2:145,145:-1:130,130:-2:110];
% for i = 1:size(ala,2)
%     data(ala(i),kot(i),10)=1;
%     data(ala(i),kot(i),50)=1;
% end
% for i=10:50
%     data(55,130,i)=1;
%     data(65,110,i)=1;
%     data(95,125,i)=1;
%     data(85,145,i)=1;
% end
% 
% for i=10:40 %r=15 x=25 y=25
%     for j=10:40
%         a=i-25;
%         b=j-25;
%         radius=a*a+b*b;
%         if(radius>223 && radius < 227)
%             data(i,j,25)=1;
%             %data(j,i,25)=1;
%             data(i,25,j)=1;
%             %data(j,25,i)=1;
%             data(25,i,j)=1;
%             %data(25,j,i)=1;
%         end
%     end
% end
% 
% for i = 15:35 %r=10 x=25 y=75 z=75
%     for j = 65:85
%        for k = 65:85
%            a=i-25;
%            b=j-75;
%            c=k-75;
%            radius=a*a+b*b+c*c;
%            if(radius>98 && radius < 102)
%                data(i,j,k)=1;
%            end
%        end
%     end
% end
% 
% for i=55:95 %r=20 x=75 y=25
%     for j=5:45
%         a=i-75;
%         b=j-25;
%         radius=a*a+b*b;
%         if(radius>398 && radius < 402)
%             data(i,j,25)=1;
%             %data(j,i,25)=1;
%             data(i,25,j)=1;
%             %data(j,25,i)=1;
%             data(75,i-50,j)=1;
%             %data(25,j,i)=1;
%         end
%     end
% end
% 
% for i = 50:100 %r=25 x=75 y=75
%     for j = 50:100
%        for k = 1:50
%            a=i-75;
%            b=j-75;
%            c=k-25;
%            radius=a*a+b*b+c*c;
%            if(radius>623 && radius < 627)
%                data(i,j,k)=1;
%            end
%        end
%     end
% end
% 
% r1=10;
% r2=15;
% r3=12;
% 
% for i = 101:150 
%     for j = 101:150
%        for k = 51:100
%            a=i-125;
%            b=j-125;
%            c=k-75;
%            sum=a*a/r1/r1+b*b/r2/r2+c*c/r3/r3;
%            if(sum>0.985 && sum < 1.015)
%                data(i,j,k)=1;
%            end
%        end
%     end
% end
% 
% for i = 60:90 %r=13 x=75 y=125 z=75
%     for j = 110:140
%        for k = 60:90
%            a=i-75;
%            b=j-125;
%            c=k-75;
%            radius=a*a+b*b+c*c;
%            if(radius>167 && radius < 171)
%                data(i,j,k)=1;
%            end
%        end
%     end
% end
% 
% for i = 105:145 %r=17 x=125 y=75 
%     for j = 55:95
%        for k = 55:95
%            a=i-25;
%            b=j-75;
%            c=k-125;
%            radius=a*a+b*b+c*c;
%            if(radius>98 && radius < 102)
%                data(i,j,k)=1;
%            end
%        end
%     end
% end
% 
% for i = 1:50 %r=22 x=25 y=125 
%     for j = 100:150
%        for k = 1:50
%            a=i-25;
%            b=j-125;
%            c=k-25;
%            radius=a*a+b*b+c*c;
%            if(radius>482 && radius < 486)
%                data(i,j,k)=1;
%            end
%        end
%     end
% end
% 
% fun=@(x,y,z,theta,phi) round(x.*cosd(theta).*cosd(phi) + y.*sind(theta).*cosd(phi) + z.*sind(phi),1); 
% 
% for i = 100:150 
%     for j = 1:50
%         for k = 1:50
%             if(fun(i,j,k,70,-10)==52.5)
%                 data(i,j,k)=1;
%             end
%         end
%     end
% end
% 
% for i = 1:50
%     for j = 100:150
%         for k = 20:100
%             if(fun(i,j,k,138,24)==103)
%                 data(i,j,k)=1;
%             end
%         end
%     end
% end

x=125;
y=75;
z=25;
R=[25,20,15];
alpha=0;
beta=0;
gamma=45;
sz=[size(data,1),size(data,2),size(data,3)];
a2=R(1)*R(1);
b2=R(2)*R(2);
c2=R(3)*R(3);

for i = 1:size(x,1)
    %tic;
    for xx = -R(1):R(1)
        for yy = -R(2):R(2)
            offset2=c2*(1-xx^2/a2-yy^2/b2);
            if(offset2 > 0)
                offset = sqrt(offset2);
                zz1 = -offset;
                zz2 = offset;
                for al = alpha
                    for be = beta
                        for ga = gamma
                            rx=[[1 0 0]
                                [0 cosd(al) -sind(al)]
                                [0 sind(al) cosd(al)]];
                            ry=[[cosd(be) 0 sind(be)]
                                [0 1 0]
                                [-sind(be) 0 cosd(be)]];
                            rz=[[cosd(ga) -sind(ga) 0]
                                [sind(ga) cosd(ga) 0]
                                [0 0 1]];
                            rxyz=rx*ry*rz;
                            
                            point1=[-1,-1,-1];
                            point2=[-1,-1,-1];

                            temp=rxyz*[xx;yy;zz1]+[x(i);y(i);z(i)];
                            rtemp=round(temp);
                            if(all(abs(rtemp-temp)<0.25))
                                point1=rtemp;
                            end
                            temp=rxyz*[xx;yy;zz2]+[x(i);y(i);z(i)];
                            rtemp=round(temp);
                            if(all(abs(rtemp-temp)<0.25))
                                point2=rtemp;
                            end
                            
%                             point1=round(rxyz*[xx;yy;zz1]+[x(i);y(i);z(i)]);
%                             point2=round(rxyz*[xx;yy;zz2]+[x(i);y(i);z(i)]);

                            if point1(1) < sz(1) && point1(1) >= 1 && point1(2) < sz(2) && point1(2) >= 1 && point1(3) < sz(3) && point1(3) >= 1
                                data(point1(1),point1(2),point1(3)) = 1;
                            end
                            if point2(1) < sz(1) && point2(1) >= 1 && point2(2) < sz(2) && point2(2) >= 1 && point2(3) < sz(3) && point2(3) >= 1
                                data(point2(1),point2(2),point2(3)) = 1;
                            end
                        end
                    end
                end
            end
        end
    end
    %toc;
end

% r1=20;
% r2=15;
% r3=20;
% 
% for i = 101:150 
%     for j = 101:150
%        for k = 1:50
%            a=i-125;
%            b=j-125;
%            c=k-25;
%            sum=a*a/r1/r1+b*b/r2/r2;
%            if(sum>0.985 && sum < 1.015)
%                data(i,j,25)=1;
%            end
%            sum=a*a/r1/r1+c*c/r3/r3;
%            if(sum>0.985 && sum < 1.015)
%                data(i,125,k)=1;
%            end
%            sum=b*b/r2/r2+c*c/r3/r3;
%            if(sum>0.985 && sum < 1.015)
%                data(125,j,k)=1;
%            end
%        end
%     end
% end



end