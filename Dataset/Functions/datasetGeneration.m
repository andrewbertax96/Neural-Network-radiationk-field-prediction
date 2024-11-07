function Dataset_FA = datasetGeneration(resultsPath, model, nSimulations, nModes, dataset_centervals_EngelmannSpruce, std_devs, runFreqStudy)

    % Define study and feature identifiers
    eigenStudyID = 'std1';
    eigenFeatureID = 'eig';
    frequencyStudyID = 'std3';
    eigenFreqDataset = 'dset1';

    % Access COMSOL study and feature references
    eigenStudy = model.study(eigenStudyID);
    eigenFeature = eigenStudy.feature(eigenFeatureID);
    frequencyStudy = model.study(frequencyStudyID);

    % Initialize dataset structure
    Dataset_FA = struct('inputs', [], 'outputsEig', [], 'outputsAmp_Fib', struct(), 'outputsAmp_Mer', struct());

    % Start the timer
    tStart = tic;
    usedParams = dataset_centervals_EngelmannSpruce;
    
    % Run simulations
    Dataset_FA = runSimulations( model, nSimulations, nModes,eigenFeature, eigenStudy, eigenFreqDataset, frequencyStudy, resultsPath, Dataset_FA, tStart, usedParams, dataset_centervals_EngelmannSpruce, std_devs, runFreqStudy);
    disp('All simulations are complete.');
end