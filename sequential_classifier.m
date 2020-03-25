function [G, error_rate] = sequential_classifier(X, Y, j_limit)
    %j_limit = 0 means no limit on j
    global classA_part4 classB_part4;
    classA_data = classA_part4;
    classB_data = classB_part4;
    nA = 0;
    nB = 0;
    naB_nbA = int16.empty;
    a_prototypes = double.empty(0,2);
    b_prototypes = double.empty(0,2);
    j = 0;
    
    while true
        [prototypeA, prototypeB, AB_confusion, success_A, success_B] = prototype_selection(classA_data, classB_data);
        %save discrimininant fct - contour plot
        
        j = j+1;
        a_prototypes = vertcat(a_prototypes, prototypeA);
        b_prototypes = vertcat(b_prototypes, prototypeB);

        naB = AB_confusion(1,2);
        nbA = AB_confusion(2,1);
        naB_nbA = vertcat(naB_nbA, [naB, nbA]);
        
        if naB == 0 
            classB_data = setxor(classB_data, success_B,'rows');
        end
        if nbA == 0 
            classA_data = setxor(classA_data, success_A,'rows');
        end  
        if size(classA_data,1)== 0 || size(classB_data, 1) == 0
            break
        end
        if j_limit ~= 0 && j == j_limit
            break
        end
    end
    %generate combinational sequential classifier  
    G = zeros(size(X));
    for k=1:numel(G)
        for i=1:j
            classified_A = MED(a_prototypes(i,:), b_prototypes(i,:), [X(k) Y(k)]);
            if classified_A && naB_nbA(i,2)== 0 %%classified as 'A' AND nbA = 0
                G(k) = 10; %%classify as A
                break
            elseif ~classified_A && naB_nbA(i,1)== 0 %%classified as 'B' AND naB = 0
                G(k) = 1; %%classify as B
                break
            end
        end
    end
    %error rate calculations
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
