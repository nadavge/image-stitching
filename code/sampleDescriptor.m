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
    N = size(pos, 1);
    K = 1 + 2*descRad;
    
    xs = pos(:, 1);
    ys = pos(:, 2);
    
    % Preallocate the descriptors matrix
    desc = zeros( K, K, N );
    
    %% Interpolate the descriptors
   
    for dx = -descRad:descRad,
        for dy = -descRad:descRad,
            desc( 1+dy+descRad, 1+dx+descRad, : ) = interp2( ...
                im, xs+dx, ys+dy, 'linear' );
        end
    end
    
    desc = desc - mean(desc(:));
    desc = desc / norm(desc(:));
end
