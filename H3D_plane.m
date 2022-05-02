close all;clc;clear;

data=makeData1();
scatter3D(data);
tic
[H, Theta, Phi, Rho] = hough3Dplane(data);
toc

mx=max(H(:));
[X1,Y1,Z1]=ind2sub(size(H(:,1:end-1,:)),find(H(:,1:end-1,:)==mx));
[X2,Y2,Z2]=ind2sub(size(H(1,end,:)),find(H(1,end,:)==mx));
disp('found '+string(size(X1,1)+size(X2,1))+' planes, score: '+string(mx));
for i = 1:size(X1,1)
    disp('Theta: '+string(Theta(X1(i)))+' Phi: '+string(Phi(Y1(i)))+' Rho: '+string(Rho(Z1(i))));
end
for i = 1:size(X2,1)
    disp('Theta: '+string(Theta(1))+' Phi: '+string(Phi(end))+' Rho: '+string(Rho(Z2(i))));
end


function[h, theta, phi, rho] = hough3Dplane(BW)
fun=@(x,y,z,theta,phi) round(x.*cosd(theta).*cosd(phi) + y.*sind(theta).*cosd(phi) + z.*sind(phi),1); 
theta=0:179;
phi=-89:90;
[yy,xx]= meshgrid(theta,phi);
sz=size(BW);
maxd=round(sqrt(sz(1)^2+sz(2)^2+sz(3)^2))+1;
rho=-maxd:0.1:maxd;
h=zeros(size(theta,2),size(phi,2),size(rho,2));

[x,y,z] = ind2sub(size(BW),find(BW));
for i = 1:size(x,1)
    %figure;
    zz=fun(x(i),y(i),z(i),yy,xx);
    %mesh(yy,xx,zz)
    %xlabel('\theta'), ylabel('\phi'),zlabel('\rho');
    sz2=size(zz);
    for l=1:sz2(2)
      for m=1:sz2(1)
           h(l,m,rho==zz(m,l))=h(l,m,rho==zz(m,l))+1;
       end
    end
end

end

