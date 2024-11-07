function Dataset_FA = updateDataset(Dataset_FA, simIndex, paramsToUse, spl_Fib, spl_Mer)
    % Update the Dataset_FA structure with new simulation results.
    %
    % Inputs:
    %   Dataset_FA - The dataset structure to be updated
    %   simIndex - Index of the simulation
    %   paramsToUse - Parameters used for the simulation
    %   spl_Fib - SPL values for Fibrous material
    %   spl_Mer - SPL values for Meridional material
    %   eigenFrequencies - Eigenfrequencies from the simulation

    % Append new parameters to the inputs field
    Dataset_FA.inputs = [Dataset_FA.inputs; paramsToUse];

    % Create dynamic field names for SPL values
    fibFieldName = sprintf('sim%d', simIndex);
    merFieldName = sprintf('sim%d', simIndex);

     % Check if spl_Fib is not empty before adding it to Dataset_FA
    if ~isempty(spl_Fib)
        % Add the spl_Fib values to the corresponding dynamic field
        Dataset_FA.outputsAmp_Fib.(fibFieldName) = spl_Fib;
    end

    % Check if spl_Mer is not empty before adding it to Dataset_FA
    if ~isempty(spl_Mer)
        % Add the spl_Mer values to the corresponding dynamic field
        Dataset_FA.outputsAmp_Mer.(merFieldName) = spl_Mer;
    end
end
