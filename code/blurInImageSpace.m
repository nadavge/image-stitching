function [ blurred_im ] = blurInImageSpace( im, kernelSize )
%BLURINIMAGESPACE Blur an image in image space
%   Blur an image in image space using gaussian kernel convolution
    
    %% Blur image
    kernel = makeKernel(kernelSize);
    blurred_im = conv2(im, kernel, 'same');

end
