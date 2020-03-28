function [classA] = MED(prototypeA, prototypeB, x)
    dist_classA = sqrt((prototypeA(1)-x(1)).^2 + (prototypeA(2)-x(2)).^2);
    dist_classB = sqrt((prototypeB(1)-x(1)).^2 + (prototypeB(2)-x(2)).^2);
    if dist_classA < dist_classB
        classA = true;
    else
        classA = false;
    end
end