function runFrequencyStudy(frequencyStudy, eigenFrequencies)
    frequencyStudy.feature('freq').set('plist', num2str(eigenFrequencies));
    frequencyStudy.run();
end