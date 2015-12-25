function [ expanded_im ] = imexpand( im, filter )
%IMEXPAND Expand an image derived from a given filter
%   Expand using zero padding and blurring

    expandFilter = filter*2; % Double to maintain brightness
    
    expanded_im = zeros(size(im)*2);
    expanded_im( 1:2:end, 1:2:end ) = im;
    expanded_im = applyFilter( expanded_im, expandFilter );

end

