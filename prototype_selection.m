function [prototypeA, prototypeB, AB_confusion, success_A, success_B] = prototype_selection(classA, classB)
    while (AB_confusion(1,2) ~= 0) && (AB_confusion(2,1) ~= 0)
        prototypeA = classA(randi(numel(classA)));
        prototypeB = classB(randi(numel(classB)));
        [AB_confusion, success_A, success_B] = MED_error_analysis(prototypeA, prototypeB, classA, classB);
    end    
end