close all;clc;clear;

data=makeDataTest();
%data=addNoise(data,2000);
scatter3D(data);
r=[10,13,15,20,22,25];

caly=tic;
if numel(r)==1
    pojedynczy=tic;
    [H] = hough3Dsphere(data,r);
    toc(pojedynczy)
    mx=max(H(:));
    [B,I]=maxk(H(:),6);
    [X,Y,Z]= ind2sub(size(H),I);
    disp('found '+string(size(X,1))+' sphares: ');
    for i = 1:size(X,1)
        disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' R: '+string(r)+' score: '+string(H(X(i),Y(i),Z(i))));
        figure;
        hold on;
        scatter3D(data);
        displayFoundCircle(X(i),Y(i),Z(i),r);
        grid on;
        hold off;
    end
else
    for rr=r
        pojedynczy=tic;
        [H] = hough3Dsphere(data,rr);
        toc(pojedynczy)
        mx=max(H(:));
        [B,I]=maxk(H(:),6);
        [X,Y,Z]= ind2sub(size(H),I);
        %disp('found '+string(size(X,1))+' sphares: ');
        for i = 1:size(X,1)
            disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' R: '+string(rr)+' score: '+string(H(X(i),Y(i),Z(i))));
%             figure;
%             hold on;
%             scatter3D(data);
%             displayFoundCircle(X(i),Y(i),Z(i),rr);
%             grid on;
%             hold off;
        end
    end
end
%toc(caly)

function displayFoundCircle(x,y,z,r)
    xx=zeros(1000,1,"uint16");
    yy=zeros(1000,1,"uint16");
    zz=zeros(1000,1,"uint16");
    idx=1;

    rr1=r*r-2;
    rr2=r*r+2;
    for i = x-r-1:x+r+1
        for j = y-r-1:y+r+1
           for k = z-r-1:z+r+1
               a=i-x;
               b=j-y;
               c=k-z;
               radius=a*a+b*b+c*c;
               if(radius>rr1 && radius < rr2)
                   xx(idx)=i;
                   yy(idx)=j;
                   zz(idx)=k;
                   idx=idx+1;
               end
           end
        end
    end

    scatter3(xx,yy,zz,100,"blue.");
    scatter3(0,0,0,100,"white.");

end

