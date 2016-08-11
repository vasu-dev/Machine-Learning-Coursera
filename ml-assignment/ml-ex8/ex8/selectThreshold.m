function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval);
    predictions = (pval < epsilon);
    tp=0;
    fp=0;
    fn=0;
    tp = sum((predictions == 1) & (yval == 1));
    fp = sum((predictions == 1) & (yval == 0));
    fn = sum((predictions == 0) & (yval == 1));
    if tp ~= 0;
        prec = (tp/(tp+fp));
        rec = (tp/(tp+fn));
        F1 = (2*prec*rec)/(prec+rec);
    else
        prec = 0;
        rec = 0;
        F1 = 0;
    endif;


    % =============================================================

    if F1 > bestF1;
       bestF1 = F1;
       bestEpsilon = epsilon;
    end;
end;

end
