function plotHistograms(resultsPath, inputsArray, relativeVariation, inputParamsNames, rhoFilename, exEzFilename, gxyGyzGxzFilename)
    % Create the 'plot' directory inside the 'results' folder if it doesn't exist
    plotFolderPath = fullfile(resultsPath, 'inputs', 'plots');
    if ~exist(plotFolderPath, 'dir')
        mkdir(plotFolderPath);
    end
    
    numParams = size(inputsArray, 2);

    % Plot histograms for rho
    figure;
    subplot(2, 1, 1);
    histogram(inputsArray(:, 1), 'BinMethod', 'auto', 'FaceColor', [0 0 1]);
    xlabel('\rho [kg / m^3]'); % Using a fraction for the unit
    ylabel('Count');

    subplot(2, 1, 2);
    histogram(relativeVariation(:, 1), 'BinMethod', 'auto', 'FaceColor', [0 1 0]);
    xlabel('Relative variation in \rho [%]'); % Using LaTeX for rho
    ylabel('Count');
    % Save the plot in the 'plot' directory
    saveas(gcf, fullfile(plotFolderPath, rhoFilename));
    

    % Plot histograms for Ex, Ey, Ez
    figure;
    params_indices = 2:4;
    for i = 1:length(params_indices)
        idx = params_indices(i);
        paramName = inputParamsNames{idx};
        if strcmp(paramName, 'Ex')
            formattedName = 'E_x';
        elseif strcmp(paramName, 'Ey')
            formattedName = 'E_y';
        elseif strcmp(paramName, 'Ez')
            formattedName = 'E_z';
        else
            formattedName = paramName; % For other names
        end

        subplot(3, 2, (i-1)*2 + 1);
        histogram(inputsArray(:, idx), 'BinMethod', 'auto', 'FaceColor', [0 0 1]);
        xlabel([formattedName, ' [GPa]']);
        ylabel('Count');

        subplot(3, 2, (i-1)*2 + 2);
        histogram(relativeVariation(:, idx), 'BinMethod', 'auto', 'FaceColor', [0 1 0]);
        xlabel(['Relative variation in ', formattedName, ' [%]']);
        ylabel('Count');
    end
    % Save the plot in the 'plot' directory
    saveas(gcf, fullfile(plotFolderPath, exEzFilename));

    % Plot histograms for Gxy, Gyz, Gxz
    figure;
    params_indices = 5:7;
    for i = 1:length(params_indices)
        idx = params_indices(i);
        paramName = inputParamsNames{idx};
        if strcmp(paramName, 'Gxy')
            formattedName = 'G_{xy}';
        elseif strcmp(paramName, 'Gyz')
            formattedName = 'G_{yz}';
        elseif strcmp(paramName, 'Gxz')
            formattedName = 'G_{xz}';
        else
            formattedName = paramName; % For other names
        end

        subplot(3, 2, (i-1)*2 + 1);
        histogram(inputsArray(:, idx), 'BinMethod', 'auto', 'FaceColor', [0 0 1]);
        xlabel([formattedName, ' [GPa]']);
        ylabel('Count');

        subplot(3, 2, (i-1)*2 + 2);
        histogram(relativeVariation(:, idx), 'BinMethod', 'auto', 'FaceColor', [0 1 0]);
        xlabel(['Relative variation in ', formattedName, ' [%]']);
        ylabel('Count');
    end
    % Save the plot in the 'plot' directory
    saveas(gcf, fullfile(plotFolderPath, gxyGyzGxzFilename));
end
