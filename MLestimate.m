function [output] = MLestimate(mean1, cov1, mean2, cov2, X, Y)
	
	output = zeros(size(X, 1), size(Y,2));

	for i = 1:size(X, 1)
        for j = 1:size(Y,2)
			x = [X(i, j), Y(i, j)]; 
			output(i,j) = x*(inv(cov1) - inv(cov2))*x' + (2*(mean2*inv(cov2) - mean1*inv(cov1)))*x' + (mean1*inv(cov1)*mean1' - mean2*inv(cov2)*mean2'); %ml estimate formula
        end
    end
end