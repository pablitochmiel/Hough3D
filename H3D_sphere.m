close all;clc;clear;

data=makeDataReal();
scatter3D(data);
r=10:20;

caly=tic;
if numel(r)==1
    pojedynczy=tic;
    [H] = hough3Dsphere(data,r);
    toc(pojedynczy)
    mx=max(H(:));
    [X,Y,Z]=ind2sub(size(H),find(H==mx));
    disp('found '+string(size(X,1))+' sphares, score: '+string(mx));
    figure;
    hold on;
    scatter3D(data);
    for i = 1:size(X,1)
        disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' R: '+string(r));
        displayFoundCircle(X(i),Y(i),Z(i),r);
    end
    hold off;
else
    figure;
    hold on;
    scatter3D(data);
    for rr=r
        pojedynczy=tic;
        [H] = hough3Dsphere(data,rr);
        toc(pojedynczy)
        mx=max(H(:));
        [X,Y,Z]=ind2sub(size(H),find(H==mx));
        disp('found '+string(size(X,1))+' sphares, score: '+string(mx));
        for i = 1:size(X,1)
            disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' R: '+string(rr));
            displayFoundCircle(X(i),Y(i),Z(i),rr);
        end
    end
end
hold off;
toc(caly)


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
               scatter3(i,j,k,'blue.');
           end
       end
    end
end
end

