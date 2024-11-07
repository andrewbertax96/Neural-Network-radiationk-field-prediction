function updateMaterialParameters(model, materialTag, density, Evector, Gvector)
    % Updates the material properties of a given material in the COMSOL model
    %
    % Parameters:
    % model - The COMSOL model object
    % materialTag - The tag for the material to be updated (e.g., 'mat6')
    % density - The density value
    % Evector - A 1x3 vector of Young's moduli in the x, y, and z directions
    % Gvector - A 1x3 vector of shear moduli in the xy, yz, and xz planes

    % Set the density value
    model.component('comp1').material(materialTag).propertyGroup('def').set('density', {num2str(density)});

    % Set the Young's moduli (Evector) values
    model.component('comp1').material(materialTag).propertyGroup('Orthotropic').set('Evector', {num2str(Evector(1)), num2str(Evector(2)), num2str(Evector(3))});

    % Set the shear moduli (Gvector) values
    model.component('comp1').material(materialTag).propertyGroup('Orthotropic').set('Gvector', {num2str(Gvector(1)), num2str(Gvector(2)), num2str(Gvector(3))});
end
