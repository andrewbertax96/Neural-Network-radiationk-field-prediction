function runEigenfrequencyStudy(eigenFeature, eigenStudy, nModes)
    eigenFeature.set('neigs', int2str(nModes));
    eigenFeature.set("eigwhich", "lr");
    eigenStudy.run();
end