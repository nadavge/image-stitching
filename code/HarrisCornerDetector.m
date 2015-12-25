function [ pos ] = HarrisCornerDetector( im )
%HARRISCORNERDETECTOR Extract key points from the image.
%   Arguments:
%   im - n x m grayscale image to find key points inside.
%   pos - A N x 2 of [x,y] key points positions in im.

    %% Caculate the derivatives
    Ix = conv2( im, [1 0 -1], 'same' );
    Iy = conv2( im, [1; 0; -1], 'same' );

    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.*Iy;
    
    %% Blur the derivatives
    BLUR_SIZE = 3;
    Ix2 = blurInImageSpace( Ix2, BLUR_SIZE );
    Iy2 = blurInImageSpace( Iy2, BLUR_SIZE );
    Ixy = blurInImageSpace( Ixy, BLUR_SIZE );
    
    %% Calculate the eigenvalue sizes 
    % We can tell:
    %   det(M) = (Ix2*Iy2) - (Ixy*Iyx)
    %   trace(M) = Ix2 + Iy2
    k = 0.04;
    R = Ix2.*Iy2 - Ixy.^2 - k*(Ix2 + Iy2).^2;

    %% Find local maxima points using supplied code
    R = nonMaximumSuppression(R);
    [y, x] = find(R);
    pos = cat(2, x, y);

end

