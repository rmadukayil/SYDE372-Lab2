function [Z, error_rate] = sequential_classifier(X, Y, j_limit)
    %j_limit = 0 means no limit on j
    global classA_part4 classB_part4;
    classA_data = classA_part4;
    classB_data = classB_part4;
    nA = 0;
    nB = 0;
    a_prototypes = double.empty(0,2);
    b_prototypes = double.empty(0,2);
    %Z = double.empty(size(X,1), size(X,1),0);
    Z=double.empty;
    j = 0;
    
    while true
        [prototypeA, prototypeB, AB_confusion, success_A, success_B] = prototype_selection(classA_data, classB_data);
        %save discrimininant fct - contour plot
        
        j = j+1;
        a_prototypes = vertcat(a_prototypes, prototypeA);
        b_prototypes = vertcat(b_prototypes, prototypeB);
        
        Z_test = zeros(size(X));
        for i=1:numel(X)
            classified_A = MED(prototypeA, prototypeB, [X(i) Y(i)]);
            if classified_A
                Z_test(i) = 10; %%classify as A
            else
                Z_test(i) = 1; %%classify as B
            end
        end
        Z = cat(3, Z, Z_test);

        if AB_confusion(1,2) == 0 %naB= 0
            %classA_data = setxor(classA_data, success_A);
            classB_data = setxor(classB_data, success_B,'rows');
        end
        if AB_confusion(2,1) == 0 %nbA = 0
            %classB_data = setxor(classB_data, success_B);
            classA_data = setxor(classA_data, success_A,'rows');
        end  
        if size(classA_data,1)== 0 || size(classB_data, 1) == 0
            break
        end
        if j_limit ~= 0 && j == j_limit
            break
        end
    end
    for k=1:size(classA_part4,1) 
        x_bar = classA_part4(k,:);
        for i=1:j
            classified_A = MED(a_prototypes(i,:), b_prototypes(i,:), x_bar);
            if classified_A
                %say class A
                nA = nA + 1;
                break
            end
        end  
    end
    for k=1:size(classB_part4,1) 
        x_bar = classB_part4(k,:);
        for i=1:j
            classified_A = MED(a_prototypes(i,:), b_prototypes(i,:), x_bar);
            if ~classified_A
                %say class B
                nB = nB + 1;
                break
            end
        end  
    end
    error_rate = 1-((nA+nB)/400);
    
    end
   

