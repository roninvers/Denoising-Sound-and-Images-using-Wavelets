% Load the image
image_file = '/Users/ronin/Downloads/Important Documents/me.jpg';  % Use the correct file extension

% Load the original RGB image
original_img = imread(image_file);  % Read the image

% Convert to double for processing
original_img = double(original_img);
disp(original_img(1:10, 1:10));
% Separate color channels of the original image
R = original_img(:,:,1);  % Red channel
G = original_img(:,:,2);  % Green channel
B = original_img(:,:,3);  % Blue channel

% Set noise level
noise_std_dev = 60;  % Standard deviation for Gaussian noise

% Add Gaussian noise to each color channel
R_noisy = R + noise_std_dev * randn(size(R));
G_noisy = G + noise_std_dev * randn(size(G));
B_noisy = B + noise_std_dev * randn(size(B));

% Combine the noisy channels back into an RGB image
noisy_img = cat(3, R_noisy, G_noisy, B_noisy);

% Convert the noisy image to uint8 for display
noisy_img = uint8(noisy_img);

% Apply Gaussian Filter for Denoising
h = fspecial('gaussian', [1 100], 1);  % Create a Gaussian filter
R_gaussian = imfilter(R_noisy, h, 'same');  % Apply Gaussian filter to Red channel
G_gaussian = imfilter(G_noisy, h, 'same');  % Apply Gaussian filter to Green channel
B_gaussian = imfilter(B_noisy, h, 'same');  % Apply Gaussian filter to Blue channel

% Combine Gaussian-filtered channels
denoised_gaussian_1 = cat(3, R_gaussian, G_gaussian, B_gaussian);

h = fspecial('gaussian', [50 5], 1);  % Create a Gaussian filter
R_gaussian = imfilter(R_noisy, h, 'same');  % Apply Gaussian filter to Red channel
G_gaussian = imfilter(G_noisy, h, 'same');  % Apply Gaussian filter to Green channel
B_gaussian = imfilter(B_noisy, h, 'same');  % Apply Gaussian filter to Blue channel

% Combine Gaussian-filtered channels
denoised_gaussian_5 = cat(3, R_gaussian, G_gaussian, B_gaussian);

h = fspecial('gaussian', [9 1], 1);  % Create a Gaussian filter
R_gaussian = imfilter(R_noisy, h, 'same');  % Apply Gaussian filter to Red channel
G_gaussian = imfilter(G_noisy, h, 'same');  % Apply Gaussian filter to Green channel
B_gaussian = imfilter(B_noisy, h, 'same');  % Apply Gaussian filter to Blue channel

% Combine Gaussian-filtered channels
denoised_gaussian_9 = cat(3, R_gaussian, G_gaussian, B_gaussian);

% Apply Median Filter for Denoising
R_median = medfilt2(R_noisy, [5 5]);  % Apply median filter to Red channel
G_median = medfilt2(G_noisy, [5 5]);  % Apply median filter to Green channel
B_median = medfilt2(B_noisy, [5 5]);  % Apply median filter to Blue channel

% Combine Median-filtered channels
denoised_median = cat(3, R_median, G_median, B_median);

% % Display the original, noisy, and denoised images
figure;

% Define layout dimensions for easy management
rows = 4;  % Define the total rows of subplots
cols = 3;  % Define the total columns of subplots

% Display Original Image
subplot(rows, cols, 1);
imshow(uint8(original_img));  % Convert original image back to uint8 for display
title('Original Image');
 
% Display Noisy Image
subplot(rows, cols, 2);
imshow(noisy_img);
title('Noisy Image');

% Display Gaussian Denoised Images with Different Filter Sizes
subplot(rows, cols, 3);
imshow(uint8(denoised_gaussian_1));  % Convert to uint8 for display
title('Gaussian Denoised Image [1 1]');

subplot(rows, cols, 4);
imshow(uint8(denoised_gaussian_5));  % Convert to uint8 for display
title('Gaussian Denoised Image [5 5]');

subplot(rows, cols, 5);
imshow(uint8(denoised_gaussian_9));  % Convert to uint8 for display
title('Gaussian Denoised Image [9 9]');

% Display Median Denoised Image
subplot(rows, cols, 6);
imshow(uint8(denoised_median));  % Convert to uint8 for display
title('Median Denoised Image');

% Display Red, Green, and Blue Channels after Gaussian Filtering
subplot(rows, cols, 7);
imshow(R_gaussian, []);
title('Red Channel (Gaussian Filtered)');

subplot(rows, cols, 8);
imshow(G_gaussian, []);
title('Green Channel (Gaussian Filtered)');

subplot(rows, cols, 9);
imshow(B_gaussian, []);
title('Blue Channel (Gaussian Filtered)');

% Display Red, Green, and Blue Channels before Gaussian Filtering
subplot(rows, cols, 10);
imshow(R_noisy, []);
title('Red Channel (Noisy Image)');

subplot(rows, cols, 11);
imshow(G_noisy, []);
title('Green Channel (Noisy Image)');

subplot(rows, cols, 12);
imshow(B_noisy, []);
title('Blue Channel (Noisy Image)');
 
