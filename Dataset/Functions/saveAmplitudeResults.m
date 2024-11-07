function saveAmplitudeResults(amplitudeData, ampNames, resultsPath, outputFileName)
    % Preallocate and concatenate results vertically
    results = [];
    fields = fieldnames(amplitudeData);

    for i = 1:numel(fields)
        if isempty(results)
            results = amplitudeData.(fields{i});
        else
            results = [results; amplitudeData.(fields{i})];
        end
    end

    % Ensure column consistency
    if size(results, 2) ~= length(ampNames)
        error('The number of columns in results does not match the number of names in ampNames.');
    end

    % Save as table
    outputsAmpTable = array2table(results, 'VariableNames', ampNames);
    writetable(outputsAmpTable, fullfile(resultsPath, outputFileName));
end
