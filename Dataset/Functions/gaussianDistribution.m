function paramsToUse = gaussianDistribution(centerValues, stdDevs)
    % Generate Gaussian-distributed parameters
    gaussRealization = randn(size(centerValues));
    delta = stdDevs .* gaussRealization;
    paramsToUse = centerValues .* (1 + delta);
end
