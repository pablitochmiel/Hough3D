close all;clc;clear;

data=makeDataSimple();

% cos=data==1;
% [x,y,z] = data;
% pcshow(data)
% X = 1:5;
% Y = 6:10;
% Z = 11:15;
% scatter3(X,Y,Z,'r*')
% xlim([0 5])
% ylim([0 10])
% zlim([0 16])
[X,Y,Z]=convertTo3Vec(data);
sz=size(data);
scatter3(X,Y,Z,'r.');
axis equal
xlim([0 sz(1)])
ylim([0 sz(2)])
zlim([0 sz(3)])
xlabel('x')
ylabel('y')
zlabel('z')

[H, Theta, Phi, Rho] = hough3Dplane(data);


function[h, theta, phi, rho] = hough3Dplane(BW)
fun=@(x,y,z,theta,phi) x.*cosd(theta).*cosd(phi) + y.*sind(theta).*cosd(phi) + z.*sind(phi);
theta=-90:89;
phi=-90:89;
sz=size(BW);
maxd=sqrt(sz(1)^2+sz(2)^2+sz(3)^2);
rho=-maxd:maxd;
h=zeros(size(theta,2),size(phi,2),size(rho,2));

for i = 1:sz(1)
    for j = 1:sz(2)
       for k = 1:sz(3)
           if(BW(i,j,k)==1)
               figure;
               [xx,yy]= meshgrid(theta,phi);
               zz=fun(i,j,k,xx,yy);
               mesh(xx,yy,zz)
               xlabel('\theta'), ylabel('\phi'),zlabel('/rho');
           end
       end
    end
end


end

