function [eigenFrequencies, Ex_values] = readEigenFreq(eigenFreqDir, inputsFile)
    
    % Check if inputsFile is provided and not empty
    if nargin > 1 && ~isempty(inputsFile)
        % Extract Ex values from the provided inputsFile
        Ex_values = inputsFile.Ex;
    else
        % If inputsFile is not provided or empty, set Ex_values to an empty array
        Ex_values = [];
    end
    
    % Get the list of CSV files in the directory, sorted by simulation number
    csvFiles = dir(fullfile(eigenFreqDir, 'eigenFreq_sim*.csv'));
    csvFiles = sortFilesNumerically(csvFiles, 2); % Sort files numerically
    
    % Initialize matrix to store eigenfrequencies
    numSimulations = length(csvFiles);
    eigenFrequencies = NaN(40, numSimulations); % 40 rows, number of simulations columns
    
    % Read each CSV file and aggregate the data
    for i = 1:numSimulations
        % Full path to the current CSV file
        csvFilePath = fullfile(eigenFreqDir, csvFiles(i).name);
        
        % Read the contents of the CSV file
        data = readtable(csvFilePath);
        
        % Ensure the file has 40 rows
        if height(data) ~= 40
            error('The file %s does not have 40 rows.', csvFiles(i).name);
        end
        
        % Extract the eigenfrequency data and store it in the matrix
        eigenFrequencies(:, i) = data{:, 1};
    end
end
