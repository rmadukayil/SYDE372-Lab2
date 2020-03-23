function [min_err, max_err, avg_err, std_err] = sequential_error_analysis(X, Y)
    min_err = double.empty;
    max_err = double.empty;
    avg_err = double.empty;
    std_err = double.empty;
    for j=1:5
        err_rates = double.empty;
        for i=1:20
            [Z, err] = sequential_classifier(X, Y, j);
            err_rates = horzcat(err_rates, err);
        end
        min_err = vertcat(min_err, [j min(err_rates)]);
        max_err = vertcat(max_err, [j max(err_rates)]);
        avg_err = vertcat(avg_err, [j mean(err_rates)]);
        std_err = vertcat(std_err, [j std(err_rates)]);
    end
end