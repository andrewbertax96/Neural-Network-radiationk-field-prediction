function plotDataset(resultsPath, runFreqStudy, selected, mode)

    % Determine file suffix based on whether selection mode is active
    if selected
        suffix = sprintf('_%s', mode);
    else
        suffix = '';
    end

    % Load the data tables
    inputsTable = readtable(fullfile(resultsPath, ['inputs', suffix, '.csv']));
    outputsEigTable = readtable(fullfile(resultsPath, ['outputsEig', suffix, '.csv']));

    % Display tables if there are 10 or fewer simulations
    if size(inputsTable, 1) <= 10
        disp('--- Inputs Parameters Table ---');
        disp(inputsTable);
        
        disp('--- Eigenfrequencies Table ---');
        disp(outputsEigTable);
        
        if runFreqStudy
            outputAmp_Fib_table = readtable(fullfile(resultsPath, ['outputsAmp_Fib', suffix, '.csv']));
            outputAmp_Mer_table = readtable(fullfile(resultsPath, ['outputsAmp_Mer', suffix, '.csv']));
            
            disp('--- Outputs Amplitude Table (Fibonacci) ---');
            disp(outputAmp_Fib_table);
            
            disp('--- Outputs Amplitude Table (Meridional) ---');
            disp(outputAmp_Mer_table);
        end
    end

    % Extract relevant data
    Ex_values = inputsTable.Ex; % Extract Ex values
    first_eigenfrequency = outputsEigTable{1, :}; % Extract the first eigenfrequency

    % Plot: Frequency vs Longitudinal Stiffness
    plotFrequencyVsStiffness(Ex_values, first_eigenfrequency, ' ', resultsPath, ['Frequency_vs_Longitudinal_Stiffness', suffix, '.png']);

    % Convert tables to arrays for further processing
    eigenFrequencies = table2array(outputsEigTable);
    inputsArray = table2array(inputsTable);

    % Calculate relative variation
    relativeVariation = calculateRelativeVariation(inputsArray);

    % Plot: Relative Variation of Eigenfrequencies
    plotRelativeVariationEigenfrequencies(eigenFrequencies, resultsPath, ['EigenFreq_Relative_Variation', suffix, '.png']);

    % Plot Histograms
    inputParamsNames = inputsTable.Properties.VariableNames;
    plotHistograms(resultsPath, inputsArray, relativeVariation, inputParamsNames, ...
                   ['Rho_Distributions', suffix, '.png'], ...
                   ['Ex_Ey_Ez_Distributions', suffix, '.png'], ...
                   ['Gxy_Gyz_Gxz_Distributions', suffix, '.png']);
end