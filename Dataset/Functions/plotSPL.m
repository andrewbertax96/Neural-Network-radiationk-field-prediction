function plotSPL(resultPath, type, meanPlots)
    % Base directory for SPL
    SPLdir = fullfile(resultPath, 'SPL(dB)');
    
    % Get file paths and directories based on type
    [csvFiles, originalDir, meanSubDir] = getFilePathsAndDirectories(SPLdir, type);
    
    % Ensure CSV files are sorted numerically
    csvFiles = sortFilesNumerically(csvFiles, 2);

    % Directory for eigenfrequencies
    eigenFreqDir = fullfile(resultPath, 'eigenfrequencies', 'csv');
    
    % Read eigenfrequencies
    [eigenFrequencies, ~] = readEigenFreq(eigenFreqDir, []); 
    
    % Process and plot each CSV file
    % for i = 1:min(1, length(csvFiles)) % Limiting to one iteration (first simulation)
    for i = 1:length(csvFiles)
        csvFilePath = fullfile(csvFiles(i).folder, csvFiles(i).name);
        data = readtable(csvFilePath);
        data = table2array(data);
        
        frequencies = round(eigenFrequencies(:, i), 2);
        [~, baseFileName, ~] = fileparts(csvFiles(i).name);
        
        % Define the labels for meridians if applicable
        if strcmp(type, 'meridians')
            labels = getMeridianLabels(); % Use meridian labels for the 'meridians' type
        else
            labels = 1:60; 
        end
        
        % Define the plot titles based on the type
        plotTitleOriginal = sprintf('Sim%d (Original)', i);
        plotTitleMeanSub = sprintf('Sim%d (Mean Subtracted)', i);
        
        % Define filenames for saving plots
        originalPlotFileName = sprintf('MatrixPlot_SPL_%s.png', baseFileName);
        meanSubPlotFileName = sprintf('Matrix_Plot_SPL_%s_meanSub.png', baseFileName);
        
        % Plot and save original data
        plotAndSaveHeatmap(data, frequencies, originalDir, originalPlotFileName,...
            plotTitleOriginal,...
            'Frequency [Hz]', labels, type);
        
        % Plot and save mean-subtracted data if applicable
        if meanPlots
            data_mean_subtracted = data - mean(data, 2);
            plotAndSaveHeatmap(data_mean_subtracted, frequencies, meanSubDir, meanSubPlotFileName,...
                plotTitleMeanSub,...
                'Frequency [Hz]', labels, type);
        end

    end
end

function [csvFiles, originalDir, meanSubDir] = getFilePathsAndDirectories(SPLdir, type)
    % Determine directories and file patterns based on the type
    switch type
        case 'fibonacci'
            csvDir = fullfile(SPLdir, 'Fibonacci', 'csv');
            plotsDir = fullfile(SPLdir, 'Fibonacci', 'plots');
            type = 'Fib';
        case 'meridians'
            csvDir = fullfile(SPLdir, 'Meridians', 'csv');
            plotsDir = fullfile(SPLdir, 'Meridians', 'plots');
            type = 'Mer';
        otherwise
            error('Invalid type. Please use either "fibonacci" or "meridian".');
    end
    
    originalDir = fullfile(plotsDir, 'original');
    meanSubDir = fullfile(plotsDir, 'mean subtracted');
    
    % Get list of CSV files
    csvFiles = dir(fullfile(csvDir, sprintf('amps%s_sim*.csv', type)));
end

function labels = getMeridianLabels()
    % Define custom meridian labels
    labels = {'NorthPole', 'M1.1', 'M1.2', 'M1.3', 'M1.4', 'M1.5', 'M1.6', ...
                  'M2.1', 'M2.2', 'M2.3', 'M2.4', 'M2.5', 'M2.6', ...
                  'M3.1', 'M3.2', 'M3.3', 'M3.4', 'M3.5', 'M3.6', ...
                  'M4.1', 'M4.2', 'M4.3', 'M4.4', 'M4.5', 'M4.6', ...
                  'M5.1', 'M5.2', 'M5.3', 'M5.4', 'M5.5', 'M5.6', ...
                  'M6.1', 'M6.2', 'M6.3', 'M6.4', 'M6.5', 'M6.6', ...
                  'M7.1', 'M7.2', 'M7.3', 'M7.4', 'M7.5', 'M7.6', ...
                  'M8.1', 'M8.2', 'M8.3', 'M8.4', 'M8.5', 'M8.6', ...
                  'M9.1', 'M9.2', 'M9.3', 'M9.4', 'M9.5', 'M9.6', ...
                  'M10.1', 'M10.2', 'M10.3', 'M10.4', 'M10.5', 'M10.6', ...
                  'SouthPole'};
end