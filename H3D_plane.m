close all;clc;clear;

data=makeData1();

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
theta=-90:89;
phi=-90:89;
sz=size(BW);
maxd=sqrt(sz(1)^2+sz(2)^2+sz(3)^2);
rho=-maxd:maxd;
h=zeros(size(theta,2),size(phi,2),size(rho,2));



end

