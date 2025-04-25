function[new_data] = M3_sub2_222_21_sfujiwa(test_data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% this function smoothen the original data, removes any frozen data and
% linear interpolates removed frozen data and nan values. 
%
% Function Call
% M3_sub2_222_21_sfujiwa
%
% Input Arguments
% test_data
%
% Output Arguments
% new_data
%
% Assignment Information
%   Assignment:     M3, sub2
%   Team member:    Team member: Max Barish, mbarish@purdue.edu 
%   Team member:    Sidh Jain, jain726@purdue.edu 
%   Team member:    Spencer Isbel, isbells@purdue.edu 
%   Team member:    Saran Fujiwara, sfujiwa@purdue.edu
%   Team ID:        222-21
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Name, login@purdue [repeat for each]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

% read matrix, only for use in making of subfunction
% test_data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");

time = test_data(:,1);

%% ____________________
%% CALCULATIONS

% removing frozen data & linear interpolation of removed data
% any frozen data where values remain constant gets removed and linear
% interpolated in place
for n = 2 : length(test_data(1, 1:end)) % for loop from index 1 to index last column
    m = 1;
    while m < length(test_data(1:end, 1)) - 4 % for loop
        if test_data(m + 1, n) == test_data(m, n)
            idxi = m;
            idx = 0;
            idxf = 0;
            % finds the interval where linspace has to be used to
            % interporlate new data and replaces old data
            while test_data(m + idx, n) == test_data(m, n)
                idx = idx + 1;
                idxf = m + idx;
            end
            temp_data = linspace(test_data(idxi, n), test_data(idxf + 3, n), idx + 3);
            test_data(idxi:idxf+2, n) = temp_data;

            m = m + idx;
        end
        m = m + 1;
    end
end

idxi = 0;
idxf = 0;
temp_data = 0;

% Uses Linear interpolation in order to fill in the gaps where NaN is
% present. 
for n = 2 : length(test_data(1, 1:end))
    m = 1;
    while m < length(test_data(1:end, 1)) - 4
        if isnan(test_data(m, n))
            idxi = m;
            idx = 0;
            idxf = 0;
            % finds te interval between start of NaN chain and end of NaN
            % chain for linspace to work.
            while isnan(test_data(m + idx, n))
                idx = idx + 1;
                idxf = m + idx;
            end
            temp_data = linspace(test_data(idxi-1, n), test_data(idxf + 1, n), idx + 2);
            test_data(idxi:idxf+1, n) = temp_data;

            m = m + idx;
        end
        m = m + 1;
    end
end

% finding initial instance of acceleration
% round data to 0 decimal points to allow mode function to work
rounded_data = round(test_data, 0);
new_data = zeros(size(test_data));
new_data(:,1) = time;

% finds the median of y values of each individual data set 
for n = 2 : length(test_data(1, 1:end))
    data_mid = round((max(test_data(:,n)) - min(test_data(:,n))) / 2, 0); % finds the median y value in data set
    row = find(rounded_data(:,n) == data_mid); % find the row in which the median y value is located

    start_speed = mode(rounded_data(1:row(1) , n)); % uses range of 1 to row, find mode of initial start time
    start_idx = find(rounded_data(:, n) == start_speed); % find last row in which new mode appears
    start_idx = start_idx(end);

        % Movmedian and movmean smooths and removes noise for parts before
        % start time and after start time of acceleration, this is to avoid
        % making the instance of start accleration distinct
        new_data(1:start_idx, n) = smoothdata(test_data(1:start_idx, n),'movmedian', 'SmoothingFactor', 0.8);
        new_data(start_idx:end, n) = smoothdata(test_data(start_idx:end, n),'movmedian', 'SmoothingFactor', 0.1);
        new_data(start_idx:end, n) = smoothdata(test_data(start_idx:end, n),'movmean', 'SmoothingFactor', 0.1);
    
end

% smoothdata function with all the data set together, will remove any
% errors created in the prior section and uses movmean to finally smooth
% out all incosistencies after removing high/low data and outliers
new_data(:, 2:end) = smoothdata(new_data(:, 2:end),'movmedian', 'SmoothingFactor', 0.1);
new_data(:, 2:end) = smoothdata(new_data(:, 2:end),'movmean', 'SmoothingFactor', 0.008);

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% %Loop to create 9 subplots with 5 lines on each plot of different colors
% % Used only for data visulization within subfunction, gets commented out
% % as it is not used for main function
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

new_data;

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



