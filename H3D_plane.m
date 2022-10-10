close all;clc;clear;

data=makeData1();
scatter3D(data);
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


