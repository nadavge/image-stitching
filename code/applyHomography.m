function pos2 = applyHomography( pos1, H12 )
% APPLYHOMOGRAPHY Transform coordinates pos1 to pos2 using homography H12.
% Arguments:
% pos1 ? An Nx2 matrix of [x,y] point coordinates per row.
% H12 ? A 3x3 homography matrix.
% Returns:
% pos2 ? An Nx2 matrix of [x,y] point coordinates per row obtained from
% transforming pos1 using H12
    N = size(pos1, 1);
    
    tempPos = cat( 2, pos1, ones(N, 1) );
    tempPos = tempPos * H12';
    
    pos2 = tempPos(:, 1:2) ./ [tempPos(:,3) tempPos(:,3)];
end
