function [ampNamesFib, ampNamesMer] = generateAmpNames()

    % Number of points for Fibonacci and Meridian
    numFibPoints = 60;
    numMerPoints = 62;

    % Generate Fibonacci amplitude names
    ampNamesFib = strcat('SPL(dB)_', string(1:numFibPoints), '°point');

    % Initialize the Meridian amplitude names
    ampNamesMer = cell(1, numMerPoints);

    % Assign label for the North Pole
    ampNamesMer{1} = 'SPL(dB)_NorthPole';

    % Generate labels for Meridian points
    for i = 2:numMerPoints-1
        meridian_index = i - 1; % Adjusted index to start from 1
        block_number = ceil(meridian_index / 6); % Determine the block number
        block_position = mod(meridian_index - 1, 6) + 1; % Determine the position within the block
        ampNamesMer{i} = sprintf('SPL(dB)_M%d.%d', block_number, block_position);
    end

    % Assign label for the South Pole
    ampNamesMer{numMerPoints} = 'SPL(dB)_SouthPole';

    % Convert the cell array to a string array
    ampNamesMer = string(ampNamesMer);
end
