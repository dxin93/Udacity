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
        [r,t] = find(H == local_max, 1);
        
        NHoodY_Low = max([1 floor(r-nHoodSize(1))]);
        NHoodY_High = min([rows(H) ceil(r+nHoodSize(1))]);
        NHoodX_Low = max([1 floor(t-nHoodSize(2))]);
        NHoodX_High = min([columns(H) ceil(t+nHoodSize(2))]);
        
        H(NHoodY_Low:NHoodY_High,NHoodX_Low:NHoodX_High) = 0;
        
        peaks = [peaks; r, t];
      endif
    endfor
endfunction
