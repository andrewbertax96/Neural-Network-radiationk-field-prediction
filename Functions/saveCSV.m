function saveCSV(Dataset_FA, resultsPath, runFreqStudy, nSim)
    
    inputsPath = fullfile(resultsPath, 'inputs', 'csv');
    eigenFreqPath = fullfile(resultsPath, 'eigenfrequencies', 'csv');
    SPLFib_Path = fullfile(resultsPath, 'SPL(dB)', 'Fibonacci');
    SPLMer_Path = fullfile(resultsPath, 'SPL(dB)', 'Meridians');

    
    % Save input parameters
    inputParamsNames = {'rho', 'Ex', 'Ey', 'Ez', 'Gxy', 'Gyz', 'Gxz'};
    inputsTable = array2table(Dataset_FA.inputs, 'VariableNames', inputParamsNames);
    filename = sprintf('inputs_sim%d.csv', nSim);
    writetable(inputsTable, fullfile(inputsPath, filename));
    
    % Save Eigenfrequencies
    eigenFreqLabels = {sprintf('Freq(Hz)_sim%d', nSim)};
    outputsEigTable = array2table(Dataset_FA.outputsEig', 'VariableNames', eigenFreqLabels); % Transpose to match rows to simulations
    filename = sprintf('eigenFreq_sim%d.csv', nSim);
    writetable(outputsEigTable, fullfile(eigenFreqPath, filename));

    if runFreqStudy
        % Generate amplitude names
        [ampNamesFib, ampNamesMer] = generateAmpNames();
        
        % Save as table
        outputsAmpTable = array2table(Dataset_FA.outputsAmp_Fib, 'VariableNames', ampNamesFib);
        filename = sprintf('ampsFib_sim%d.csv', nSim);
        writetable(outputsAmpTable, fullfile(SPLFib_Path, filename));
        
        outputsAmpTable = array2table(Dataset_FA.outputsAmp_Mer, 'VariableNames', ampNamesMer);
        filename = sprintf('ampsMer_sim%d.csv', nSim);
        writetable(outputsAmpTable, fullfile(SPLMer_Path, filename));
    end

end