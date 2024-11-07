function fibonacci_points = generateFibonacciPoints(samples, radius, center)
    % Generate points distributed on a sphere using the Fibonacci method
    fibonacci_points = zeros(samples, 3);
    phi = pi * (3 - sqrt(5));  % golden angle in radians

    for i = 0:samples-1
        y = 1 - (i / (samples - 1)) * 2;  % y ranges from 1 to -1
        radius_at_y = sqrt(1 - y * y);  % radius at y

        theta = phi * i;  % golden angle increment

        x = cos(theta) * radius_at_y;
        z = sin(theta) * radius_at_y;

        % Scale by radius and translate to center
        x = center(1) + radius * x;
        y = center(2) + radius * y;
        z = center(3) + radius * z;

        fibonacci_points(i + 1, :) = [x, y, z];
    end
end
