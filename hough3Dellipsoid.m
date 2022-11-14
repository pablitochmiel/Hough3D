function[h,alpha,beta,gamma] = hough3Dellipsoid(BW, R)
alpha=0:45:179;
beta=0:45:179;
gamma=0:45:179;
sz=[size(BW,1),size(BW,2),size(BW,3)];
h=zeros(size(BW,1),size(BW,2),size(BW,3),size(alpha,2),size(beta,2),size(gamma,2),'uint16');
a2=R(1)*R(1);
b2=R(2)*R(2);
c2=R(3)*R(3);
[x,y,z] = ind2sub(size(BW),find(BW));

for j=1:size(alpha,2)
    %tic;
    for k=1:size(beta,2)
        for l=1:size(gamma,2)
            rx=[[1 0 0]
                [0 cosd(alpha(j)) -sind(alpha(j))]
                [0 sind(alpha(j)) cosd(alpha(j))]];
            ry=[[cosd(beta(k)) 0 sind(beta(k))]
                [0 1 0]
                [-sind(beta(k)) 0 cosd(beta(k))]];
            rz=[[cosd(gamma(l)) -sind(gamma(l)) 0]
                [sind(gamma(l)) cosd(gamma(l)) 0]
                [0 0 1]];
            rxyz=rx*ry*rz;
            for i = 1:size(x,1)
                for xx = -R(1):R(1)
                    for yy = -R(2):R(2)
                        offset2=c2*(1-xx^2/a2-yy^2/b2);
                        if(offset2 > 0)
                            offset = sqrt(offset2);
                            zz1 = -offset;
                            zz2 = offset;

                            point1=round(rxyz*[xx;yy;zz1]+[x(i);y(i);z(i)]);
                            point2=round(rxyz*[xx;yy;zz2]+[x(i);y(i);z(i)]);

                            if point1(1) < sz(1) && point1(1) >= 1 && point1(2) < sz(2) && point1(2) >= 1 && point1(3) < sz(3) && point1(3) >= 1
                                h(point1(1),point1(2),point1(3),j,k,l) = h(point1(1),point1(2),point1(3),j,k,l)+1;
                            end
                            if point2(1) < sz(1) && point2(1) >= 1 && point2(2) < sz(2) && point2(2) >= 1 && point2(3) < sz(3) && point2(3) >= 1
                                h(point2(1),point2(2),point2(3),j,k,l) = h(point2(1),point2(2),point2(3),j,k,l)+1;
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