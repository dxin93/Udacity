function H = hough_circles_acc(BW, radius)
    % Compute Hough accumulator array for finding circles.
    %
    % BW: Binary (black and white) image containing edge pixels
    % radius: Radius of circles to look for, in pixels

    % TODO: Your code here
    H = zeros(size(BW));
    t = linspace(-90, 89, 180);
    
    for i = 1:rows(BW)
      for j = 1:columns(BW)
        if (BW(i,j) == 1)
          for n = 1:columns(t)
            theta = t(n);
            a = round(j - radius * cosd(theta));
            b = round(i + radius * sind(theta));
            if (a >= 1 && b >= 1 && a <= rows(H) && b <= columns(H))
              H(a,b) += 1;
            endif
          endfor
        endif
      endfor
    endfor
endfunction
