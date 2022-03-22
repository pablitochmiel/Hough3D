close all;clc;clear;
% RGB = imread('gantrycrane.png');
% I  = im2gray(RGB);
% BW = edge(I,'canny');
% [H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
BW=zeros(50,50);
BW(10:40,10)=1;
BW(10:40,40)=1;
BW(10,10:40)=1;
BW(40,10:40)=1;

[H,T,R] = hough(BW);
subplot(2,1,1);
imshow(BW);
title('gantrycrane.png');
hold on;
mx=max(max(H));% find the max score location
[y,x]=find(H==mx);
subplot(2,1,2);
% imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
%       'InitialMagnification','fit');
imshow(imadjust(rescale(H)));
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);