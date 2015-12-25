function [pos,desc] = findFeatures(pyr)
% FINDFEATURES Detect feature points in pyramid and sample their descriptors.
% This function should call the functions spreadOutCorners for getting the keypoints, and
% sampleDescriptor for sampling a descriptor for each keypoint
% Arguments:
% pyr ? Gaussian pyramid of a grayscale image having 3 levels.
% Returns:
% pos ? An Nx2 matrix of [x,y] feature positions per row found in pyr. These
% coordinates are provided at the pyramid level pyr{1}.
% desc ? A kxkxN feature descriptor matrix.
    DESC_RADIUS = 3;
    
    pos = spreadOutCorners( pyr{1}, 7, 7, DESC_RADIUS );
    % Calculate the position of the centers in the 3rd level
    pos3 = 2^( 1-3 )*( pos-1 ) + 1;
    desc = sampleDescriptor( pyr{3} , pos3, DESC_RADIUS );

end
