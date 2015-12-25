function [ pyr, filter ] = GaussianPyramid( im, maxLevels, filterSize )
%GAUSSIANPYRAMID Create a gaussian pyramid
%   Create a gaussian pyramid from a grayscale image of type double,
%   with at most maxLevels, and a filter of size filterSize

    MIN_IM_SIZE = 16;

    filter = makeFilter( filterSize );
    pyr = {im};
    
    while min(size(im)) >= MIN_IM_SIZE && length(pyr) < maxLevels,
        imlevel = applyFilter( pyr{end}, filter );
        pyr{end+1,1} = imlevel(1:2:end, 1:2:end);
    end

end

