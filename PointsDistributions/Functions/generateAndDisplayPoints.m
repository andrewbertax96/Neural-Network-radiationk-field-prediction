function points = generateAndDisplayPoints(generatorFunction, varargin)
    % Generate points using the specified function and display them
    points = generatorFunction(varargin{:});
    point_table = array2table(points, 'VariableNames', {'x', 'y', 'z'});
    disp([inputname(1), ' coordinates = '])
    disp(point_table)
end
