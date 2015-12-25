function [ im ] = LaplacianToImage( lpyr, filter, coeffMultVec )
%LAPLACIANTOIMAGE Laplacian pyramid reconstruction
%   Reconstruct a laplacian pyramid, multiplying each level with the
%   matching coefficient

    
    im = coeffMultVec(end)*lpyr{end};
    % Run from smallest laplacian level
    for i=length(lpyr)-1:-1:1,
        expanded = imexpand( im, filter );
        % Cut the image to match parent in case parent is odd length
        expanded = expanded( 1:size( lpyr{i}, 1 ), ...
            1:size( lpyr{i}, 2) );
        
        im = ( coeffMultVec(i)*lpyr{i} ) + expanded;
    end

end

