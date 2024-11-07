function usedParams = selectLastSimulationParams(resultsPath, nSimulations, existingSimulations)
    % Function to store parameters from the last existing simulation
    usedParams = []; % Initialize an empty array to store parameters
    
    % Iterate through the simulations
    for sim = 1:nSimulations
        if existingSimulations(sim)
            % Construct the full path to the CSV file in the "inputs/csv" subfolder
            csvFileName = fullfile(resultsPath, 'inputs', 'csv', sprintf('inputs_sim%d.csv', sim));
            
            % Read and extract parameters from the CSV file using the function
            simParams = readSimulationParams(csvFileName);
            
            % Update usedParams with the parameters from the current simulation
            usedParams = simParams;
        end
    end
    usedParams = table2array(usedParams);
end
