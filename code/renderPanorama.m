function panorama = renderPanorama(im,H)
% RENDERPANORAMA Renders a set of images into a combined panorama image.
% Arguments:
% im ? Cell array of n grayscale images.
% H ? Cell array of n 3x3 homography matrices transforming the ith image
% coordinates to the panorama image coordinates.
% Returns:
% panorama ? A grayscale panorama image composed of n vertical strips that
% were backwarped each from the relevant frame im{i} using homography H{i}.

    count = length(im);
    corners = zeros( 4, 2, count ); % Corner, [x, y], image

    for i=1:count,
        [height, width] = size(im{i});
        myCorners = [1, 1;
                     1 height;
                     width height;
                     width 1];
                 
        corners(:,:,i) = applyHomography(myCorners, H{i});
    end
    
    xs = corners(:,1,:);
    xmin = min(xs(:));
    xmax = max(xs(:));
    
    ys = corners(:,2,:);
    ymin = min(ys(:));
    ymax = max(ys(:));
    
    % Calculate the centers. Since homographies are linear, the center
    % would simply be the mean of the corners
    centers = (corners(1, :, :) + corners(3, :, :)) / 2;
    centers = reshape(centers, [2, count])';
    
    % Set strip edges. X_min and X_max, and in between the centers of the 
    % images. Therefore, strip i ends in center(i)+center(i+1)/2
    strips = zeros(count + 1, 1);
    strips(1) = xmin;
    strips(2:end-1) = (centers(1:end-1, 1) + centers(2:end, 1)) / 2;
    strips(end) = xmax + 1;
    
    % Set the X_pano and Y_pano, used later for the interpolation, to fill
    % Ipano, the panoramic image
    [Xpano, Ypano] = meshgrid(xmin:xmax, ymin:ymax);
    panorama = zeros(size(Xpano));
    
    % Iterate over the images, for each image, find the new X_s and Y_s in
    % the panoramic image related to it, find the coordinates leading to
    % these places after homography, and interploate them to allow a
    % homography to the panoramic image.
    
    filterSizeIm = 13;
    filterSizeMask = 13;
    maxLevels = 7;
    
    for i=1:count,       
        % Homograph the image to the panorama
        posPano = [ Xpano(:) Ypano(:) ];
        posOrig = applyHomography(posPano, inv(H{i}));
        
        imPano = interp2(im{i}, posOrig(:,1), posOrig(:,2), 'linear');
        imPano(isnan(imPano)) = 0;
        imPano = reshape(imPano, size(panorama));
        
        centerIdx = find(centers(i, 1) <= Xpano(1,:));
        % If the first, assign it as the image
        if i == 1,
            panorama = imPano;
        % Otherwise, merge with the previous one
        else
            mask = zeros(size(panorama));
            mask(strips(i) <= Xpano) = 1;
            
            % Running the pyramid blending in big frames is expensive, so
            % instead we merge them only between the two centers.
            % In order to do that we take everything to the right of the
            % center of the last picture, that is also not to the right of
            % the current center.
            cornersX = corners(:,1,i-1:i);
            cornersX = cornersX(:);

            % TODO fix a bound here, incorrect (exceeds matrix size)
            leftBound = floor(min(cornersX) - xmin) + 1;
            rightBound = floor(max(cornersX) - xmin) + 1;
            blendRange = leftBound:rightBound;
            
            panorama(:, blendRange) = pyramidBlending( ...
                imPano(:, blendRange), panorama(:, blendRange),...
                mask(:, blendRange),...
                maxLevels, filterSizeIm, filterSizeMask );
            
            %figure;imshow(imPano(:, blendRng));
            %figure;imshow(panorama(:, blendRng));
            %input('continue...');
            
            % Put the rest of imPano to the right of center
            panorama( :, centerIdx:end ) = imPano( :, centerIdx:end );
        end
        
    end
end
