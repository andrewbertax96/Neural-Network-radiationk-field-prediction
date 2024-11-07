function plotFrequencyVsStiffness(Ex_values, first_eigenfrequency, title_suffix, resultsPath, filename)
    % Create the 'plot' directory inside the 'results' folder if it doesn't exist
    plotFolderPath = fullfile(resultsPath, 'eigenfrequencies', 'plots');
    if ~exist(plotFolderPath, 'dir')
        mkdir(plotFolderPath);
    end
    
    figure;
    scatter(Ex_values, first_eigenfrequency, 'filled');
    xlabel('E_X [GPa]');
    ylabel('Frequency [Hz]');
    % title(['Frequency of the First Peak', title_suffix]);
    grid on;
    
    % Save the plot in the 'plot' directory
    saveas(gcf, fullfile(plotFolderPath, filename));
end