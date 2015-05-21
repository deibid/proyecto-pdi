function [ X1 ] = procesarColor(imBinColor, L )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here




se = strel('disk',2);
imBinErod = imerode(L, se);
imBinErod = bwareaopen(imBinErod, 10);
%imBinErod = uint8(imBinErod);
%figure,imshow(imBinColor)
%figure,imshow(imBinErod,[])
%pause



[X1,R1] = imstack2vectors(imBinColor,imBinErod);


end

