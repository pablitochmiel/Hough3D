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


