function [t_0,time_constant] = M2_sub3_222_21_isbells(Test_data)
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

%% ____________________
%% INITIALIZATION
percent_wise = 0.02; % this is the "percent line" that we will compare to find where it does not "passback"
times = Test_data(:,1);
velocities = Test_data(:,2:end);

%column mover
percent_wise = 0.02; % this is the "percent line" that we will compare to find where it does not "passback"
times = Test_data(:,1);
velocities = Test_data(:,2:end);

%column mover
for i = 1:size(velocities, 2)
    col_data = velocities(:, i); % Get the entire column
    low(i) = min(col_data);
    top(i) = max(col_data);
    boundry(i) = ((top(i)-low(i))*percent_wise);

    %point mover
    for j = 1:size(col_data,1)
        
        %identifiery
        while col_data(j) <= boundry(i)
           velo_at_last(i) = col_data(j);
           j = j+1;     
           t_0(i) = times(j);
           time_constant(i) = 0.632*(top(i)-velo_at_last(i))-t_0(i);

        end %ends if statement
    end
end

end
