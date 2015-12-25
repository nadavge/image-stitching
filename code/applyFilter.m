function [ blurred_im ] = applyFilter( im, filter )
%APPLYFILTER Blur an image using a given filter
%   Blur an image in image space using filter convolution

    blurred_im = conv2(im, filter, 'same');
    blurred_im = conv2(blurred_im, filter', 'same');
    % Testing actually showed 2d convolution of a matrix filter to be
    % faster than doing a convolution twice with vectors
    
end

