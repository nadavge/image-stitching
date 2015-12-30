function [ blurred_im ] = blurInImageSpace( im, kernelSize )
%BLURINIMAGESPACE Blur an image in image space
%   Blur an image in image space using gaussian kernel convolution
    
    %% Blur image
    filter = makeFilter(kernelSize);
    blurred_im = applyFilter( im, filter );

end
