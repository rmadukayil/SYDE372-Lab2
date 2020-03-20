function [G1] = sequential_classifier(X1, Y1)
    global classA classB;
    classA_data = classA;
    classB_data = classB;
    G1 = zeros(size(X1));
    j = 0;
    while true
        [prototypeA, prototypeB, AB_confusion, success_A, success_B] = prototype_selection(classA_data, classB_data);
        %save discrimininant fct - contour plot
        j = j+1;
        %vertcat(success_B, classB(:,i));
        Z1 = vertcat(Z1, zeros(size(X1)));
        %Z1(:,j) = zeros(size(X1));
            for i=1:numel(X1)
                classified_A = MED(prototypeA, prototypeB, [X1(i) Y1(i)]);
                if classified_A
                    Z1(i,j) = 10; %%classify as A
                else
                    Z1(i,j) = 1; %%classify as B
                end
            end

        if AB_confusion(1,2) == 0 %naB= 0
            classA_data = setxor(classA_data, success_A);
        end
        if AB_confusion(2,1) == 0 %nbA = 0
            classB_data = setxor(classB_data, success_B);
        end  
        if size(classA_data,1)== 0 && size(classB_data, 1) == 0
            break
        end
    end
    
    
    
    for i=1:numel(X1)
        if max(Z1(:,i)) == 10
            G1(i) = 10;
        else
            G1(i) = 1;
        end 
    end 
end
   

