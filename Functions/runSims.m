function runSims(model, nSimulations, nModes, existingSimulations, eigenFeature, eigenStudy, eigenFreqDataset, frequencyStudy, resultsPath, tStart, usedParams, dataset_centervals_EngelmannSpruce, std_devs, runFreqStudy)
   
    % Predefine material properties for Red Maple
    Ex_RedMaple = 12.43E9;  % Young's modulus in the x-direction
    Rho_RedMaple = 540;     % Density
    dataset_centervals_RedMaple = [Rho_RedMaple, Ex_RedMaple, 0.140 * Ex_RedMaple, 0.067 * Ex_RedMaple, 0.133 * Ex_RedMaple, 0.024 * Ex_RedMaple, 0.074 * Ex_RedMaple];
        
    % Iterate over each simulation in series
    for sim = 1:nSimulations
        if existingSimulations(sim)
            fprintf('Simulation %d already completed. Skipping...\n', sim);
            continue;  % Skip to the next iteration
        end
        
        fprintf('Simulation %d is running...\n', sim);
        
        % Initialize an empty structure for the dataset
        Dataset_FA = struct('inputs', [], 'outputsEig', [], 'outputsAmp_Fib', [], 'outputsAmp_Mer', []);
    
        % Generate and update simulation parameters
        paramsToUse = getParamsForSimulation(model, sim, usedParams, dataset_centervals_EngelmannSpruce, dataset_centervals_RedMaple, std_devs);
        usedParams = [usedParams; paramsToUse];

        % Update material properties in the model
        updateMaterialParameters(model, 'mat4', paramsToUse(1), paramsToUse(2:4), paramsToUse(5:7));

        % Run eigenfrequency study and store results
        runEigenfrequencyStudy(eigenFeature, eigenStudy, nModes);
        evalFreqz = mpheval(model, 'solid.freq', 'Dataset', eigenFreqDataset, 'edim', 0, 'selection', 1);
        currentEigenFrequencies = real(evalFreqz.d1);

        % Append current simulation results to the dataset
        Dataset_FA.inputs = paramsToUse;
        Dataset_FA.outputsEig = currentEigenFrequencies';

        % Run frequency study if required
        if runFreqStudy
            runFrequencyStudy(frequencyStudy, currentEigenFrequencies');
            [spl_Fib, spl_Mer] = processSimulationResults(model, resultsPath, sim);
            Dataset_FA.outputsAmp_Fib = spl_Fib;
            Dataset_FA.outputsAmp_Mer = spl_Mer;
        else
            Dataset_FA.outputsAmp_Fib = [];
            Dataset_FA.outputsAmp_Mer = [];
        end

        % Save results immediately after each simulation
        saveCSV(Dataset_FA, resultsPath, runFreqStudy, sim);

        % Display elapsed time for the current simulation
        fprintf(repmat('\b', 1, numel(sprintf('Simulation %d is running...\n', sim))));
        displayElapsedTime(tStart, sim);
        tStart = tic;  % Reset the timer for the next simulation
    end
end