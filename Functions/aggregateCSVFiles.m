function aggregateCSVFiles(resultsPath)
    csvDir = fullfile(resultsPath, 'inputs', 'csv');
    % Display the directory being checked
    % disp(['Full directory path: ' csvDir]);
    
    % Verify if the directory exists
    if exist(csvDir, 'dir')
        % disp(['Directory exists: ' csvDir]);
    else
        error('Directory does not exist: %s', csvDir);
    end
    
    % Get the list of CSV files in the directory, sorted by name
    csvFiles = dir(fullfile(csvDir, 'inputs_sim*.csv'));  % Pattern to match specific files
    
    % Sort files numerically based on their names
    csvFiles = sortFilesNumerically(csvFiles, 1);
    
    % Display the list of found and sorted CSV files
    if isempty(csvFiles)
        error('No CSV files matching the pattern found in the directory %s', csvDir);
    else
        % disp('Found and sorted CSV files:');
        % disp({csvFiles.name}); % Display the names of the sorted files
    end
    
    % Initialize a variable to store all the aggregated data
    aggregatedData = [];
    
    % Read each CSV file one by one and aggregate the data
    for i = 1:length(csvFiles)
        % Full path to the current CSV file
        csvFilePath = fullfile(csvDir, csvFiles(i).name);
        
        % Read the contents of the CSV file
        data = readtable(csvFilePath);
        
        % Ensure the file has at least one row
        if size(data, 1) < 1
            error('The file %s does not have enough rows', csvFiles(i).name);
        end
        
        % Extract the first row (the values)
        rowData = data{1, :};
        
        % Add the extracted row to the aggregated data matrix
        aggregatedData = [aggregatedData; rowData];
    end
    
    % Reconstruct the table with labels and aggregated data
    labels = data.Properties.VariableNames; % Use labels from the first file
    outputTable = array2table(aggregatedData, 'VariableNames', labels);
    
    % Full path to the output file
    outputFile = fullfile(csvDir, 'inputs.csv');
    
    % If an existing inputs.csv file is found, delete it
    if exist(outputFile, 'file')
        delete(outputFile);
        % disp(['Existing file deleted: ' outputFile]);
    end
    
    % Save the aggregated table in the inputs/csv directory
    writetable(outputTable, outputFile);
    
    % Display a message indicating where the file was saved
    % disp(['Aggregated file saved to: ' outputFile]);
end