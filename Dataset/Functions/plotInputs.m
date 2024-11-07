function plotInputs(resultsPath)
    % Aggregate CSV files into a single inputs.csv
    aggregateCSVFiles(resultsPath);
    
    % Define the full path to the inputs.csv file
    inputsFile = fullfile(fullfile(resultsPath, 'inputs', 'csv'), 'inputs.csv');

    % Read the table from inputs.csv
    inputsTable = readtable(inputsFile);
    
    % Display the table if it has 10 or fewer rows
    if size(inputsTable, 1) <= 10
        disp('--- Inputs Parameters Table ---');
        disp(inputsTable);
    end
    
    % Convert the table to an array
    inputsArray = table2array(inputsTable);
    
    % Calculate relative variation
    relativeVariation = calculateRelativeVariation(inputsArray);
    
    % Define output filenames for the histograms
    rhoHistFilename = 'Rho_Distributions.png';
    exEyEzHistFilename = 'Ex_Ey_Ez_Distributions.png';
    gxyGyzGxzHistFilename = 'Gxy_Gyz_Gxz_Distributions.png';
    
    % Get parameter names from the table for plotting
    inputParamsNames = inputsTable.Properties.VariableNames;
    
    % Plot Histograms
    plotHistograms(resultsPath, inputsArray, relativeVariation, inputParamsNames, ...
                   rhoHistFilename, ...
                   exEyEzHistFilename, ...
                   gxyGyzGxzHistFilename);
end
