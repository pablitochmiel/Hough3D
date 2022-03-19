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
scatter3(X,Y,Z,'r*');
axis equal
xlim([0 50])
ylim([0 100])
zlim([0 50])