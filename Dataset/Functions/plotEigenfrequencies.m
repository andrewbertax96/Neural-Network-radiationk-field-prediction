function plotEigenfrequencies(resultsPath)
    % Define directories
    eigenFreqDir = fullfile(resultsPath, 'eigenfrequencies', 'csv');
    plotsDir = fullfile(resultsPath, 'eigenfrequencies', 'plots');
    
    % Ensure the plots directory exists
    if ~exist(plotsDir, 'dir')
        mkdir(plotsDir);
    end
    
    % Read inputs file
    inputsFile = readtable(fullfile(fullfile(resultsPath, 'inputs', 'csv'), 'inputs.csv'));
    
    % Call the readEigenFreq function to get eigenfrequencies and Ex values
    [eigenFrequencies, Ex_values] = readEigenFreq(eigenFreqDir, inputsFile);
    
    % Extract the first peak eigenfrequencies
    first_eigenfrequency = eigenFrequencies(1, :);
    
    % Plot: Frequency vs Longitudinal Stiffness
    plotFrequencyVsStiffness(Ex_values, first_eigenfrequency, ' ', resultsPath, 'Frequency_vs_Longitudinal_Stiffness.png');
    
    % Plot: Relative Variation of Eigenfrequencies
    plotRelativeVariationEigenfrequencies(eigenFrequencies, resultsPath, 'EigenFreq_Relative_Variation.png');
end
