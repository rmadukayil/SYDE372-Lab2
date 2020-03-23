function [prototypeA, prototypeB, AB_confusion, success_A, success_B] = prototype_selection(classA, classB)
    while true
        prototypeA = classA(randi(size(classA,1)),:);
        prototypeB = classB(randi(size(classB,1)),:);
        [AB_confusion, success_A, success_B] = MED_error_analysis(prototypeA, prototypeB, classA, classB);
        if (AB_confusion(1,2) == 0) || (AB_confusion(2,1) == 0)
            break
        end
    end    
end