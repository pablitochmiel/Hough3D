close all;clc;clear;

data=makeDataTest();
% subplot(121);
% hold on;
% plot3([10,20,30,40,35,30,25,20,15,10],[6,6,6,6,17,28,39,28,17,6],[10,20,30,40,30,20,10,10,10,10], "m--.")
% plot3([20,35,30,20,15,20,20],[6,17,28,6,17,28,6],[20,30,20,20,10,10,20],"m--.")
% plot3([30,35,30,30,15,20,30],[6,17,28,6,17,28,6],[30,30,20,30,10,10,30],"m--.")
% plot3([35,15,20,35],[17,17,28,17],[30,10,10,30],"m--.")
% plot3([30,15,20,30],[28,17,28,28],[20,10,10,20],"m--.")
% scatter3D(data);
% grid on;
% hold off;
tic;
[H, Theta, Phi, Rho] = hough3Dplane(data);
toc

colors=[[0 1 0];[0,0,1];[0 1 1];[1 0 1];[1 1 0];
    [0 0.4470 0.7410];[0.8500 0.3250 0.0980];[0.9290 0.6940 0.1250];[0.4940 0.1840 0.5560];
    [0.4660 0.6740 0.1880];[0.3010 0.7450 0.9330];[0.6350 0.0780 0.1840]];

mx=max(H(:));
[B,I]=maxk(H(:),30);
[X1,Y1,Z1] = ind2sub(size(H),I);
disp('found '+string(size(X1,1))+' planes');
for i = 1:size(X1,1)
    disp(string(i)+') Theta: '+string(Theta(X1(i)))+' Phi: '+string(Phi(Y1(i)))+' Rho: '+string(Rho(Z1(i)))+' score: '+string(H(X1(i),Y1(i),Z1(i))));
    figure;
    hold on;
    scatter3D(data);
    displayFoundPlane(Theta(X1(i)),Phi(Y1(i)),Rho(Z1(i)),data,[0,0,1]);
    grid on;
    hold off;
end

% grid on;
% hold off;

function displayFoundPlane(theta,phi,rho,data,color)
    fun=@(x,y,z,theta,phi) round(x.*cosd(theta).*cosd(phi) + y.*sind(theta).*cosd(phi) + z.*sind(phi));
    [x,y,z] = ind2sub(size(data),find(data));
    for i = 1:size(x,1)
        if( fun(x(i),y(i),z(i),theta,phi)==round(rho))
            scatter3(x(i),y(i),z(i),100,color,".");
        end
    end
end