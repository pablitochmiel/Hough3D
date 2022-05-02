close all;clc;clear;

data=makeData1();
r=10;

[X,Y,Z] = ind2sub(size(data),find(data));

sz=size(data);
scatter3(X,Y,Z,'r.');
axis equal
xlim([0 sz(1)])
ylim([0 sz(2)])
zlim([0 sz(3)])
xlabel('x')
ylabel('y')
zlabel('z')

[H] = hough3Dsphere(data,r);

mx=max(max(max(H)));% find the max score location 

disp('score: '+string(mx));
sz3=size(H);
for i=1:sz3(1)
    for j=1:sz3(2)
        for k=1:sz3(3)
            if H(i,j,k) == mx
                disp('X: '+string(i)+' Y: '+string(j)+' Z: '+string(k)+' R: '+string(r));
            end
        end
    end
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

