function [phi_mesh, theta_mesh, x_mesh, y_mesh, z_mesh] = createSphereMesh(radius, center)
    % Creates the sphere mesh grid for plotting
    [phi_mesh, theta_mesh] = meshgrid(linspace(0, pi, 30), linspace(0, 2*pi, 60));
    x_mesh = radius * sin(phi_mesh) .* cos(theta_mesh) + center(1);
    y_mesh = radius * sin(phi_mesh) .* sin(theta_mesh) + center(2);
    z_mesh = radius * cos(phi_mesh) + center(3);
end
