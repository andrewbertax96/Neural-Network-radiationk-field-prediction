function selectedDataset = selectOutputs(Dataset_FA, nOutputs, mode, runFreqStudy)
    % Function to select a subset of outputs from Dataset_FA
    %
    % Inputs:
    %   Dataset_FA  - Original dataset structure
    %   nOutputs    - Number of outputs (simulations) to include
    %   mode        - Selection mode: 'start', 'end', or 'random'
    %   runFreqStudy - Boolean to indicate if frequency study outputs should be included
    %
    % Output:
    %   selectedDataset - New dataset structure containing the selected outputs

    % Total number of simulations available
    totalSimulations = size(Dataset_FA.inputs, 1);
    
    % Validate nOutputs
    if nOutputs > totalSimulations
        error('Requested number of outputs exceeds available data.');
    end
    
    % Determine indices to select based on the specified mode
    switch lower(mode)
        case 'start'
            startIndex = 1;
            endIndex = nOutputs;
            indices = startIndex:endIndex;
        
        case 'end'
            startIndex = totalSimulations - nOutputs + 1;
            endIndex = totalSimulations;
            indices = startIndex:endIndex;
        
        case 'random'
            indices = randperm(totalSimulations, nOutputs);
        
        otherwise
            error('Invalid selection mode. Choose "start", "end", or "random".');
    end
    
    % Initialize the selected dataset structure
    selectedDataset = struct('inputs', [], 'outputsEig', [], 'outputsAmp_Fib', struct(), 'outputsAmp_Mer', struct());
    
    % Extract the selected inputs
    selectedDataset.inputs = Dataset_FA.inputs(indices, :);
    
    % Extract the selected eigenfrequencies
    selectedDataset.outputsEig = Dataset_FA.outputsEig(:, indices);
    
    if runFreqStudy
        % Extract the selected SPL data for Fibonacci Distribution
        fibFields = fieldnames(Dataset_FA.outputsAmp_Fib);
        for i = 1:nOutputs
            fieldName = fibFields{indices(i)};
            selectedDataset.outputsAmp_Fib.(fieldName) = Dataset_FA.outputsAmp_Fib.(fieldName);
        end

        % Extract the selected SPL data for Meridional material
        merFields = fieldnames(Dataset_FA.outputsAmp_Mer);
        for i = 1:nOutputs
            fieldName = merFields{indices(i)};
            selectedDataset.outputsAmp_Mer.(fieldName) = Dataset_FA.outputsAmp_Mer.(fieldName);
        end
    end
end