function plotRelativeVariationEigenfrequencies(eigenFrequencies, resultsPath, filename)
    % Create the 'plot' directory inside the 'results' folder if it doesn't exist
    plotFolderPath = fullfile(resultsPath, 'eigenfrequencies', 'plots');
    if ~exist(plotFolderPath, 'dir')
        mkdir(plotFolderPath);
    end

    [nModes, ~] = size(eigenFrequencies);
    figure;
    hold on;

    % Compute relative variation
    referenceEigenFrequencies = eigenFrequencies(:, 1); % Eigenfrequencies of the first simulation
    relativeVariationEig = ((eigenFrequencies - referenceEigenFrequencies) ./ referenceEigenFrequencies) * 100; % In percentage

    % Find the simulations with the maximum positive and maximum negative variation
    [maxVal, maxSim] = max(max(relativeVariationEig, [], 1)); % Simulation with maximum positive variation
    [minVal, minSim] = min(min(relativeVariationEig, [], 1)); % Simulation with maximum negative variation

    % Plot the simulation with maximum positive variation
    plot(1:nModes, relativeVariationEig(:, maxSim), 'LineStyle', '-', 'Marker', 'o', ...
         'Color', 'r', 'DisplayName', sprintf('Max Variation (Sim %d): %.2f%%', maxSim, maxVal));

    % Plot the simulation with maximum negative variation
    plot(1:nModes, relativeVariationEig(:, minSim), 'LineStyle', '-', 'Marker', 'o', ...
         'Color', 'b', 'DisplayName', sprintf('Max Negative Variation (Sim %d): %.2f%%', minSim, minVal));

    % Add a horizontal line at 0% relative variation
    yline(0, '--k', 'LineWidth', 1.5, 'DisplayName', 'Centervals');

    % Add labels and title
    xlabel('N° Mode');
    ylabel('Relative Variation [%]');
    % title('Relative Variation of Eigenfrequencies');
    grid on;

    % Add legend
    legend show;

    hold off;

    % Save the plot in the 'plot' directory
    saveas(gcf, fullfile(plotFolderPath, filename));
end