close all;clc;clear;

data=makeDataTest();
%scatter3D(data);
r=[20,15,20];

if size(r,1)==1
    if size(r,2) ~= 3
        disp("ERROR r invalid size");
        return;
    end
    caly=tic;
    [H,Alpha,Beta,Gamma] = hough3Dellipsoid(data,r);
    toc(caly);
    
    mx=max(H(:));
    [B,I]=maxk(H(:),6);
    [X,Y,Z,alpha,beta,gamma]=ind2sub(size(H),I);
    disp('found '+string(size(X,1))+' sphares: '+string(mx));
    for i = 1:size(X,1)
        disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' A: '+string(r(1))+' B: '+string(r(2))+' C: '+string(r(3)) ...
            +' alpha: '+string(Alpha(alpha(i)))+' beta: '+string(Beta(beta(i)))+' gamma: '+string(Gamma(gamma(i))) ...
            +' score: '+string(H(X(i),Y(i),Z(i),alpha(i),beta(i),gamma(i))));
        figure;
        hold on;
        scatter3D(data);
        displayFoundEllipsoide(X(i),Y(i),Z(i),r,Alpha(alpha(i)),Beta(beta(i)),Gamma(gamma(i)));
        grid on;
        hold off;
    end
else
    if size(r,2) ~= 3
        disp("ERROR r invalid size");
        return;
    end
%     for rr=r
%         [H] = hough3Dsphere(data,rr);
%     
%         mx=max(H(:));
%         [X,Y,Z]=ind2sub(size(H),find(H==mx));
%         disp('found '+string(size(X,1))+' sphares, score: '+string(mx));
%         for i = 1:size(X,1)
%             disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' R: '+string(rr));
%         end
%     end
end


function[h,alpha,beta,gamma] = hough3Dellipsoid(BW, R)
alpha=0:45:179;
beta=0:45:179;
gamma=0:45:179;
sz=[size(BW,1),size(BW,2),size(BW,3)];
h=zeros(size(BW,1),size(BW,2),size(BW,3),size(alpha,2),size(beta,2),size(gamma,2),'uint16');
a2=R(1)*R(1);
b2=R(2)*R(2);
c2=R(3)*R(3);
[x,y,z] = ind2sub(size(BW),find(BW));

for j=1:size(alpha,2)
    tic;
    for k=1:size(beta,2)
        for l=1:size(gamma,2)
            rx=[[1 0 0]
                [0 cosd(alpha(j)) -sind(alpha(j))]
                [0 sind(alpha(j)) cosd(alpha(j))]];
            ry=[[cosd(beta(k)) 0 sind(beta(k))]
                [0 1 0]
                [-sind(beta(k)) 0 cosd(beta(k))]];
            rz=[[cosd(gamma(l)) -sind(gamma(l)) 0]
                [sind(gamma(l)) cosd(gamma(l)) 0]
                [0 0 1]];
            rxyz=rx*ry*rz;
            for i = 1:size(x,1)
                for xx = -R(1):R(1)
                    for yy = -R(2):R(2)
                        offset2=c2*(1-xx^2/a2-yy^2/b2);
                        if(offset2 > 0)
                            offset = sqrt(offset2);
                            zz1 = -offset;
                            zz2 = offset;

                            point1=round(rxyz*[xx;yy;zz1]+[x(i);y(i);z(i)]);
                            point2=round(rxyz*[xx;yy;zz2]+[x(i);y(i);z(i)]);

                            if point1(1) < sz(1) && point1(1) >= 1 && point1(2) < sz(2) && point1(2) >= 1 && point1(3) < sz(3) && point1(3) >= 1
                                h(point1(1),point1(2),point1(3),j,k,l) = h(point1(1),point1(2),point1(3),j,k,l)+1;
                            end
                            if point2(1) < sz(1) && point2(1) >= 1 && point2(2) < sz(2) && point2(2) >= 1 && point2(3) < sz(3) && point2(3) >= 1
                                h(point2(1),point2(2),point2(3),j,k,l) = h(point2(1),point2(2),point2(3),j,k,l)+1;
                            end
                        end
                    end
                end
            end
        end
    end
    toc;
end

end

function displayFoundEllipsoide(x,y,z,R,al,be,ga)

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

for a = -R(1)-1:R(1)+1
    for b = -R(2)-1:R(2)+1
       for c = -R(3)-1:R(3)+1
           sum=a*a/R(1)/R(1)+b*b/R(2)/R(2)+c*c/R(3)/R(3);
           if(sum>0.995 && sum < 1.005)
               point1=round(rxyz*[a;b;c]+[x;y;z]);
               scatter3(point1(1),point1(2),point1(3),100,'blue.');
               %data(a+x,b+y,c+z)=1;
           end
       end
    end
end

end

