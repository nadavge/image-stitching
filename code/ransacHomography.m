function [H12,inliers] = ransacHomography(pos1,pos2,numIters,inlierTol)
% RANSACHOMOGRAPHY Fit homography to maximal inliers given point matches
% using the RANSAC algorithm.
% Arguments:
% pos1,pos2 ? Two Nx2 matrices containing n rows of [x,y] coordinates of
% matched points.
% numIters ? Number of RANSAC iterations to perform.
% inlierTol ? inlier tolerance threshold.
% Returns:
% H12 ? A 3x3 normalized homography matrix.
% inliers ? A kx1 vector where k is the number of inliers, containing the
% indices in pos1/pos2 of the maximal set of inlier matches found.
    POINTS = 4;
    N = size(pos1, 1);
    
    inliers = [];
    H12 = diag([1 1 1]);
    
    for j=1:numIters,
        indices = randperm( N, 4 );
        p1 = pos1(indices, :);
        p2 = pos2(indices, :);
        
        tempH12 = leastSquaresHomography( p1, p2 );
        
        homoPos1 = applyHomography( pos1, tempH12 );
        E = homoPos1 - pos2;
        E = E(:, 1).^2 + E(:, 2).^2;
        
        E = E <= inlierTol;
        tempInliers = find(E);
        
        if length(tempInliers) > length(inliers),
            inliers = tempInliers;
            H12 = tempH12;
        end
    end
    
end
