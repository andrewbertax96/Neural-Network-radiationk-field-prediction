function paramsToUse = generateUniqueParams(usedParams, centerValues, stdDevs)
    % Define specific upper and lower bounds for density
    Rho = centerValues(1);
    upperBoundRho = Rho + 100;
    lowerBoundRho = Rho - 70;

    % Define general upper and lower bounds for other parameters
    upperBounds = 2 * centerValues; % Values should not exceed twice the centroid values
    lowerBounds = centerValues / 2; % Values should not be less than half of the centroid values

    % Loop until a unique set of parameters is found
    while true
        % Generate Gaussian-distributed parameters
        paramsToUse = gaussianDistribution(centerValues, stdDevs);
        
        % Apply boundaries to ensure parameters are within the defined limits
        paramsToUse = setBoundaries(paramsToUse, upperBounds, lowerBounds, upperBoundRho, lowerBoundRho);
        
        % Check for uniqueness
        if ~any(all(ismember(usedParams, paramsToUse, 'rows'), 2))
             % Generate Gaussian-distributed parameters
            paramsToUse = gaussianDistribution(centerValues, stdDevs);
            % Apply boundaries to ensure parameters are within the defined limits
            paramsToUse = setBoundaries(paramsToUse, upperBounds, lowerBounds, upperBoundRho, lowerBoundRho);
            return;
        end
    end
end