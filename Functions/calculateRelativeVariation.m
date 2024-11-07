function relativeVariation = calculateRelativeVariation(inputsArray)
%     [nParams, nSimulations] = size(inputsArray);
    referenceValues = inputsArray(1, :); % Values of the first simulation
    relativeVariation = ((inputsArray - referenceValues) ./ referenceValues) * 100; % In percentage
end
% relativeChanges = (usedParams - usedParams(1, :)) ./ usedParams(1, :) * 100; % Compute percentage changes