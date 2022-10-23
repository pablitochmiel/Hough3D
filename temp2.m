close all;clc;clear;

image=255*ones(100,100,3,'uint8');
hspace=255*ones(100,100,3,'uint8');
kropka=zeros(3,3,3,"uint8");
kropka(:,:,1)=255;

for i=1:100
    for j=1:100
        a=i-50;
        b=j-50;
        radius=a*a+b*b;
        if(radius>385 && radius < 415)
            image(i,j,:)=[0,0,255];
        end
    end
end

image(29:31,49:51,:)=kropka;
image(69:71,49:51,:)=kropka;
image(49:51,29:31,:)=kropka;
image(49:51,69:71,:)=kropka;

for i=1:100
    for j=1:100
        a=i-30;
        b=j-50;
        radius=a*a+b*b;
        if(radius>385 && radius < 415)
            hspace(i,j,:)=[0,255,0];
        end
        a=i-70;
        b=j-50;
        radius=a*a+b*b;
        if(radius>385 && radius < 415)
            hspace(i,j,:)=[0,255,0];
        end
        a=i-50;
        b=j-30;
        radius=a*a+b*b;
        if(radius>385 && radius < 415)
            hspace(i,j,:)=[0,255,0];
        end
        a=i-50;
        b=j-70;
        radius=a*a+b*b;
        if(radius>385 && radius < 415)
            hspace(i,j,:)=[0,255,0];
        end
    end
end

hspace(49:51,49:51,:)=kropka;

subplot(1,2,1);
imshow(image);
title('Picture');
xlabel('x'), ylabel('y');
axis on
subplot(1,2,2);
imshow(hspace);
title('Hough space');
xlabel('x'), ylabel('y');
axis on

figure;
image=zeros(100,100,100,'uint8');
hspace=zeros(100,100,100,'uint8');

for i=1:100
    for j=1:100
        for k=1:100
            a=i-50;
            b=j-50;
            c=k-50;
            radius=a*a+b*b+c*c;
            if(radius>398 && radius < 402)
                image(i,j,k)=1;
            end
        end
    end
end


subplot(1,2,1);
hold on;
scatter3D(image,'g.');
plot3([30,70,50,50,50,50],[50,50,30,70,50,50],[50,50,50,50,30,70],'r.',"MarkerSize",20);
grid on;
hold off;


% image(29:31,49:51,:)=kropka;
% image(69:71,49:51,:)=kropka;
% image(49:51,29:31,:)=kropka;
% image(49:51,69:71,:)=kropka;

for i=1:100
    for j=1:100
        for k = 1:100
            a=i-30;
            b=j-50;
            c=k-50;
            radius=a*a+b*b+c*c;
            if(radius>398 && radius < 402)
                hspace(i,j,k)=1;
            end
            a=i-70;
            b=j-50;
            c=k-50;
            radius=a*a+b*b+c*c;
            if(radius>398 && radius < 402)
                hspace(i,j,k)=1;
            end
        end
    end
end

subplot(1,2,2);
hold on;
scatter3D(hspace,'g.');
hspace(:,:,:)=0;

for i=1:100
    for j=1:100
        for k = 1:100
            a=i-50;
            b=j-30;
            c=k-50;
            radius=a*a+b*b+c*c;
            if(radius>398 && radius < 402)
                hspace(i,j,k)=1;
            end
            a=i-50;
            b=j-70;
            c=k-50;
            radius=a*a+b*b+c*c;
            if(radius>398 && radius < 402)
                hspace(i,j,k)=1;
            end
        end
    end
end

scatter3D(hspace,'b.');
hspace(:,:,:)=0;

for i=1:100
    for j=1:100
        for k = 1:100
            a=i-50;
            b=j-50;
            c=k-30;
            radius=a*a+b*b+c*c;
            if(radius>398 && radius < 402)
                hspace(i,j,k)=1;
            end
            a=i-50;
            b=j-50;
            c=k-70;
            radius=a*a+b*b+c*c;
            if(radius>398 && radius < 402)
                hspace(i,j,k)=1;
            end
        end
    end
end

scatter3D(hspace,'y.');
title('Hough space');
plot3(50,50,50,'r.',"MarkerSize",40);
grid on;
hold off;






