%% BASE SETUP
clear all;
clc;

import com.comsol.model.*;
import com.comsol.model.util.*;

% Define base working directory and paths
% baseFolder = 'D:\Andres Bertazzi\ArchtopGuitarThickness'; % base working directory
baseFolder = 'C:\Users\andre\OneDrive - Politecnico di Milano\TESI';

% Dataset and results directories
datasetDir = 'Dataset'; 
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

% Return to base folder
cd(datasetPath);

%% DEFINE PARAMETERS 

% Parameters of the dataset
Ex_EngelmannSpruce = 9.79E9; % Young's modulus in the x-direction Engelmann
Rho_EngelmannSpruce = 350; % Density Engelmann

% Center values and standard deviations
dataset_centervals_EngelmannSpruce = [Rho_EngelmannSpruce, Ex_EngelmannSpruce, Ex_EngelmannSpruce*0.128, Ex_EngelmannSpruce*0.059, Ex_EngelmannSpruce*0.124, Ex_EngelmannSpruce*0.01, Ex_EngelmannSpruce*0.12];
std_devs = [0.1, 0.25 * ones(1, numel(dataset_centervals_EngelmannSpruce) - 1)];

%% LOAD THE MODEL

% Load the COMSOL model using MATLAB LiveLink for COMSOL
comsolModel = '..\FRF-SPL-Dense_airENABLED_FibMer.mph'; % Specify the COMSOL model filename
model = mphopen(comsolModel); % Open the COMSOL model

%% SET THE SIMULATIONS 
% Ask the user to input the number of simulations
nSimulations = input('Enter the number of simulations you want to run: ');

% Validate the input
if ~isnumeric(nSimulations) || nSimulations <= 0 || mod(nSimulations, 1) ~= 0
    error('Invalid input. Please enter a positive integer.');
end

% Number of modes to compute in the eigenfrequency study
nModes = 40; 

% Ask the user if they want to run the frequency study
userInput = input('Do you want to run the frequency study? (yes/no): ', 's');

% Set runFreqStudy based on the user's response
if strcmpi(userInput, 'yes')
    runFreqStudy = true;
else
    runFreqStudy = false;
end

%% GENERATE THE DATASET CSVs
generateDatasetCSV(resultsPath, model, nSimulations, nModes, dataset_centervals_EngelmannSpruce, std_devs, runFreqStudy);

%% PLOT INPUTS
plotInputs(resultsPath);

%% PLOT EIGENFREQUENCIES
plotEigenfrequencies(resultsPath);

%% PLOT SPL OUTPUTS

warning('off', 'all'); % Disabilitate warnings
plotSPL(resultsPath, 'fibonacci', true); %set to true to plot also the heatmap with mean subtraction
plotSPL(resultsPath, 'meridians', true);  %set to true to plot also the heatmap with mean subtraction
