function [confusion_matrix, success_A, success_B] = MED_error_analysis(prototypeA, prototypeB, classA, classB)

    nA = 0;
    nB = 0; 
    naB = 0;
    nbA = 0;
    
    success_A = double.empty(0,2);
    success_B = double.empty(0,2);
    
    for i=1:size(classA, 1)
        x = classA(i,:);
        AcloserB = MED(prototypeA, prototypeB, x);
        if AcloserB
            nA = nA+1;
            success_A = vertcat(success_A, classA(i,:));
        else
            naB = naB + 1;
        end
    end
    for i=1:size(classB, 1)
        x = classB(i,:);
        AcloserB = MED(prototypeA, prototypeB, x);
        if AcloserB
            nbA = nbA+1;
        else
            nB = nB + 1;
            success_B = vertcat(success_B, classB(i,:));
        end
    end
    confusion_matrix = [
        nA    naB;
        nbA      nB;
        ];
   
   
end