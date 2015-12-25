function [ blendim ] = pyramidBlending( im1, im2, mask, maxLevels, ...
    filterSizeIm, filterSizeMask )
%PYRAMIDBLENDING Use laplacian pyramids to blend two images together

    
    [lpyr1, filter] = LaplacianPyramid( im1, maxLevels, filterSizeIm );
    lpyr2 = LaplacianPyramid( im2, maxLevels, filterSizeIm );
    
    mask = double(mask);
    pyrMask = GaussianPyramid( mask, maxLevels, filterSizeMask );
    
    blendPyr = cell(size(lpyr1));
    levels = length(blendPyr);

    for level=1:levels,
        l1 = lpyr1{level};
        l2 = lpyr2{level};
        gmask = pyrMask{level};
        
        blendPyr{level} = gmask.*l1 + ( 1-gmask ).*l2;
    end
    
    blendim = LaplacianToImage( blendPyr, filter, ones(levels, 1) );
end

