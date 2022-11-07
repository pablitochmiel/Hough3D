function[h, theta, phi, rho] = hough3Dplane(BW)
fun=@(x,y,z,theta,phi) round(x.*cosd(theta).*cosd(phi) + y.*sind(theta).*cosd(phi) + z.*sind(phi),1); 
theta=0:179;
phi=-89:90;
[yy,xx]= meshgrid(theta,phi);
sz=size(BW);
maxd=round(sqrt(sz(1)^2+sz(2)^2+sz(3)^2))+1;
rho=-maxd:0.1:maxd;
findIndex=@(value) (value+maxd)*10+1;
h=zeros(size(theta,2),size(phi,2),size(rho,2),'uint16');
%colors=["blue","green","yellow"];
[x,y,z] = ind2sub(size(BW),find(BW));
% subplot(122)
% scatter3(155,43,2,1500,'red.');
for i = 1:size(x,1)
    %figure;
    zz=fun(x(i),y(i),z(i),yy,xx);
%     hold on;
%     mesh(yy,xx,zz,"EdgeColor",colors(i))
%     xlabel('\theta'), ylabel('\phi'),zlabel('\rho');
    sz2=size(zz);
    for l=1:sz2(2)
      for m=1:sz2(1)
           index=findIndex(zz(m,l));
           index1=round(index);
%            if(index1~=index)
%                disp(string(index)+" "+string(index1));
%                index;
%            end
           h(l,m,index1)=h(l,m,index1)+1;
       end
    end
end
%scatter3(155,43,2,1500,'red.');
%plot3(155,43,2,'redo',"MarkerSize",70);
%title('Hough space');
h(2:end,end,:)=0;

end