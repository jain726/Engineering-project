function [t_0, time_constant] = M3_sub3_222_21_isbells(test_data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This program imputs the test data. Then it sets a "boundry line" this is
% a percentage of the total height. It then moves through the each
% coulumn, "i". In each column, it then moves through every value,"j". Then
% it compares the current j value to the boundry line. While the j value is
% lower than the boundry, it sets the final velocity. Then it indexs that
% velocity to the proper time. The time constant is calculated with the
% found values.
% Function Call
% M2_sub3_222_21_isbells
% Input Arguments
% Test_data
% Output Arguments
% t_0, time_constant
% Assignment Information
%   Assignment:     M02, Problem 
%   Team member:    Spencer Isbell, isbells@purdue.edu [repeat for each person]
%   Team ID:        222-21
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Name, login@purdue [repeat for each]
%       Max, Kenji, Sidh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

percent_wise = .1; % this is the "percent line" that we will compare to find where it does not "passback"
times = test_data(:,1); % extrapolate time column
velocities = test_data(:,2:end); % extrapolate velocity data

%column mover
for i = 1:size(velocities, 2) % start for loop
    col_data = velocities(:, i); % Get the entire column
    low(i) = min(col_data); % find minimum velocity
    top(i) = max(col_data); % find maximum velocity
    boundry(i) = ((top(i)-low(i))*percent_wise); % set boundry
    threshold(i) = min(col_data) + boundry(i); % set threshold

    %point mover
    for j = 1:size(col_data,1)
    
            if col_data(j) <= threshold(i) % check if vel. is less than threshold
               velo_at_last(i) = col_data(j); % set new velo at last
               j = j + 1; % index j
               t_0(i) = times(j); % index times at j to determine the time
            else     
               j = j + 1; % index j
            end % ends if statement

target_vel = velo_at_last(i) + 0.632 * (top(i) - velo_at_last(i)); % set target velocity
found_timeconstant = 0; % initialize found_timeconstant

    for k = 1:size(col_data,1) % for loop to move through column data again
        if found_timeconstant == 0 && col_data(k) >= target_vel % if
            % unfound and target value is less than or equal to velocity
            time_constant(i) = times(k) - t_0(i); % update time constant
            found_timeconstant = 1; % mark as found
        else
        end
    end
end

end





%     %point mover
%     for j = 1:size(col_data,1)
% 
%             if col_data(j) <= threshold(i) % check if vel. is less than threshold
%                velo_at_last(i) = col_data(j); % set new velo at last
%                j = j + 1; % index j
%                t_0(i) = times(j); % index times at j to determine the time
%             else     
%                j = j + 1; % index j
%             end % ends if statement
% target_vel(i) = velo_at_last(i) + 0.632 * (top(i) - velo_at_last(i)); % set target velocity
% 
%             if found_timeconstant == 0 && col_data(i) >= target_vel(i)
%                time_constant(i) = times(j) - t_0(i);
%                found_timeconstant = 1; % mark as found
%         end
%     end
% end
