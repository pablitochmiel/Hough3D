close all;clc;clear;

data=makeData1();
scatter3D(data);
tic
[H, Theta, Phi, Rho] = hough3Dplane(data);
toc

mx=max(H(:));
% [X1,Y1,Z1]=ind2sub(size(H),find(H==mx));
[B,I]=maxk(H(:),12);
[X1,Y1,Z1] = ind2sub(size(H),I);
% disp('found '+string(size(X1,1))+' planes');
% for i = 1:size(X1,1)
%     disp('Theta: '+string(Theta(X1(i)))+' Phi: '+string(Phi(Y1(i)))+' Rho: '+string(Rho(Z1(i)))+' score: '+string(H(X1(i),Y1(i),Z1(i))));
% end

for i = 1:size(X1,1)
    pros=0;
    row=0;
    planes=zeros(6,3);

    planes(1,1)=Theta(X1(i));
    planes(1,2)=Phi(Y1(i));
    planes(1,3)=Rho(Z1(i));

    for j = i+1:size(X1,1)
%         Theta(X1(i))
%         Phi(Y1(i))
%         Rho(Z1(i))
%         Theta(X1(j))
%         Phi(Y1(j))
%         Rho(Z1(j))

        if(Theta(X1(i))==Theta(X1(j)) && Phi(Y1(i)) == Phi(Y1(j)))
            row=row+1;
            planes(1+pros+row,1)=Theta(X1(j));
            planes(1+pros+row,2)=Phi(Y1(j));
            planes(1+pros+row,3)=Rho(Z1(j));
            continue;
        end
        if(abs(Theta(X1(i))-Theta(X1(j)))==90 || abs(Phi(Y1(i))-Phi(Y1(j)))==90 )
            pros=pros+1;
            planes(1+pros+row,1)=Theta(X1(j));
            planes(1+pros+row,2)=Phi(Y1(j));
            planes(1+pros+row,3)=Rho(Z1(j));
        end
    end
    if(pros>=4 && row >=1)
        wymiary=zeros(1,3);
        l=1;
        for j=1:6
            for k=j+1:6
                if(planes(j,1)==planes(k,1) && planes(j,2)==planes(k,2))
                    wymiary(l)=abs(planes(j,3)-planes(k,3));
                    l=l+1;
                end 
            end
        end
        disp("found a cuboid("+string(wymiary(1))+","+string(wymiary(2))+","+string(wymiary(3))+") with sides enclosed in planes:");
        for j=1:6
            disp('Theta: '+string(planes(j,1))+' Phi: '+string(planes(j,2))+' Rho: '+string(planes(j,3)));
        end
    end
end


