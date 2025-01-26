% Read the original image
image = imread('liftingbody.png');
image = im2gray(image); % Convert to grayscale if needed

% 1. Image Negative
negative_image = 255 - image;

% 2. Contrast Stretching
min_intensity = double(min(image(:)));
max_intensity = double(max(image(:)));
contrast_stretched = uint8(255 * (double(image) - min_intensity) / (max_intensity - min_intensity));

% 3. Power Law (Gamma Correction)
gamma = 2.5; % Adjust gamma value as needed
power_law_image = uint8(255 * ((double(image) / 255) .^ gamma));

% 4. Logarithmic Transformation
c = 255 / log(1 + double(max(image(:))));
log_transformed = uint8(c * log(1 + double(image)));

% Display Results
figure;
subplot(2, 3, 1);
imshow(image);
title('Original Image');

subplot(2, 3, 2);
imshow(negative_image);
title('Image Negative');

subplot(2, 3, 3);
imshow(contrast_stretched);
title('Contrast Stretching');

subplot(2, 3, 4);
imshow(power_law_image);
title('Gamma Correction');

subplot(2, 3, 5);
imshow(log_transformed);
title('Log Transformation');
