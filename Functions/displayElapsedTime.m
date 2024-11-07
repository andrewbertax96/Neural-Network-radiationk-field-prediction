function displayElapsedTime(tStart, sim)
    elapsedTimeInSeconds = toc(tStart);
    minutes = floor(elapsedTimeInSeconds / 60);
    seconds = mod(elapsedTimeInSeconds, 60);
    disp(['Simulation ', num2str(sim), ' completed. Elapsed time = ', num2str(minutes), ' minutes and ', num2str(seconds, '%.2f'), ' seconds.']);
end