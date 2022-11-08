function [data] = addNoise(data,n)
    sz=size(data);
    x = randi([1 sz(1)],1,n);
    y = randi([1 sz(2)],1,n);
    z = randi([1 sz(3)],1,n);
    
    for i = 1:size(x,2)
        data(x(i),y(i),z(i))=1;
    end

end