function [result] = MLestimate(mean1, cov1, mean2, cov2, X, Y)
	
	result = zeros(size(X, 1), size(Y,2));

	Q0 = inv(cov1) - inv(cov2);
	Q1 = 2*(mean2*inv(cov2) - mean1*inv(cov1));
	Q2 = mean1*inv(cov1)*mean1' - mean2*inv(cov2)*mean2';

	for i = 1:size(X, 1)
		for j = 1:size(Y,2)
			x = [X(i, j), Y(i, j)]; 
			result(i,j) = x*Q0*x' + Q1*x' + Q2; %ml estimate formula
		end
    end
end