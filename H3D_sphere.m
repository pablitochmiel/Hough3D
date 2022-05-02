close all;clc;clear;

data=makeDataSimple2();
scatter3D(data);
r=15;

[H] = hough3Dsphere(data,r);

mx=max(H(:));
[X,Y,Z]=ind2sub(size(H),find(H==mx));
disp('found '+string(size(X,1))+' sphares, score: '+string(mx));
for i = 1:size(X,1)
    disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' R: '+string(r));
end

function[h] = hough3Dsphere(BW, R)
sz=[size(BW,1),size(BW,2),size(BW,3)];
h=zeros(sz);
r2=R*R;
[x,y,z] = ind2sub(size(BW),find(BW));

for i = 1:size(x,1)
    xMin=x(i)-R*10;
    xMax=x(i)+R*10;
    yMin=y(i)-R*10;
    yMax=y(i)+R*10;
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

