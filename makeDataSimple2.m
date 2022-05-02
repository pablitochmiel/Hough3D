function [data] = makeDataSimple2()
data=zeros(50,50,50);

% data(10,10,25)=1;
% data(50,10,25)=1;
% data(10,40,25)=1;

data(10,25,25)=1;
data(25,10,25)=1;
data(25,40,25)=1;
data(40,25,25)=1;
data(25,25,10)=1;
data(25,25,40)=1;