function [spl_Fib, spl_Mer] = processSimulationResults(model, resultsPath, sim)
    tbl3ExportFile = fullfile(resultsPath, sprintf('SPL-DenseFibonacciProbesDistribution_Sim%d.dat', sim));
    tbl4ExportFile = fullfile(resultsPath, sprintf('SPL-DenseMeridianProbesDistribution_Sim%d.dat', sim));

    model.result.export('tbl3').set('filename', tbl3ExportFile);
    model.result.export('tbl3').run();
    model.result.export('tbl4').set('filename', tbl4ExportFile);
    model.result.export('tbl4').run();

    spl_Fib = readAndCleanData(tbl3ExportFile);
    spl_Mer = readAndCleanData(tbl4ExportFile);
end