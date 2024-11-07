function tableData = processFile(filePath, type)
    % Load data from file
    data = load(filePath);

    % Create labels based on the file type
    numColumns = size(data, 2);
    if strcmp(type, 'fibonacci')
        columnLabels = cell(1, numColumns);
        columnLabels{1} = 'Freq_Hz';
        for i = 2:numColumns
            columnLabels{i} = sprintf('SPL_%d_dB', i-1);
        end
    elseif strcmp(type, 'meridian')
        columnLabels = cell(1, numColumns);
        columnLabels{1} = 'Freq_Hz';
        columnLabels{2} = 'SPL_NorthPole_dB';
        for i = 3:numColumns-1
            meridian_index = i - 2; % Adjusted index to start from 1
            block_number = ceil(meridian_index / 6); % Determine the block number
            block_position = mod(meridian_index - 1, 6) + 1; % Determine the position within the block
            columnLabels{i} = sprintf('SPL_M%d.%d_dB', block_number, block_position);
        end
        columnLabels{numColumns} = 'SPL_SouthPole_dB';
    else
        error('Unknown file type');
    end

    % Convert the dataset to a table with column labels
    tableData = array2table(data, 'VariableNames', columnLabels);
end
