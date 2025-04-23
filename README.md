function [] = M3_benchmark_222_21(t0_b, v0_b, vf_b, tao_b, t0_m, v0_m, vf_m, tao_m, test_data)
% Plot both our model and optimal model
% t_0 = initial time of acceleration
% v_0 = initial velocity
% v_f = final velocity
% tao = time constant
% Input variables can be vectors but they must all be the same length



t = test_data(:,1);
vels = test_data(:, 2:end);
Sub_titles = {'Compact Hatchback', 'Midsize Sedan', 'Large SUV'};

    for i = 1 : length(t0_b)
        % Preallocate velocity vectors
        v_of_t_b = zeros(length(t), 1);

        for j = 1 : length(t)
            idx = 1;
            while t(idx) < t0_b(i) - 5
                idx = idx + 1;
            end
            t = t(idx-1:end);
            if t(j) < t0_b(i)
                v_of_t_b(j) = v0_b(i);
            else
                v_of_t_b(j) = vf_b(i) + (1 - exp(-(t(j) - t0_b(i)) / ...
                    tao_b(i))) * (vf_b(i) - v0_b(i));
            end
        end

        % Now plot after computing the vectors
        col_data = vels(:, i);
        subplot(length(t0_b), 1, i)
        plot(t, v_of_t_b, 'r')
        hold on
        plot(t, col_data, 'b')
        grid on
        xlabel('Time (s)')
        ylabel('Speed (m/s)')
        legend('Model', 'Data', 'Location', 'best')
        title(Sub_titles{i})
    end
    sgtitle("Speed (m/s) Over Time (s) for Each Set of Tests")
end



% % Initialize data
% t = test_data(:,1);
% Sub_titles = {'Compact Hatchback', 'Midsize Sedan', 'Large SUV'};
% 
% % 
% for i = 1 : length(t0_b)
%     for j = 1 : length(t)
%         if t(j) < t0_b(i) 
%             v_of_t_b(j) = v0_b(i);
%             v_of_t_m(j) = v0_m(i);
%         else
%             v_of_t_b(j) = vf_b(i) + (1 - exp(-(t(j) - t0_b(i)) / ...
%                 tao_b(i))) * (vf_b(i) - v0_b(i));
%             v_of_t_m(j) = vf_m(i) + (1 - exp(-(t(j) - t0_m(i)) / ...
%                 tao_m(i))) * (vf_m(i) - v0_m(i));
%         end
% 
%         subplot(length(t0_b),1,i) % Set up subplot loop
%         plot(t, v_of_t_b, "r-") % Plot benchmark
%         hold on % Turn on hold
%         plot(t, v_of_t_m, "b-") % Plot algorithm model
%         grid on % Turn on grid
%         xlabel('Time (s)') % Create x-axis title
%         ylabel('Speed (m/s)') % Create y-axis title
%         legend('benchmark model', 'algorithm model', 'Location','best')
%         title(Sub_titles{i}); % Give titles to each subplot
%         hold off
% 
%     end
%     sgtitle("Speed (m/s) Over Time (s) for " + ...
%         "Each Set of Tests") % Create an overall title
% end
