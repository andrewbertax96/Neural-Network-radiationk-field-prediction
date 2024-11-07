function existingSimulations = batchCheckExistingSimulations(resultsPath, nSimulations, runFreqStudy)
    % Initialize a logical array to track existing simulations
    existingSimulations = false(1, nSimulations);
    
    % Define paths for files
    inputsPath = fullfile(resultsPath, 'inputs', 'csv');
    eigenFreqPath = fullfile(resultsPath, 'eigenfrequencies', 'csv');
    SPLFib_Path = fullfile(resultsPath, 'SPL(dB)', 'Fibonacci');
    SPLMer_Path = fullfile(resultsPath, 'SPL(dB)', 'Meridians');
    
    % List files in the directories
    inputFiles = dir(fullfile(inputsPath, 'inputs_sim*.csv'));
    eigenFreqFiles = dir(fullfile(eigenFreqPath, 'eigenFreq_sim*.csv'));
    splFibFiles = [];
    splMerFiles = [];
    
    if runFreqStudy
        splFibFiles = dir(fullfile(SPLFib_Path, 'ampsFib_sim*.csv'));
        splMerFiles = dir(fullfile(SPLMer_Path, 'ampsMer_sim*.csv'));
    end
    
    % Extract simulation numbers from file names
    inputSims = extractSimulationNumbers({inputFiles.name}, 'inputs_sim(\d+)\.csv');
    eigenFreqSims = extractSimulationNumbers({eigenFreqFiles.name}, 'eigenFreq_sim(\d+)\.csv');
    splFibSims = [];
    splMerSims = [];
    
    if runFreqStudy
        splFibSims = extractSimulationNumbers({splFibFiles.name}, 'ampsFib_sim(\d+)\.csv');
        splMerSims = extractSimulationNumbers({splMerFiles.name}, 'ampsMer_sim(\d+)\.csv');
    end
    
    % Determine which simulations are complete
    for sim = 1:nSimulations
        if ismember(sim, inputSims) && ismember(sim, eigenFreqSims) && ...
           (~runFreqStudy || (ismember(sim, splFibSims) && ismember(sim, splMerSims)))
            existingSimulations(sim) = true;
        end
    end
end

function simNumbers = extractSimulationNumbers(fileNames, pattern)
    % Extract simulation numbers from file names using a pattern
    simNumbers = [];
    for k = 1:numel(fileNames)
        % Extract the simulation number from the file name using regular expressions
        tokens = regexp(fileNames{k}, pattern, 'tokens');
        if ~isempty(tokens)
            % Convert the extracted number to a numeric value
            simNumber = str2double(tokens{1}{1});
            simNumbers = [simNumbers, simNumber]; % Append to result
        end
    end
    % Remove duplicate numbers and sort
    simNumbers = unique(simNumbers);
end
