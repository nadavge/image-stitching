function [ind1,ind2] = matchFeatures(desc1,desc2,minScore)
% MATCHFEATURES Match feature descriptors in desc1 and desc2.
% Arguments:
% desc1 ? A kxkxn1 feature descriptor matrix.
% desc2 ? A kxkxn2 feature descriptor matrix.
% minScore ? Minimal match score between two descriptors required to be
% regarded as matching.
% Returns:
% ind1,ind2 ? These are m?entry arrays of match indices in desc1 and desc2.
%
% Note:
% 1. The descriptors of the ith match are desc1(ind1(i)) and desc2(ind2(i)).
% 2. The number of feature descriptors n1 generally differs from n2
% 3. ind1 and ind2 have the same length.

    % Reshape them to allow faster dot product
    desc1 = reshape(desc1, size(desc1,1)*size(desc1,2), size(desc1,3));
    desc2 = reshape(desc2, size(desc2,1)*size(desc2,2), size(desc2,3));
    
    % Calculate the dot product, the item S(i,j) will be desc1(i)*desc2(j)
    S = desc1' * desc2;
    
    % Find the 2nd max of every column
    secondMaxCols = sort(S, 'descend');
    secondMaxCols = secondMaxCols(2, :);
    
    % Find the 2nd max of every row
    secondMaxRows = sort(S, 2, 'descend');
    secondMaxRows = secondMaxRows(:, 2);
    
    % Since we require it to be greater than both of the 2nd maximums,
    % It's enough to compare it to the maximum among them, and the maximum
    % of that and minScore
    [secondMaxCols, secondMaxRows] = meshgrid(secondMaxCols, secondMaxRows);
    filter = max(secondMaxCols, secondMaxRows);
    filter = max(filter, minScore);
    
    matches = S >= filter;
end
