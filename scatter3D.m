function [] = scatter3D(data,color)

if ~exist('color','var')
      color = "r.";
end

%figure;
[X,Y,Z]=ind2sub(size(data),find(data));
sz=size(data);
scatter3(X,Y,Z,100,color);
%scatter3(X,Y,Z,'Marker' ,'.','SizeData',100,'co',Y);
% xyz=zeros(size(X,1),3);
% xyz(:,1)=X(:);
% xyz(:,2)=Y(:);
% xyz(:,3)=Z(:);
% xyz = array2table(xyz);
% scatter3(xyz,'xyz1','xyz2','xyz3','filled','ColorVariable','xyz2','Marker' ,'.');
title('Points cloud');
axis equal
xlim([0 sz(1)])
ylim([0 sz(2)])
zlim([0 sz(3)])
xlabel('x')
ylabel('y')
zlabel('z')
end

