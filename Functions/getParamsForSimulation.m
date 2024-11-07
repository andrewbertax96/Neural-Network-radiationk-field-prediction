function paramsToUse = getParamsForSimulation(model, sim, usedParams, centerVals, redMapleVals, std_devs)
    if sim == 1
        paramsToUse = centerVals;
        updateMaterialParameters(model, 'mat6', redMapleVals(1), redMapleVals(2:4), redMapleVals(5:7)); %Set RedMaple Metarial Parameters to default
    else
        paramsToUse = generateUniqueParams(usedParams, centerVals, std_devs);
    end
end