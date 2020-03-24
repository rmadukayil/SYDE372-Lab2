function [output] = MLparzen(prob1, prob2, prob3, X, Y)
    output = zeros(size(X));  
    
    for i = 1:size(X,1)
        for j = 1:size(Y,2)
            [max_likelihood, labelled_class] = max([prob1(i,j), prob2(i,j), prob3(i,j)]);
            output(i,j) = labelled_class;
        end
    end
end
