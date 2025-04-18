%updated code 4-18-25
percent_wise = 0.02; % this is the "percent line" that we will compare to find where it does not "passback"
times = test_data(:,1);
velocities = test_data(:,2:end);

%column mover
for i = 1:size(velocities, 2)
    col_data = velocities(:, i);                     % Get the entire column
    low(i) = min(col_data);
    top(i) = max(col_data);
    boundry(i) = ((top(i)-low(i))*percent_wise);

    %point mover
    for j = 1:size(col_data,1)

            if col_data(j) <= boundry(i)
              velo_at_last(i) = col_data(j);
               j = j+1; 
               t_0(i) = times(j);

            else
               j = j+1;     
            end


        end %ends if statement
    end
