function [ pyr, filter ] = LaplacianPyramid( im, maxLevels, filterSize )
%LAPLACIANPYRAMID Create a laplacian pyramid
%   Create a laplacian pyramid from a grayscale image of type double,
%   with at most maxLevels, and a filter of size filterSize

    MIN_IM_SIZE = 16;
    
    [gaussianPyr, filter] = GaussianPyramid( im, maxLevels, filterSize );
    pyr = gaussianPyr;
    
    % Run from smallest gaussian image to original
    for i=length(gaussianPyr)-1:-1:1,
        expanded = imexpand( gaussianPyr{i+1}, filter );
        % Cut the image to match parent in case parent is odd length
        expanded = expanded( 1:size( gaussianPyr{i}, 1 ), ...
            1:size( gaussianPyr{i}, 2) );
        
        pyr{i} = gaussianPyr{i} - expanded;
    end

end

