close all;clc;clear;

data=makeData1();
max=sum(sum(sum(data==1)));
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
scatter3(X,Y,Z,'r*');
axis equal
xlim([0 sz(1)])
ylim([0 sz(2)])
zlim([0 sz(3)])