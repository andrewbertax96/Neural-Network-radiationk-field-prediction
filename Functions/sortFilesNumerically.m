function sortedFiles = sortFilesNumerically(files, type)
% Helper function to sort files numerically based on their names
    if type == 1
        % Extract numbers from filenames
        fileNumbers = [];
        for i = 1:length(files)
            name = files(i).name;
            num = regexp(name, '\d+', 'match');
            if ~isempty(num)
                fileNumbers(i) = str2double(num{1});
            else
                fileNumbers(i) = NaN; % Assign NaN for files with no numbers
            end
        end
        
        % Sort files based on extracted numbers
        [~, sortOrder] = sort(fileNumbers);
        sortedFiles = files(sortOrder);
    end
    if type == 2
        % Extract numbers from filenames
        fileNumbers = [];
        for i = 1:length(files)
            name = files(i).name;
            num = regexp(name, '\d+', 'match');
            if ~isempty(num)
                fileNumbers(i) = str2double(num{1});
            else
                fileNumbers(i) = NaN; % Assign NaN for files with no numbers
            end
        end
        
        % Sort files based on extracted numbers
        [~, sortOrder] = sort(fileNumbers);
        sortedFiles = files(sortOrder);
    end
end
