%function [new_data] = M2_sub2_222_21_sfujiwa(test_data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% noise reduction
%
% Function Call
% M2_sub_2_222_21 
%
% Input Arguments
% test_data
%
% Output Arguments
% new_data
%
% Assignment Information
%   Assignment:     M2, Problem 1
%   Team member:    Saran, sfujiwa@purdue.edu [repeat for each person]
%   Team ID:        222-21
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Name, login@purdue [repeat for each]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

test_data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");

time = test_data(:,1);
med_set = zeros(5001, 9);

%% ____________________
%% CALCULATIONS


% removing frozen data 
idx = 0;
for n = 2 : 46
    for m = 1 : 5001
        if m ~= 5001 && (test_data(m,n) == test_data(m+1, n))
            idx = 0;
            while test_data(m,n) == test_data(m+idx, n) 
                idx = idx + 1;
                end
                if idx > 3
                    test_data(m:m+idx, n) = NaN;
            end
        end
    end
end

% individual data set smoothing
idx = 10;
for run = 1 : 5
    for n = 2:46
       for m = 1 + idx : 5001 - idx
            test_data(m-idx, n) = mean(test_data(m-idx:m+idx, n), 'omitnan');
       end
    end
end
test_data(end-idx:end, n) = median(test_data(end-idx:end, n), 'omitnan');

% individual linear regression smoothing
slopes(:,1:2) = test_data(:,1:2);
slopes(:,46) = test_data(:,46);
for n = 2 : 46
    for m = 1 : 5000
        slopes(m, n) = (test_data(m, n) - test_data(m + 1, n)) / 0.01;
    end
end

delta = 0;
for n = 2 : 46
    for m = 1 : 5000
        delta = 0;
        idx = 0;
        if m + 20 < 5000 && abs((slopes(m + 10, n) - slopes(m, n)) > 0.1)
            delta = m;
            while (abs(slopes(m + idx, n) - slopes(m, n)) > 0.2)
                delta = delta + 1;
                idx = idx + 1;
            end
                valid_idx = ~isnan(slopes(m:delta, n));
                newy = test_data(valid_idx);
            if ~isnan(slopes(m, n)) && ~isnan(slopes(delta, n)) && (delta - m + 1) >= 2
                val = linspace(slope(m, n), slope(delta, n), delta - m + 1); % smooth linear interpolation
                test_data(m:delta, n) = val;
            end
        end
        if isnan(slopes(m,n))
            delta = m;
            while m + idx < 5000 && isnan(slopes(m + idx, n))
                idx = idx + 1;
                delta = delta + 1;
            end
            if ~isnan(slopes(m, n)) && ~isnan(slopes(delta, n)) && (delta - m + 1) >= 2
                val = linspace(slope(m, n), slope(delta, n), delta - m + 1); % smooth linear interpolation
                test_data(m:delta, n) = val;
            end
        end
    end
end

% %find median of 5 trials 
% cnt = 0;
% idx = 0;
% for n = 2:5:46
%     idx = idx + 1;
%     cnt = cnt + 1;
%     data_set = test_data(:, 1+n : 4+n);
%     for m = 1 : 5001
%         med = median(data_set(m,:));
%         med_set(m, cnt) = med;
%     end
% end

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% figure; 
% for p = 1 : 9
%     subplot(3,3,p);
%     plot(time, med_set(:, p));
%     ylim([min(med_set(:,p))-10, max(med_set(:,p))+5])
%     grid on
%     hold on
% end

% Loop to create 9 subplots with 5 lines on each plot of different colors

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
%         plot(test_data(:,1), test_data(:,count), colors(dataset)) % Plot each line
%         hold on % Turn on hold
%         grid on % Turn on grid
%         xlabel('Time (s)') % Create x-axis title
%         ylabel('Speed (m/s)') % Create y-axis title
%     end
%     title(Sub_titles{idx}); % Give titles to each subplot
% end
% sgtitle("Speed (m/s) Over Time (s) for " + ...
%     "Each Set of Tests") % Create an overall title


% figure
% plot(time, std_set)

%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



