function data = readAndCleanData(filePath)
    data = readmatrix(filePath);
    if isfile(filePath)
        delete(filePath);
    else
        warning('File %s non trovato per la cancellazione.', filePath);
    end
    data = data(:, 2:end); % Remove the first column
end