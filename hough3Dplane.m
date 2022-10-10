function[h, theta, phi, rho] = hough3Dplane(BW)
fun=@(x,y,z,theta,phi) round(x.*cosd(theta).*cosd(phi) + y.*sind(theta).*cosd(phi) + z.*sind(phi),1); 
theta=0:179;
phi=-89:90;
[yy,xx]= meshgrid(theta,phi);
sz=size(BW);
maxd=round(sqrt(sz(1)^2+sz(2)^2+sz(3)^2))+1;
rho=-maxd:0.1:maxd;
findIndex=@(value) (value+maxd)*10+1;
h=zeros(size(theta,2),size(phi,2),size(rho,2),'uint8');

[x,y,z] = ind2sub(size(BW),find(BW));
for i = 1:size(x,1)
    %figure;
    zz=fun(x(i),y(i),z(i),yy,xx);
    %mesh(yy,xx,zz)
    %xlabel('\theta'), ylabel('\phi'),zlabel('\rho');
    sz2=size(zz);
    for l=1:sz2(2)
      for m=1:sz2(1)
           index=findIndex(zz(m,l));
           h(l,m,index)=h(l,m,index)+1;
       end
    end
end

h(2:end,end,:)=0;

end