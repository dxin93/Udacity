pkg load image;

# read image
img1 = imread('output/ps0-1-a-1.png');
img2 = imread('output/ps0-1-a-2.png');

# separate color channels
img1_red = img1(:,:,1);
img1_green = img1(:,:,2);
img1_blue = img1(:,:,3);

# Swap the red and blue pixels
rb_swap = img1;
rb_swap(:,:,1) = img1_blue;
rb_swap(:,:,3) = img1_red;
imwrite(rb_swap,'output/ps0-2-a-1.png');

# Save files for question 2
imwrite(img1_green,'output/ps0-2-b-1.png');
imwrite(img1_red,'output/ps0-2-c-1.png');

# Swap center pixels
swap_image = img2(:,:,1);

[row1, col1] = size(img1_red);
row1_start = (row1 / 2) - 49;
row1_end = (row1 / 2) + 50;
col1_start = (col1 / 2) - 49;
col1_end = (col1 / 2) + 50;

[row2, col2] = size(swap_image);
row2_start = (row2 / 2) - 49;
row2_end = (row2 / 2) + 50;
col2_start = (col2 / 2) - 49;
col2_end = (col2 / 2) + 50;

swap_image = img2(:,:,1);
swap_image(row2_start:row2_end,col2_start:col2_end) = ...
  img1_red(row1_start:row1_end,col1_start:col1_end);
imwrite(swap_image,'output/ps0-3-a-1.png');     