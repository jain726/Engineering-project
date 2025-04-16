%% CALCULATIONS
percent_wise = 0.02; % this is the "percent line" that we will compare to find where it does not "passback"

%column mover
for i = 2:size(test_data, 2)
    col_data = test_data(:, i);                     % Get the entire column
    low(i) = min(col_data);
    top(i) = max(col_data);
    boundry(i) = ((top(i)-low(i))*percent_wise);

    %point mover
    for j = 1:size(col_data,1)
        
        %identifiery
        if col_data(j) <= boundry(i)
           velo_at_last(i) = col_data(j);
           
           j = j+1;
           
        else 
           j = j+1;
        end %ends if statement
    end
end
