function hough_lines_draw(img, outfile, peaks, rho, theta)
    % Draw lines found in an image using Hough transform.
    %
    % img: Image on top of which to draw lines
    % outfile: Output image filename to save plot as
    % peaks: Qx2 matrix containing row, column indices of the Q peaks found in accumulator
    % rho: Vector of rho values, in pixels
    % theta: Vector of theta values, in degrees

    % TODO: Your code here
    imshow(img);
    hold on;
    for i = 1:rows(peaks)
      r = rho(1,peaks(i,1));
      t = theta(1,peaks(i,2));
      
      if t ~= 0
        x = 1:columns(img);
        y = (r - x*cosd(t))/sind(t);
      else
        x = ones(1, columns(img)) * r;
        y = 1:rows(img); 
      endif
      plot(x,y, 'g-');
    endfor
    hold off;
    
    saveas(1,fullfile('output', outfile));
endfunction
