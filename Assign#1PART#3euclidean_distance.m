% Euclidean Distance Calculation with Circle Visualization
% Define points
p1 = [1, 2]; % First point (x1, y1)
p2 = [4, 6]; % Second point (x2, y2)

% Calculate Euclidean Distance
euclideanDistance = sqrt(sum((p2 - p1).^2));

% Display the result
fprintf('Euclidean Distance between points [%d, %d] and [%d, %d] is: %.2f\n', ...
    p1(1), p1(2), p2(1), p2(2), euclideanDistance);

% Visualization
figure;
hold on;

% Plot points
scatter(p1(1), p1(2), 100, 'r', 'filled'); % Point 1
scatter(p2(1), p2(2), 100, 'b', 'filled'); % Point 2

% Add labels to points
text(p1(1), p1(2), ' P1', 'VerticalAlignment', 'bottom');
text(p2(1), p2(2), ' P2', 'VerticalAlignment', 'bottom');

% Draw straight line between points
plot([p1(1), p2(1)], [p1(2), p2(2)], 'k-', 'LineWidth', 1.5); % Straight line

% Plot circle
theta = linspace(0, 2*pi, 100); % Angle values for circle
x_circle = p1(1) + euclideanDistance * cos(theta); % X-coordinates of circle
y_circle = p1(2) + euclideanDistance * sin(theta); % Y-coordinates of circle
plot(x_circle, y_circle, 'g--', 'LineWidth', 1.5); % Circle around p1

% Titles and grid
title('Euclidean Distance with Circle Visualization');
grid on;
axis equal; % Equal scaling for both axes
hold off;
