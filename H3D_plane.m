close all;clc;clear;

%data=makeDataSimple();
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

mx=max(max(max(H)));% find the max score location
%[aatheta, aaphi, aarho]=find(H==mx);
%fileID = fopen('plik.txt','w');
%petla
sz3=size(H);
for i=1:sz3(1)
    for j=1:sz3(2)-1
        for k=1:sz3(3)
            if H(i,j,k) == mx
                %fprintf( fileID, '%d %d %d\r\n', Theta(i), Phi(j), Rho(k));
                disp(string(Theta(i))+' '+string(Phi(j))+' '+string(Rho(k)));
            end
        end
    end
end
for k=1:sz3(3)
    if H(1,sz3(2),k) == mx
        %fprintf( fileID, '%d %d %d\r\n', Theta(1), Phi(sz3(2)), Rho(k));
        disp(string(Theta(1))+' '+string(Phi(sz3(2)))+' '+string(Rho(k)));
    end
end

%fclose(fileID);
% for i=1:sz3(3)
%     rescale(H(:,:,i));
% end
%figure;
% implay(H);

function[h, theta, phi, rho] = hough3Dplane(BW)
fun=@(x,y,z,theta,phi) round(x.*cosd(theta).*cosd(phi) + y.*sind(theta).*cosd(phi) + z.*sind(phi),1); 
% theta=0:179;
% phi=-90:89;
theta=0:90;
phi=0:90;
sz=size(BW);
maxd=round(sqrt(sz(1)^2+sz(2)^2+sz(3)^2))+1;
%rho=-maxd:0.1:maxd;
rho=0:0.1:maxd;
h=zeros(size(theta,2),size(phi,2),size(rho,2));

for i = 1:sz(1)
    for j = 1:sz(2)
       for k = 1:sz(3)
           if(BW(i,j,k)==1)
%              figure;
               [yy,xx]= meshgrid(theta,phi);
               zz=fun(i,j,k,yy,xx);
%                mesh(yy,xx,zz)
%                xlabel('\theta'), ylabel('\phi'),zlabel('\rho');
               sz2=size(zz);
               for l=1:sz2(2)
                   for m=1:sz2(1)
                       h(l,m,rho==zz(m,l))=h(l,m,rho==zz(m,l))+1;
                   end
               end
           end
       end
    end
end

end

