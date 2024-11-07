function plotAndSaveHeatmap(data, frequencies, directory, file_name, title_text, y_label, x_labels, type)
    % Create a figure with specified size
    figure('Visible', 'off', 'Position', [100, 100, 800, 600]); % Normal figure size (800x600)
    h = heatmap(data);
    
    % Set custom y-axis labels using frequencies
    h.YDisplayLabels = string(frequencies);
    h.YLabel = y_label;
    
    % Set custom x-axis labels 
    h.XDisplayLabels = string(x_labels);
   
    if strcmp(type, 'meridians')
        h.XLabel = 'Mer (N°Mer.N°Point)';
    elseif strcmp(type, 'fibonacci')
        h.XLabel = 'Fib Point Index';
    end
    
    % Set other heatmap properties
    h.Title = title_text;
    colormap('jet');  % Change to your desired colormap
    colorbar;

    % Define the directory path to save plots inside the 'results' folder
    
    
    % Create the directory if it doesn't exist
    % if ~exist(directory, 'dir')
    %     mkdir(directory);
    % end
    
    % Save the figure
    saveas(gcf, fullfile(directory, file_name));
end
