% Chessboard Distance Calculation with Visualization
% Define points
p1 = [1, 2]; %  first point (x1, y1)
p2 = [4, 6]; %  second point (x2, y2)

% Calculate Chessboard Distance
chessBoardDistance = max(abs(p2 - p1));

% Display the result
fprintf('Chessboard Distance between points [%d, %d] and [%d, %d] is: %.2f\n', ...
    p1(1), p1(2), p2(1), p2(2), chessBoardDistance);

% Visualization
figure;
hold on;
plot([p1(1), p2(1)], [p1(2), p2(2)], 'g--'); % Diagonal line (approximation)
scatter(p1(1), p1(2), 'filled', 'r'); % Point 1
scatter(p2(1), p2(2), 'filled', 'b'); % Point 2
text(p1(1), p1(2), ' P1', 'VerticalAlignment', 'bottom');
text(p2(1), p2(2), ' P2', 'VerticalAlignment', 'bottom');
title('Chessboard Distance Visualization');
grid on;
hold off;
