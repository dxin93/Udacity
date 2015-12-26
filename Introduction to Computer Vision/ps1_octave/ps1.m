% ps1
pkg load image;  % Octave only

%% 1-a
img = imread(fullfile('input', 'ps1-input0.png'));  % already grayscale
%% TODO: Compute edge image img_edges
img_edges = edge(img,'Canny');
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
%% 2-c
hough_lines_draw(img, 'ps1-2-c-1.png', peaks, rho, theta);

%% 3-a
img = imread(fullfile('input', 'ps1-input0-noise.png'));
f_size = 20;
f_sigma = 5;
fil = fspecial('gaussian',f_size,f_sigma);
filtered = imfilter(img,fil,'replicate');
imwrite(filtered, fullfile('output', 'ps1-3-a-1.png'));

%% 3-b
dirty_edges = edge(img,'Canny');
imwrite(dirty_edges, fullfile('output', 'ps1-3-b-1.png'));
clean_edges = edge(filtered,'Canny');
imwrite(clean_edges, fullfile('output', 'ps1-3-b-2.png'));

%% 3-c
[H, theta, rho] = hough_lines_acc(clean_edges, 'Theta', [-90 0]);
grayH = uint8(mat2gray(H) * 255);
imshow(grayH, 'xData', theta, 'yData', rho);
peaks = hough_peaks(H, 10, 'Threshold', 0.25 * max(H(:)));
hold on; plot(theta(peaks(:,2)), rho(peaks(:,1)),'rs'); hold off;
saveas(1,'output/ps1-3-c-1.png');

hough_lines_draw(img, 'ps1-3-c-2.png', peaks, rho, theta);
