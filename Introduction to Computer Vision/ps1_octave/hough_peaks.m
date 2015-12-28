function peaks = hough_peaks(H, varargin)
    % Find peaks in a Hough accumulator array.
    %
    % Threshold (optional): Threshold at which values of H are considered to be peaks
    % NHoodSize (optional): Size of the suppression neighborhood, [M N]
    %
    % Please see the Matlab documentation for houghpeaks():
    % http://www.mathworks.com/help/images/ref/houghpeaks.html
    % Your code should imitate the matlab implementation.

    %% Parse input arguments
    p = inputParser;
    p.addOptional('numpeaks', 1, @isnumeric);
    p.addParamValue('Threshold', 0.5 * max(H(:)));
    p.addParamValue('NHoodSize', floor(size(H) / 100.0) * 2 + 1);  % odd values >= size(H)/50
    p.parse(varargin{:});

    numpeaks = p.Results.numpeaks;
    threshold = p.Results.Threshold;
    nHoodSize = p.Results.NHoodSize;

    % TODO: Your code here
    peaks = [];

    for i = 1:numpeaks
      sorted = sort(H(:),'descend');
      local_max = sorted(1);
      
      if local_max >= threshold
        if (ndims(H) == 2)
          [r,t] = find(H == local_max, 1);
        elseif (ndims(H) == 3)
          temp = find(H == local_max, 1);
          r = ceil(temp/(rows(H)*columns(H)));
          temp = temp - (r-1) * (rows(H)*columns(H));
          b = ceil(temp/rows(H));
          a = temp - (b-1) * rows(H);
        endif
        
        if (ndims(H) == 2)
          NHoodY_Low = max([1 floor(r-nHoodSize(1))]);
          NHoodY_High = min([rows(H) ceil(r+nHoodSize(1))]);
          NHoodX_Low = max([1 floor(t-nHoodSize(2))]);
          NHoodX_High = min([columns(H) ceil(t+nHoodSize(2))]);
        
          H(NHoodY_Low:NHoodY_High,NHoodX_Low:NHoodX_High) = 0;
          peaks = [peaks; r, t];
        elseif (ndims(H) == 3)
          NHoodY_Low = max([1 floor(a-nHoodSize(1))]);
          NHoodY_High = min([rows(H) ceil(a+nHoodSize(1))]);
          NHoodX_Low = max([1 floor(b-nHoodSize(2))]);
          NHoodX_High = min([columns(H) ceil(b+nHoodSize(2))]);
          NHoodR_Low = max([1 (r-10)]);
          NHoodR_High = min([size(H,3) (r+10)]);
          
          H(NHoodY_Low:NHoodY_High,NHoodX_Low:NHoodX_High,NHoodR_Low:NHoodR_High) = 0;
          peaks = [peaks; a, b, r];
        endif
      endif
    endfor
endfunction
