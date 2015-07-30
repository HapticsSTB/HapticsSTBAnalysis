function [vector, ratings, index] = featureVector(feats)
    
    fFields = sort(fields(feats)); %sort features in alphabetical order
    featFields = fFields(~strcmpi(fFields, 'gears') & ~strcmpi(fFields, 'fam')); %remove GEARS and fam from feature set
    
    fieldCols = zeros(size(featFields));  %create a vector of zeros the same size as list of features in featFields
    vecRows = length(feats); %variable that contains the number of actual features
    
    for i = 1:length(featFields) 
        fieldCols(i) = length(feats(1).(featFields{i})); % counts the number of observations of each feature
    end

    vector = zeros(vecRows, sum(fieldCols));
    index{sum(fieldCols)} = '';
    col = 1;
    raw_features = {'data(t).forces(:,1)','data(t).forces(:,2)','data(t).forces(:,3)','fMag',...
            'acc1','acc1H','acc1L','acc2','acc2H','acc2L','acc3','acc3H','acc3L',...
            'accProd','fAcc1Prod','fAcc2Prod',...
            'r1', 'p1', 'r2', 'p2', 'r3', 'p3', ...
            'diff(r1)', 'diff(p1)', 'diff(r2)', 'diff(p2)', 'diff(r3)', 'diff(p3)'};
        
    for i = 1:length(featFields)
        vector(:, col:col+fieldCols(i)-1) = [feats.(featFields{i})]';
        for j = 0:fieldCols(i)-1
            index{col+j} = sprintf([featFields{i} ' %d: %s'], j, raw_features{j+1});
        end
        col = col+fieldCols(i);
    end
    
    ratings = [feats.gears]';
end