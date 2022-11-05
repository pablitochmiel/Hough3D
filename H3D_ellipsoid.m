close all;clc;clear;

data=makeDataTest();
scatter3D(data);
r=[25,20,15];

if size(r,1)==1
    if size(r,2) ~= 3
        disp("ERROR r invalid size");
        return;
    end
    tic;
    [H,Alpha,Beta,Gamma] = hough3Dellipsoid(data,r);
    toc;
    
    mx=max(H(:));
    [X,Y,Z,alpha,beta,gamma]=ind2sub(size(H),find(H==mx));
    disp('found '+string(size(X,1))+' sphares, score: '+string(mx));
    for i = 1:size(X,1)
        disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' A: '+string(r(1))+' B: '+string(r(2))+' C: '+string(r(3)) ...
            +' alpha: '+string(Alpha(alpha(i)))+' beta: '+string(Beta(beta(i)))+' gamma: '+string(Gamma(gamma(i))));
    end
else
    if size(r,2) ~= 3
        disp("ERROR r invalid size");
        return;
    end
%     for rr=r
%         [H] = hough3Dsphere(data,rr);
%     
%         mx=max(H(:));
%         [X,Y,Z]=ind2sub(size(H),find(H==mx));
%         disp('found '+string(size(X,1))+' sphares, score: '+string(mx));
%         for i = 1:size(X,1)
%             disp('X: '+string(X(i))+' Y: '+string(Y(i))+' Z: '+string(Z(i))+' R: '+string(rr));
%         end
%     end
end


function[h,alpha,beta,gamma] = hough3Dellipsoid(BW, R)
alpha=0:45:179;
beta=0:45:179;
gamma=0:45:179;
sz=[size(BW,1),size(BW,2),size(BW,3)];
h=zeros(size(BW,1),size(BW,2),size(BW,3),size(alpha,2),size(beta,2),size(gamma,2),'uint8');
a2=R(1)*R(1);
b2=R(2)*R(2);
c2=R(3)*R(3);
[x,y,z] = ind2sub(size(BW),find(BW));

for i = 1:size(x,1)
    %tic;
    for xx = -R(1):R(1)
        for yy = -R(2):R(2)
            offset2=c2*(1-xx^2/a2-yy^2/b2);
            if(offset2 > 0)
                offset = sqrt(offset2);
                zz1 = -offset;
                zz2 = offset;
                for al = alpha
                    for be = beta
                        for ga = gamma
                            rx=[[1 0 0]
                                [0 cosd(al) -sind(al)]
                                [0 sind(al) cosd(al)]];
                            ry=[[cosd(be) 0 sind(be)]
                                [0 1 0]
                                [-sind(be) 0 cosd(be)]];
                            rz=[[cosd(ga) -sind(ga) 0]
                                [sind(ga) cosd(ga) 0]
                                [0 0 1]];
                            rxyz=rx*ry*rz;

                            point1=round(rxyz*[xx;yy;zz1]+[x(i);y(i);z(i)]);
                            point2=round(rxyz*[xx;yy;zz2]+[x(i);y(i);z(i)]);

                            if point1(1) < sz(1) && point1(1) >= 1 && point1(2) < sz(2) && point1(2) >= 1 && point1(3) < sz(3) && point1(3) >= 1
                                h(point1(1),point1(2),point1(3)) = h(point1(1),point1(2),point1(3))+1;
                            end
                            if point2(1) < sz(1) && point2(1) >= 1 && point2(2) < sz(2) && point2(2) >= 1 && point2(3) < sz(3) && point2(3) >= 1
                                h(point2(1),point2(2),point2(3)) = h(point2(1),point2(2),point2(3))+1;
                            end
                        end
                    end
                end
            end
        end
    end
    %toc;
end

end

