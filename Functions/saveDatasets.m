function saveDatasets(Dataset_FA, resultsPath, runFreqStudy, selected, mode)
    
    % Save input parameters
    inputParamsNames = {'rho', 'Ex', 'Ey', 'Ez', 'Gxy', 'Gyz', 'Gxz'};
    inputsTable = array2table(Dataset_FA.inputs, 'VariableNames', inputParamsNames);
    
    if selected
        % Modify file names if selection mode is used
        inputFileName = sprintf('inputs_%s.csv', mode);
        eigFileName = sprintf('outputsEig_%s.csv', mode);
        fibFileName = sprintf('outputsAmp_Fib_%s.csv', mode);
        merFileName = sprintf('outputsAmp_Mer_%s.csv', mode);
    else
        % Default file names
        inputFileName = 'inputs.csv';
        eigFileName = 'outputsEig.csv';
        fibFileName = 'outputsAmp_Fib.csv';
        merFileName = 'outputsAmp_Mer.csv';
    end
    
    % Save inputs and eigenfrequencies
    writetable(inputsTable, fullfile(resultsPath, inputFileName));

    eigenFreqLabels = arrayfun(@(x) sprintf('Freq(Hz)_%d°Sim', x), 1:size(Dataset_FA.outputsEig, 2), 'UniformOutput', false);
    outputsEigTable = array2table(Dataset_FA.outputsEig, 'VariableNames', eigenFreqLabels);
    writetable(outputsEigTable, fullfile(resultsPath, eigFileName));

    if runFreqStudy
        % Generate amplitude names
        [ampNamesFib, ampNamesMer] = generateAmpNames();

        % Concatenate and save results for Fibrous and Meridional materials
        saveAmplitudeResults(Dataset_FA.outputsAmp_Fib, ampNamesFib, resultsPath, fibFileName);
        saveAmplitudeResults(Dataset_FA.outputsAmp_Mer, ampNamesMer, resultsPath, merFileName);
    end
end