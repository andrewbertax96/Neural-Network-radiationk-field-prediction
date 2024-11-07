function meridian_points = generateMeridianPoints(num_meridians, points_per_meridian, radius, center)
    % Generate meridian points on a sphere
    theta = linspace(0, 2*pi, num_meridians+1);
    theta(end) = []; % Remove the last value to avoid duplication

    phi = linspace(0, pi, points_per_meridian+2); % Includes poles
    phi = phi(2:end-1); % Remove the poles

    meridian_points = [];

    % Add the North Pole
    meridian_points = [meridian_points; 0, 0, radius + center(3)];

    for i = 1:num_meridians
        for j = 1:points_per_meridian
            % Spherical coordinates to Cartesian coordinates
            x = radius * sin(phi(j)) * cos(theta(i)) + center(1);
            y = radius * sin(phi(j)) * sin(theta(i)) + center(2);
            z = radius * cos(phi(j)) + center(3);
            meridian_points = [meridian_points; x, y, z];
        end
    end

    % Add the South Pole
    meridian_points = [meridian_points; 0, 0, -radius + center(3)];
end
