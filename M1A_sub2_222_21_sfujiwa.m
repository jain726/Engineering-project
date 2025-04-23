function[new_data] = M3_sub2_222_21_sfujiwa(test_data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%replace this text with your program description as a comment
%
% Function Call
% replace this text with a comment that states the function call
%
% Input Arguments
% replace this text with a commented list of the input arguments
%
% Output Arguments
% replace this text with a commented list of the output arguments
%
% Assignment Information
%   Assignment:     M3, sub2
%   Team member:    Name, login@purdue.edu [repeat for each person]
%   Team ID:        ###-##
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Name, login@purdue [repeat for each]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

%test_data = readmatrix("Sp25_cruiseAuto_M3benchmark_data.csv");
% test_data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");

time = test_data(:,1);

%% ____________________
%% CALCULATIONS

new_data = zeros(size(test_data));
new_data(:,1) = test_data(:,1);

% find slopes of the data
slopes = zeros(size(test_data));
for n = 2 : length(test_data(1, 1:end))
    for m = 2 : length(test_data(1:end, 1))
        slopes(:, n) = (test_data(m, n) - test_data(m -1, n)) / (test_data(m, 1) - test_data(m -1, 1));
    end
end

% removing frozen data
for n = 2 : length(test_data(1, 1:end))
    for m = 1 : length(test_data(1:end, 1)) - 1
        if test_data(m + 1, n) == test_data(m, n)
            test_data(m, n) = 0;
        end
    end
end

% division of labor

for n = 2 : length(test_data(1, 1:end))
    for m = 2 : length(test_data(1:end, 1))
        
    end
end

for n = 2 : length(test_data(1, 1:end))
    new_data(:,n) = smoothdata(test_data(:,n), 'movmedian');
end


%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% %Loop to create 9 subplots with 5 lines on each plot of different colors
% 
% % Initialize variables to use in loop
% count = 1;
% colors = ['r', 'g', 'b', 'm', 'c'];
% Sub_titles = {'Compact Winter', 'Compact AllSeason', 'Compact Summer', ...
%     'Sedan Winter', 'Sedan AllSeason', 'Sedan Summer', 'SUV Winter', ...
%     'SUV AllSeason', 'SUV Summer'};
% 
% for idx = 1 : 9 % Initialize idx to specify subplots
%     subplot(3,3,idx) % Set up subplot loop
%     for dataset = 1 : 5 % Set up for loop to create each line
%         count = count + 1; % Increment count by 1 each loop
%         plot(time, new_data(:,count), colors(dataset)) % Plot each line
%         hold on % Turn on hold
%         grid on % Turn on grid
%         xlabel('Time (s)') % Create x-axis title
%         ylabel('Speed (m/s)') % Create y-axis title
%     end
%     title(Sub_titles{idx}); % Give titles to each subplot
% end
% sgtitle("Speed (m/s) Over Time (s) for " + ...
%     "Each Set of Tests") % Create an overall title


%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



