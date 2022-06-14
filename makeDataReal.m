function [new_data] = makeDataReal()

data=tiffreadVolume("data\132_750x750x980_med3d.tif");
new_data=zeros(750,750,750,"uint8");
for i = 116:865
    a = data(:,:,i);
    bin = a<90;
    bin = bwareaopen(bin, 50); 
    bin = imclose(bin, ones(3));
    bin = imopen(bin, ones(3));
    bin = bwareaopen(bin, 100);
    %new_data(:,:,:,i-115)= imoverlay(a, edge(bin), 'r');
    new_data(:,:,i-115)= edge(bin);
%     if(mod(i,100)==0)
%         i
%     end
end

end