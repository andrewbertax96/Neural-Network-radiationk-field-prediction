function simParams = readSimulationParams(csvFileName)
    % Function to read and extract simulation parameters from a CSV file
    % Check if the CSV file exists
    if isfile(csvFileName)
        % Read the CSV file as a table
        simData = readtable(csvFileName);
        
        % Identify and extract numeric columns (assumed to be simulation parameters)
        numericColumns = varfun(@isnumeric, simData, 'OutputFormat', 'uniform');
        simParams = simData(:, numericColumns);
    else
        % Return an empty array if the file does not exist
        simParams = [];
    end
end