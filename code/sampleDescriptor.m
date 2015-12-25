function [ desc ] = sampleDescriptor( im, pos, descRad )
%SAMPLEDESCRIPTOR Sample a MOPS-like descriptor at given positions in the
%image.
%   Arguments:
%   im - n x m grayscale image to sample within.
%   pos - A N x 2 matrix of [x,y] descriptor positions in im
%   descRad - "Radius" of descriptors to compute
%   Returns:
%   desc - A k x k x N matrix containing the ith descriptor at desc(:,:,i).
%   The per-descripor dimensions k x k are related to the descRad as
%   follows: k = 1 + 2*descRad
    PYRAMID_LEVELS = 3;
    N = size(pos, 1);
    K = 1 + 2*descRad;
    
    pyr = GaussianPyramid( im, PYRAMID_LEVELS, descRad );
    pyrIm = pyr{PYRAMID_LEVELS};
    
    % Calculate the position of the centers in the 3rd level
    new_pos = 2^(1 - PYRAMID_LEVELS)*(pos -1 ) + 1;
    xs = new_pos(:, 1);
    ys = new_pos(:, 2);
    
    % Preallocate the descriptors matrix
    desc = zeros( K, K, N );
    
    %% Interpolate the descriptors
    [X, Y] = meshgrid( 1:size( pyrIm, 2 ), 1:size( pyrIm, 1 ) );
    
    for dx = -descRad:descRad,
        for dy = -descRad:descRad,
            desc( 1+dy+descRad, 1+dx+descRad, : ) = interp2( X, Y,...
                pyrIm, xs+dx, ys+dy, 'linear' );
        end
    end
    
end

