function Dataset_FA = runSimulations( model, nSimulations, nModes,eigenFeature, eigenStudy, eigenFreqDataset, frequencyStudy, resultsPath, Dataset_FA, tStart, usedParams, dataset_centervals_EngelmannSpruce, std_devs, runFreqStudy)
    % Function to run simulations, update parameters, and process results
    %
    % Inputs:
    %   nSimulations - Number of simulations to run
    %   model - Model object for simulation
    %   eigenFeature - Eigenfrequency feature object
    %   eigenStudy - Eigenfrequency study object
    %   nModes - Number of modes for eigenfrequency study
    %   frequencyStudy - Frequency study object
    %   resultsPath - Path to save simulation results
    %   Dataset_FA - Dataset to update with simulation results
    %   tStart - Initial timer for tracking elapsed time
    %   usedParams - Matrix to track used parameters
    %   dataset_centervals_EngelmannSpruce - Dataset for Engelmann Spruce
    %   dataset_centervals_RedMaple - Dataset for Red Maple

    eigenFrequencies = zeros(nModes, nSimulations); % Preallocate for eigenfrequencies
    Ex_RedMaple= 12.43E9; % Young's modulus in the x-direction Red Maple
    Rho_RedMaple = 540; % Density Red Maple
    dataset_centervals_RedMaple = [Rho_RedMaple, Ex_RedMaple, 0.140*Ex_RedMaple, 0.067*Ex_RedMaple, 0.133*Ex_RedMaple, 0.024*Ex_RedMaple, 0.074*Ex_RedMaple];
    usedParamsNew = usedParams;
    
    spl_Fib = [];
    spl_Mer = [];
    
    for sim = 1:nSimulations
        % Display the message indicating that the current simulation is running
        fprintf('Simulation %d is running...\n', sim);
        
        % Update parameters and run simulations
        paramsToUse = getParamsForSimulation(model, sim, usedParams, dataset_centervals_EngelmannSpruce, dataset_centervals_RedMaple, std_devs);
        usedParamsNew = [usedParamsNew; paramsToUse];

        updateMaterialParameters(model, 'mat4', paramsToUse(1), paramsToUse(2:4), paramsToUse(5:7)); %Update Engelmann Parameters
        runEigenfrequencyStudy(eigenFeature, eigenStudy, nModes);
        eigenFrequencies(:, sim) = getEigenFrequencies(model, eigenFreqDataset);

        if runFreqStudy
            % Configure and run frequency study
            runFrequencyStudy(frequencyStudy, eigenFrequencies(:, sim));

            % Export, import, and process results
            [spl_Fib, spl_Mer] = processSimulationResults(model, resultsPath, sim);
        end

        % Update Dataset
        Dataset_FA = updateDataset(Dataset_FA, sim, paramsToUse, spl_Fib, spl_Mer);
        
        % Clear the previous line of output and then display elapsed time
        fprintf(repmat('\b', 1, numel(sprintf('Simulation %d is running...\n', sim))));
    
        % Display elapsed time
        displayElapsedTime(tStart, sim);

        % Reset timer
        tStart = tic;
    end
    
    % Append eigenfrequencies to datasets
    Dataset_FA.outputsEig = [Dataset_FA.outputsEig; eigenFrequencies]; % Append eigenfrequencies for Fibonacci
end
