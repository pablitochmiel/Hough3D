close all;clc;clear;

data=makeDataTest();
% subplot(121);
% hold on;
% plot3([10,20,30,40,35,30,25,20,15,10],[6,6,6,6,17,28,39,28,17,6],[10,20,30,40,30,20,10,10,10,10], "m--.")
% plot3([20,35,30,20,15,20,20],[6,17,28,6,17,28,6],[20,30,20,20,10,10,20],"m--.")
% plot3([30,35,30,30,15,20,30],[6,17,28,6,17,28,6],[30,30,20,30,10,10,30],"m--.")
% plot3([35,15,20,35],[17,17,28,17],[30,10,10,30],"m--.")
% plot3([30,15,20,30],[28,17,28,28],[20,10,10,20],"m--.")
scatter3D(data);
% grid on;
% hold off;
tic
[H, Theta, Phi, Rho] = hough3Dplane(data);
toc

mx=max(H(:));
[B,I]=maxk(H(:),12);
[X1,Y1,Z1] = ind2sub(size(H),I);
disp('found '+string(size(X1,1))+' planes');
for i = 1:size(X1,1)
    disp('Theta: '+string(Theta(X1(i)))+' Phi: '+string(Phi(Y1(i)))+' Rho: '+string(Rho(Z1(i)))+' score: '+string(H(X1(i),Y1(i),Z1(i))));
end


