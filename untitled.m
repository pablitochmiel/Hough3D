%close all;clc;clear;
data22=makeDataTest();
figure;
hold on;
scatter3D(data22);
grid on;
%displayFoundPlane(90,45,70.7,data22,[0,0,1])
hold off

function displayFoundPlane(theta,phi,rho,data,color)
    fun=@(x,y,z,theta,phi) round(x.*cosd(theta).*cosd(phi) + y.*sind(theta).*cosd(phi) + z.*sind(phi),1);
    [x,y,z] = ind2sub(size(data),find(data));
    for i = 1:size(x,1)
        if( abs(fun(x(i),y(i),z(i),theta,phi)-rho)<1)
            scatter3(x(i),y(i),z(i),100,color,".");
        end
    end
end