function plotSingleFigure(x_mesh, y_mesh, z_mesh, SPL_Data, probe_points, row, main_directory)
    % Define the directory path to save plots inside the 'results' folder
    results_directory = 'results';
    directory = fullfile(results_directory, main_directory, 'plots');
    
    % Create the directory if it doesn't exist
    if ~exist(directory, 'dir')
        mkdir(directory);
    end
    
    figure('Position', [100, 100, 800, 600]); % Reduced figure size
    
    % Extract SPL values and frequency
    spl_values_row = SPL_Data{row, 2:end};
    freq_value = SPL_Data{row, 1};
    
    % Plot sphere with scatter points
    mesh(x_mesh, y_mesh, z_mesh, 'EdgeColor', 'k');
    hold on;
    scatter3(probe_points(:,1), probe_points(:,2), probe_points(:,3), 150, spl_values_row, 'filled', 'MarkerEdgeColor', 'k');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    axis equal;
    grid on;
    
    % Setting colorbar
    colormap('jet');
    cbar = colorbar;
    caxis([min(spl_values_row), max(spl_values_row)]);
    cbar.Label.String = 'SPL (dB)';
    
    hold off;
    
    % Set the title for the current subplot
    title(sprintf('SPL at %.2f Hz', freq_value));
    
    % Adjust the figure name
    file_name = sprintf('%s_SPL_%d.png', main_directory, row);
    
    % Save the figure in the 'plots' directory inside 'results'
    saveas(gcf, fullfile(directory, file_name));
end