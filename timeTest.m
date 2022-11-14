close all; clear; clc;
%%
timePlane1=zeros(10,1);
timePlane2=zeros(10,1);
timeSfera1=zeros(10,1);
timeSfera2=zeros(10,1);
timeSfera3=zeros(10,1);
timeEl1=zeros(10,1);
timeEl2=zeros(10,1);
timeEl3=zeros(10,1);
%%
points=[500:500:5000];
bok=[120:20:300];
rr=[20:20:200];
%%
for i=1:10
    data=zeros(120,120,120);
    data=addNoise(data,points(i));

    aa=tic;
    [~]=hough3Dplane(data);
    timePlane1(i)=toc(aa);

    aa=tic;
    [~]=hough3Dsphere(data,40);
    timeSfera1(i)=toc(aa);

    aa=tic;
    [~]=hough3Dellipsoid(data,[4,4,4]);
    timeEl1(i)=toc(aa);
    i
end
%%

for j=1:10
    data=zeros(bok(j),120,120);
    data=addNoise(data,3000);

    aa=tic;
    [~]=hough3Dplane(data);
    timePlane2(j)=toc(aa);

    aa=tic;
    [~]=hough3Dsphere(data,40);
    timeSfera2(j)=toc(aa);

    aa=tic;
    [~]=hough3Dellipsoid(data,[4,4,4]);
    timeEl2(j)=toc(aa);
    j
end
%%
for k=1:10
    data=zeros(200,200,200);
    data=addNoise(data,4000);

    aa=tic;
    [~]=hough3Dsphere(data,rr(k)/5);
    timeSfera3(k)=toc(aa);

    bb=tic;
    [~]=hough3Dellipsoid(data,[rr(k)/5,rr(k)/5,rr(k)/5]);
    timeEl3(k)=toc(bb);
    k
end

%%

subplot(331), plot(points,timePlane1);title("Plane");xlabel("Amount of points"),ylabel("time")
subplot(332), plot(bok,timePlane2);title("Plane"),xlabel("Side size"),ylabel("time")

subplot(334), plot(points,timeSfera1);title("Sphere"),xlabel("Amount of points"),ylabel("time")
subplot(335), plot(bok,timeSfera2);title("Sphere"),xlabel("Side size"),ylabel("time")
subplot(336), plot(rr,timeSfera3);title("Sphere"),xlabel("Radius size"),ylabel("time")
subplot(337), plot(points,timeEl1);title("Ellipsoid"),xlabel("Amount of points"),ylabel("time")
subplot(338), plot(bok,timeEl2);title("Ellipsoid"),xlabel("Side size"),ylabel("time")
subplot(339), plot(rr,timeEl3);title("Ellipsoid"),xlabel("Radius size"),ylabel("time")
