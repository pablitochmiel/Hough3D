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
        %toc(pojedynczy)
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


function[h] = hough3Dsphere(BW, R)
sz=[size(BW,1),size(BW,2),size(BW,3)];

h=zeros(sz,'uint8');
r2=R*R;
[x,y,z] = ind2sub(size(BW),find(BW));

for i = 1:size(x,1)
    xMin=x(i)-R;
    xMax=x(i)+R;
    yMin=y(i)-R;
    yMax=y(i)+R;
    if (xMin<1) 
        xMin=1; 
    end
    if (yMin<1) 
        yMin=1; 
    end
    if (xMax>sz(1))
        xMax=sz(1); 
    end
    if (yMax>sz(2))
        yMax=sz(2); 
    end
    for xx = xMin:xMax
        for yy = yMin:yMax
            offset2=r2-(x(i)-xx)^2-(y(i)-yy)^2;
            if(offset2 > 0)
                offset = sqrt(offset2);
                zz1 = round(z(i)-offset);
                zz2 = round(z(i)+offset); 
                if zz1 < sz(3) && zz1 >= 1
                    h(xx,yy,zz1) = h(xx,yy,zz1)+1;
                end
                if zz2 < sz(3) && zz2 >= 1
                    h(xx,yy,zz2) = h(xx,yy,zz2)+1;
                end
            end
        end
    end
end

end

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

