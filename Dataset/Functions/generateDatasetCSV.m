function generateDatasetCSV(resultsPath, model, nSimulations, nModes, dataset_centervals_EngelmannSpruce, std_devs, runFreqStudy)
    % Define study and feature identifiers
    eigenStudyID = 'std1';
    eigenFeatureID = 'eig';
    frequencyStudyID = 'std3';
    eigenFreqDataset = 'dset1';

    % Access COMSOL study and feature references
    eigenStudy = model.study(eigenStudyID);
    eigenFeature = eigenStudy.feature(eigenFeatureID);
    frequencyStudy = model.study(frequencyStudyID);

     % Start the timer
    tStart = tic;
    
   % Parameters aggregation or default assignment
    existingSimulations = batchCheckExistingSimulations(resultsPath, nSimulations, runFreqStudy);

    % Call the function to aggregate simulation parameters
    usedParams = selectLastSimulationParams(resultsPath, nSimulations, existingSimulations);

    % If no previous simulations exist, use the default dataset
    if isempty(usedParams)
        usedParams = dataset_centervals_EngelmannSpruce;
    end

    % Run simulations
    runSims(model, nSimulations, nModes, existingSimulations, eigenFeature, eigenStudy, eigenFreqDataset, frequencyStudy, resultsPath, tStart, usedParams, dataset_centervals_EngelmannSpruce, std_devs, runFreqStudy);
    disp('All simulations are complete.');
end

