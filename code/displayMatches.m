function displayMatches(im1,im2,pos1,pos2,inliers)
% DISPLAYMATCHES Display matched pt. pairs overlayed on given image pair.
% Arguments:
% im1,im2 ? two grayscale images
% pos1,pos2 ? Nx2 matrices containing n rows of [x,y] coordinates of matched
% points in im1 and im2 (i.e. the i’th match’s coordinate is
% pos1(i,:) in im1 and and pos2(i,:) in im2).
% inliers ? A kx1 vector of inlier matches (e.g. see output of
% ransacHomography.m)
    N = size( pos1, 1 );
    
    maxHeight = max( size(im1, 1), size(im2, 1) );   
    width = size(im1, 2) + size(im2, 2);
    im2offset = size(im1, 2);
    
    im = zeros(maxHeight, width);
    im( 1:size(im1,1), 1:size(im1,2) ) = im1;
    im( 1:size(im2,1), (1:size(im2,2)) + im2offset ) = im2;
    figure;imshow(im);
    hold on;
    
    % Add the offset of the 2nd image to allow easy plotting
    offsetMat = repmat( [im2offset 0], [N 1] );
    pos2 = pos2 + offsetMat;
    clear offsetMat;

    plot( pos1(:, 1), pos1(:, 2), '.r' );
    plot( pos2(:, 1), pos2(:, 2), '.r' );
    
    inliersPos1 = pos1(inliers, :);
    inliersPos2 = pos2(inliers, :);
    outliersPos1 = pos1;
    outliersPos1(inliers, :) = [];
    outliersPos2 = pos2;
    outliersPos2(inliers, :) = [];
    
    inliersX = cat(2, inliersPos1(:,1), inliersPos2(:,1));
    outliersX = cat(2, outliersPos1(:,1), outliersPos2(:,1));
    inliersY = cat(2, inliersPos1(:,2), inliersPos2(:,2));
    outliersY = cat(2, outliersPos1(:,2), outliersPos2(:,2));
    clear inliersPos1 inliersPos2 outliersPos1 outliersPos2;
    
    plot( outliersX' , outliersY', '-b' );
    plot( inliersX' , inliersY', '-y' );
end
