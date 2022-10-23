close all;clc;clear;
% RGB = imread('gantrycrane.png');
% I  = im2gray(RGB);
% BW = edge(I,'canny');
% [H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
BW=zeros(50,50,'uint8');
% BW(10:40,10)=1;
% BW(10:40,40)=1;
% BW(10,10:40)=1;
% BW(40,10:40)=1;
BW(10,10)=1;
BW(40,40)=1;
% BW(10,40)=1;
% BW(40,10)=1;

[H,T,R] = hough(BW);
subplot(1,2,1);
image=255*ones(50,50,3,'uint8');
image(:,:,2:3)=image(:,:,2:3)-BW*255;
for i= 11:39
    image(i,i,:)=[0,255,255];
end
imshow(image);
title('Picture');
xlabel('x'), ylabel('y');
axis on%, axis equal
hold on;
mx=max(max(H));% find the max score location
[y,x]=find(H==mx);
subplot(1,2,2);
% imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
%       'InitialMagnification','fit');
% imshow(imadjust(rescale(H)));
% title('Hough space');
% xlabel('\theta'), ylabel('\rho');
% axis on%, axis equal, %hold on;
%colormap(gca,hot);

% hspace=ones(140,180,3,'uint8')*255;
% for i=0:179
%     y1=round(10*cosd(i)+10*sind(i));
%     y2=round(40*cosd(i)+40*sind(i));
%     hspace(70+y1,i+1,:)=[0,255,0];
%     hspace(70+y2,i+1,:)=[0,0,255];
% end
% 
% for i=69:71
%     for j=134:136
%         hspace(i,j,:)=[255,0,0];
%     end
% end
theta=-89:90;
y1=10.*cosd(theta)+10.*sind(theta);
y2=40.*cosd(theta)+40.*sind(theta);

plot(theta,y1,'g',theta,y2,'b',-45,0,'r.',"MarkerSize",15)
title('Hough space');
xlabel('\theta'), ylabel('\rho');
axis on, axis square
xlim([-90 90])
ylim([-70 70])
