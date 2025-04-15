%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Create plots for each test
%
% Function Call
% M1B_main_222_21_mbarish
%
% Input Arguments
%
% Output Arguments
%
% Assignment Information
%   Assignment:     M1B, Problem 1
%   Team member:    Max Barish, mbarish@purdue.edu
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

% Import data matrix
test_data = readmatrix("Sp25_cruiseAuto_" + ...
    "experimental_data.csv","NumHeaderLines",1);

% Extrapolate data
t = test_data(:,1); % Isolate time column
s_data = test_data(:,2:end); % Isolate columns of speed data

% Initialize variables to use in loop
count = 0;
colors = ['r', 'g', 'b', 'm', 'c'];
Sub_titles = {'Compact Winter', 'Compact AllSeason', 'Compact Summer', ...
    'Sedan Winter', 'Sedan AllSeason', 'Sedan Summer', 'SUV Winter', ...
    'SUV AllSeason', 'SUV Summer'};

%% ____________________
%% CALCULATIONS


%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% Loop to create 9 subplots with 5 lines on each plot of different colors
for idx = 1 : 9 % Initialize idx to specify subplots
    subplot(3,3,idx) % Set up subplot loop
    for dataset = 1 : 5 % Set up for loop to create each line
        count = count + 1; % Increment count by 1 each loop
        plot(t,s_data(:,count), colors(dataset)) % Plot each line
        hold on % Turn on hold
        grid on % Turn on grid
        xlabel('Time (s)') % Create x-axis title
        ylabel('Speed (m/s)') % Create y-axis title
    end
    title(Sub_titles{idx}); % Give titles to each subplot
end
sgtitle("Speed (m/s) Over Time (s) for " + ...
    "Each Set of Tests") % Create an overall title
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.

