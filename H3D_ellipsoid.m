close all;clc;clear;

data=makeDataTest();
data=addNoise(data,2000);
%scatter3D(data);
r=[20,15,20];
%r=[25,20,15];
%r=[10,15,12];

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
    disp('found '+string(size(X,1))+' sphares: ');
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

function displayFoundEllipsoide(x,y,z,R,al,be,ga)

xx=zeros(1000,1,"uint16");
yy=zeros(1000,1,"uint16");
zz=zeros(1000,1,"uint16");
idx=1;

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
               xx(idx)=point1(1);
               yy(idx)=point1(2);
               zz(idx)=point1(3);
               idx=idx+1;
           end
       end
    end
end

scatter3(xx,yy,zz,100,"blue.");
scatter3(0,0,0,100,"white.");

end

