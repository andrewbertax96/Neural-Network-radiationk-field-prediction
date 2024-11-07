function paramsToUse = setBoundaries(paramsToUse, upperBounds, lowerBounds, upperBoundRho, lowerBoundRho)
    % Apply boundaries to density (rho)
    paramsToUse(1) = max(min(paramsToUse(1), upperBoundRho), lowerBoundRho);
    
    % Apply boundaries to Young's moduli (Ex, Ey, Ez)
    paramsToUse(2:4) = max(min(paramsToUse(2:4), upperBounds(2:4)), lowerBounds(2:4));
    
    % Apply boundaries to shear moduli (Gxy, Gyz, Gxz)
    paramsToUse(5:7) = max(min(paramsToUse(5:7), upperBounds(5:7)), lowerBounds(5:7));
end
