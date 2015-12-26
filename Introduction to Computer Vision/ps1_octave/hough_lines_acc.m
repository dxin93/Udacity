function [H, theta, rho] = hough_lines_acc(BW, varargin)
    % Compute Hough accumulator array for finding lines.
    %
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): Difference between successive rho values, in pixels
    % Theta (optional): Vector of theta values to use, in degrees
    %
    % Please see the Matlab documentation for hough():
    % http://www.mathworks.com/help/images/ref/hough.html
    % Your code should imitate the Matlab implementation.
    %
    % Pay close attention to the coordinate system specified in the assignment.
    % Note: Rows of H should correspond to values of rho, columns those of theta.

    %% Parse input arguments
    p = inputParser();
    p.addParamValue('RhoResolution', 1);
    p.addParamValue('Theta', linspace(-90, 89, 180));
    p.parse(varargin{:});
    
    rhoStep = p.Results.RhoResolution;
    D = sqrt((rows(BW) - 1)^2 + (columns(BW) - 1)^2);
    nrho = 2 * (ceil(D/rhoStep)) + 1; 
    diag = rhoStep * (ceil(D/rhoStep));
    rho = linspace(-diag, diag, nrho);
    
    theta = p.Results.Theta;
  
    H = zeros(nrho, columns(theta));
    %% TODO: Your code here
    for i = 1:rows(BW)
      for j = 1:columns(BW)
        if (BW(i,j) == 1)
          t = atan2d(i,j);
          theta_id = find(theta <= t, 1, 'last');
          d = j*cosd(t) + i*sind(t);
          rho_id = find(rho <= d, 1, 'last');
          H(rho_id,theta_id) += 1;
        endif
      endfor
    endfor
    
endfunction
