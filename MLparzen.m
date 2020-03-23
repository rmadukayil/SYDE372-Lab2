function [output] = MLparzen(prob1, prob2, X, Y)
    output = zeros(size(X,2),size(Y,2));  
    
    for i = 1:size(X,2)
        for j = 1:size(Y,2)
           output(i,j) = prob1(i,j) - prob2(i,j);
        end
    end
end

