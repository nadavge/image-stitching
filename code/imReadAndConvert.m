function [ image ] = imReadAndConvert( filename, representation )
%IMREADANDCONVERT Reads an image file and converts it to the specified
%representation
%   filename - the filename to read
%   representation - one of the following:
%       1 - grayscale
%       2 - RGB
    REPR_GRAY = 1;
    REPR_RGB = 2;

    info = imfinfo(filename);
    image = imread(filename);
    
    if representation==REPR_GRAY,
        if strcmp(info.ColorType,'truecolor'),
            image = rgb2gray(image);
        end
    end

    image = im2double(image);
end

