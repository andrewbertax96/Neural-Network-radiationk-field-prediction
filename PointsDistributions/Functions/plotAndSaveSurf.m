function plotAndSaveSurf(x_mesh, y_mesh, z_mesh, SPL_Data, probe_points, start_row, main_directory)
    % Define the directory path to save plots inside the 'results' folder
    results_directory = 'results';
    directory = fullfile(results_directory, main_directory, 'plots');
    
    % Create the directory if it doesn't exist
    if ~exist(directory, 'dir')
        mkdir(directory);
    end
    
    % Loop over each frequency to create individual plots
    num_frequencies = height(SPL_Data);
    for row = start_row:num_frequencies
        figure('Position', [100, 100, 800, 600]); % Normal figure size
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
        colormap('jet');  % Change to your desired colormap
        cbar = colorbar;
        caxis([min(spl_values_row), max(spl_values_row)]);
        cbar.Label.String = 'SPL (dB)';
        
        hold off;
        
        % Set the title and save the figure
        title(sprintf('SPL at %.2f Hz', freq_value));
        file_name = sprintf('%s_SPL_%d.png', main_directory, row);
        saveas(gcf, fullfile(directory, file_name));
    end
end
