function [data] = makeDataSimple()
data=zeros(50,50,50);

data(10,6,10)=1;
data(40,6,40)=1;
data(25,39,10)=1;

% data(25,6,25)=1;
% data(40,6,25)=1;
% data(25,39,25)=1;
