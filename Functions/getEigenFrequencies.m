function eigenFrequencies = getEigenFrequencies(model, eigenFreqDataset)
    evalFreqz = mpheval(model, 'solid.freq', 'Dataset', eigenFreqDataset, 'edim', 0, 'selection', 1);
    eigenFrequencies = real(evalFreqz.d1);
end