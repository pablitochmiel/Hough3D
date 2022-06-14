function [] = scatter3D(data,color)

if ~exist('color','var')
      color = "r.";
end

figure;
[X,Y,Z]=ind2sub(size(data),find(data));
sz=size(data);
scatter3(X,Y,Z,color);
axis equal
xlim([0 sz(1)])
ylim([0 sz(2)])
zlim([0 sz(3)])
xlabel('x')
ylabel('y')
zlabel('z')
end

