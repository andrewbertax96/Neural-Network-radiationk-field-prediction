function plotAndSaveHeatmap(data, frequencies, directory, file_name, y_label, x_labels)
    % Create a figure with specified size
    figure('Position', [100, 100, 800, 600]); % Normal figure size (800x600)
    h = heatmap(data);
    
    % Set custom y-axis labels using frequencies
    h.YDisplayLabels = string(frequencies);
    h.YLabel = y_label;
    
    % Set custom x-axis labels if provided
    if nargin > 5
        h.XDisplayLabels = string(x_labels);
        h.XLabel = 'Meridians (N°Meridian.N°Point)';
    else
        h.XLabel = 'Fibonacci Points Index';
    end
    
    % Set other heatmap properties
    % h.Title = title_text;
    colormap('jet');  % Change to your desired colormap
    colorbar;

    % Define the directory path to save plots inside the 'results' folder
    results_directory = 'results';
    directory = fullfile(results_directory, directory, 'plots');
    
    % Create the directory if it doesn't exist
    if ~exist(directory, 'dir')
        mkdir(directory);
    end
    
    % Save the figure
    saveas(gcf, fullfile(directory, file_name));
end
