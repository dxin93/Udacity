% ps1
pkg load image;  % Octave only

%% 1-a
img = imread(fullfile('input', 'ps1-input0.png'));  % already grayscale
%% TODO: Compute edge image img_edges
img_edges = edge(img,'Roberts');
imwrite(img_edges, fullfile('output', 'ps1-1-a-1.png'));  % save as output/ps1-1-a-1.png

%% 2-a
[H, theta, rho] = hough_lines_acc(img_edges);  % defined in hough_lines_acc.m
%% TODO: Plot/show accumulator array H, save as output/ps1-2-a-1.png
grayH = uint8(mat2gray(H) * 255);
imshow(grayH, 'xData', theta, 'yData', rho);
saveas(1,'output/ps1-2-a-1.png');
%% 2-b
peaks = hough_peaks(H, 10);  % defined in hough_peaks.m
%% TODO: Highlight peak locations on accumulator array, save as output/ps1-2-b-1.png
hold on; plot(theta(peaks(:,2)), rho(peaks(:,1)),'rs'); hold off;
saveas(1,'output/ps1-2-b-1.png');

%% TODO: Rest of your code here