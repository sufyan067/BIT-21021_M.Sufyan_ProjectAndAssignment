% Read the input image
[file, path] = uigetfile({'*.png;*.jpg;*.jpeg'}, 'Select an Image');
image = imread(fullfile(path, file));

% Step 1: Detect Image Type (Binary, Grayscale, or RGB)
if ndims(image) == 3
    disp('Image Type: RGB');
    grayscale = rgb2gray(image); % Convert to grayscale for analysis
else
    disp('Image Type: Grayscale');
    grayscale = image;
end

% Check if the image is binary
if islogical(grayscale)
    disp('Image Type: Binary');
end

% Step 2: Analyze the Issue (Histogram Analysis)
figure;
subplot(2, 3, 1);
imshow(image);
title('Original Image');

subplot(2, 3, 2);
imhist(grayscale);
title('Histogram');

% Determine image condition
mean_intensity = mean(grayscale(:));
if mean_intensity < 50
    disp('Issue: Over Dark');
    issue = 'dark';
elseif mean_intensity > 200
    disp('Issue: Over Bright');
    issue = 'bright';
elseif std(double(grayscale(:))) < 30
    disp('Issue: Low Contrast');
    issue = 'low_contrast';
else
    disp('Image is Normal');
    issue = 'normal';
end

% Step 3: Resolve the Issue
if strcmp(issue, 'dark')
    % Apply Histogram Equalization
    enhanced_image = histeq(grayscale);
elseif strcmp(issue, 'bright')
    % Apply Gamma Correction
    gamma = 0.4; % Reduce brightness
    enhanced_image = uint8(255 * ((double(grayscale) / 255) .^ gamma));
elseif strcmp(issue, 'low_contrast')
    % Apply Contrast Stretching
    min_intensity = double(min(grayscale(:)));
    max_intensity = double(max(grayscale(:)));
    enhanced_image = uint8(255 * (double(grayscale) - min_intensity) / (max_intensity - min_intensity));
else
    enhanced_image = grayscale; % No enhancement needed
end

% Step 4: Display the Enhanced Image
subplot(2, 3, 3);
imshow(enhanced_image);
title('Enhanced Image');

subplot(2, 3, 4);
imhist(enhanced_image);
title('Enhanced Histogram');

disp('Processing Complete.');
