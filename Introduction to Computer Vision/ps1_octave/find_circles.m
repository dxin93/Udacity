function [centers, radii] = find_circles(BW, radius_range)
    % Find circles in given radius range using Hough transform.
    %
    % BW: Binary (black and white) image containing edge pixels
    % radius_range: Range of circle radii [min max] to look for, in pixels

    % TODO: Your code here
    centers = [];
    radii = [];
    H = zeros(rows(BW), columns(BW), radius_range(1,2)-radius_range(1,1)+1);
    for r = radius_range(1,1):radius_range(1,2)
      H(:,:,r-radius_range(1,1)+1) += hough_circles_acc(img_edges,r);
    endfor
    peaks = hough_peaks(H,15);
    for i = 1:rows(peaks)
      centers = [centers; peaks(i,1:2)];
      radii = [radii; peaks(i,3)+radius_range(1,1)-1];
    endfor
    
endfunction
