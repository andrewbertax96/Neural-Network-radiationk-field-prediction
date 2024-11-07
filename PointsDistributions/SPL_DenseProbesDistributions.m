%% BASE SETUP
clear all;
clc;

% import com.comsol.model.*;
% import com.comsol.model.util.*;

% Define base working directory and paths
baseFolder = 'C:\Users\andre\OneDrive - Politecnico di Milano\TESI'; % base working directory
datasetDir = 'PointsDistributions'; 
resultsDir = fullfile(datasetDir, 'Results'); 

% Full paths for dataset and results
datasetPath = fullfile(baseFolder, datasetDir); 
resultsPath = fullfile(baseFolder, resultsDir); 

% Create results directory if it doesn't exist
if ~exist(resultsPath, 'dir')
    mkdir(resultsPath);
end

% Add dataset path to MATLAB search path
addpath(datasetPath);

% Define the functions folder and add it to the MATLAB path
functionsFolder = fullfile(datasetPath, 'Functions');
addpath(functionsFolder);

% Change directory to the dataset path
cd(datasetPath);

%% GENERATE COORDINATES

% Generate Fibonacci sphere points
samples = 60;
radius = 300;
center = [0, 0, -36];

fibonacci_points = generateFibonacciPoints(samples, radius, center);

% Display Fibonacci coordinates with labels
fibonacci_table = array2table(fibonacci_points, 'VariableNames', {'x', 'y', 'z'});
disp('Fibonacci coordinates = ')
disp(fibonacci_table)

% Generate meridian points
num_meridians = 10;
points_per_meridian = 6;

meridian_points = generateMeridianPoints(num_meridians, points_per_meridian, radius, center);

% Display meridian coordinates with labels
meridian_table = array2table(meridian_points, 'VariableNames', {'x', 'y', 'z'});
disp('Meridian coordinates = ')
disp(meridian_table)

%% IMPORT FILES

% Define directories for meridians and fibonacci within resultsPath
directoryMeridians = fullfile(resultsPath, 'Meridians');
directoryFibonacci = fullfile(resultsPath, 'Fibonacci');

% Define the file names
file1 = 'SPL-DenseMeridianProbesDistribution.dat';
file2 = 'SPL-DenseFibonacciProbesDistribution.dat';

% Create full paths to the files
filePath1 = fullfile(directoryMeridians, file1);
filePath2 = fullfile(directoryFibonacci, file2);

% Read and process data from the files
SPL_DenseMeridianProbesDistribution = processFile(filePath1, 'meridian');
SPL_DenseFibonacciProbesDistribution = processFile(filePath2, 'fibonacci');

% Display the first 5 elements of each table for verification
disp('First 5 elements of SPL-DenseFibonacciProbesDistribution:');
disp(SPL_DenseFibonacciProbesDistribution(1:5, :));

disp('First 5 elements of SPL-DenseMeridianProbesDistribution:');
disp(SPL_DenseMeridianProbesDistribution(1:5, :));

% Optional: Save the data to a MAT file for faster future access
save(fullfile(resultsPath, 'ImportedData.mat'), 'SPL_DenseMeridianProbesDistribution', 'SPL_DenseFibonacciProbesDistribution');

%% SURF PLOTS 
% PARAMETERS
num_figures = height(SPL_DenseFibonacciProbesDistribution); % Total number of plots is equal to the number of eigenfrequencies

% Creating the sphere mesh for plotting
[phi_mesh, theta_mesh, x_mesh, y_mesh, z_mesh] = createSphereMesh(radius, center);

% Plotting for Fibonacci Distribution
plotAndSaveSurf(x_mesh, y_mesh, z_mesh, SPL_DenseFibonacciProbesDistribution, fibonacci_points, 1, 'Fibonacci');

% Plotting for Meridian Distribution
plotAndSaveSurf(x_mesh, y_mesh, z_mesh, SPL_DenseMeridianProbesDistribution, meridian_points, 1, 'Meridians');

%% MATRIX PLOTS

% MATRIX PLOT FIBONACCI

% Extract Fibonacci distribution data
fibonacci_data = table2array(SPL_DenseFibonacciProbesDistribution(:, 2:end));
frequencies = SPL_DenseFibonacciProbesDistribution.Freq_Hz;

% Subtract the mean from each row
fibonacci_data_mean_subtracted = fibonacci_data - mean(fibonacci_data, 2);

% Plot and save heatmap with original Fibonacci data
plotAndSaveHeatmap(fibonacci_data, frequencies, 'Fibonacci', ...
    'Matrix_Plot_SPL_values_Fibonacci.png', ...
    'Frequency (Hz)');

% Plot and save heatmap with mean-subtracted Fibonacci data
plotAndSaveHeatmap(fibonacci_data_mean_subtracted, frequencies, 'Fibonacci', ...
    'Matrix_Plot_SPL_values_Fibonacci_Mean_Subtracted.png', ...
    'Frequency (Hz)');

% MATRIX PLOT MERIDIANS

% Extract meridian distribution data
meridian_data = table2array(SPL_DenseMeridianProbesDistribution(:, 2:end));
frequencies_meridian = SPL_DenseMeridianProbesDistribution.Freq_Hz;

% Subtract the mean from each row
meridian_data_mean_subtracted = meridian_data - mean(meridian_data, 2);

% Define custom x-axis labels
meridian_labels = {'NorthPole', 'M1.1', 'M1.2', 'M1.3', 'M1.4', 'M1.5', 'M1.6', ...
    'M2.1', 'M2.2', 'M2.3', 'M2.4', 'M2.5', 'M2.6', ...
    'M3.1', 'M3.2', 'M3.3', 'M3.4', 'M3.5', 'M3.6', ...
    'M4.1', 'M4.2', 'M4.3', 'M4.4', 'M4.5', 'M4.6', ...
    'M5.1', 'M5.2', 'M5.3', 'M5.4', 'M5.5', 'M5.6', ...
    'M6.1', 'M6.2', 'M6.3', 'M6.4', 'M6.5', 'M6.6', ...
    'M7.1', 'M7.2', 'M7.3', 'M7.4', 'M7.5', 'M7.6', ...
    'M8.1', 'M8.2', 'M8.3', 'M8.4', 'M8.5', 'M8.6', ...
    'M9.1', 'M9.2', 'M9.3', 'M9.4', 'M9.5', 'M9.6', ...
    'M10.1', 'M10.2', 'M10.3', 'M10.4', 'M10.5', 'M10.6', ...
    'SouthPole'};

% Plot and save heatmap with original meridian data
plotAndSaveHeatmap(meridian_data, frequencies_meridian, 'Meridians', ...
    'Matrix_Plot_SPL_values_Meridians.png', ...
    'Frequency (Hz)', meridian_labels);

% Plot and save heatmap with mean-subtracted meridian data
plotAndSaveHeatmap(meridian_data_mean_subtracted, frequencies_meridian, 'Meridians', ...
    'Matrix_Plot_SPL_values_Meridians_Mean_Subtracted.png', ...
    'Frequency (Hz)', meridian_labels);