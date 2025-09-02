function severe_IL6K_knockout_plotter(timeS, solS, solIL6K, p)
    % Viral Load
    fig = figure;
    hold on;
    plot(timeS, 10.^(solS(1, :)), 'Color', [32 52 79]/255, 'LineWidth', 3, 'DisplayName', 'Severe Case');
    plot(timeS, 10.^(solIL6K(1, :)), '--', 'Color', [255 0 0]/255, 'LineWidth', 3, 'DisplayName', 'IL6 Knockout');
    set(gca, 'yscale', 'log');
    title('Viral Load');
    ylabel('copies/ml');
    xlabel('Time (days)');
    legend;
    set(gca, 'FontSize', 24);
    xlim([0 20]);
    saveas(fig, 'Fig_Severe_IL6_Knockout_ViralLoad.png');
    saveas(fig, 'Fig_Severe_IL6_Knockout_ViralLoad.fig');

    % Uninfected Cells
    fig = figure;
    hold on;
    plot(timeS, (solS(2, :) + solS(4, :)) * 1e9, 'Color', [32 52 79]/255, 'LineWidth', 3, 'DisplayName', 'Severe Case');
    plot(timeS, (solIL6K(2, :) + solIL6K(4, :)) * 1e9, '--', 'Color', [255 0 0]/255, 'LineWidth', 3, 'DisplayName', 'IL6 Knockout');
    set(gca, 'yscale', 'log');
    title('Uninfected Cells');
    ylabel('cells/ml');
    xlabel('Time (days)');
    legend;
    set(gca, 'FontSize', 24);
    saveas(fig, 'Fig_Severe_IL6_Knockout_UninfectedCells.png');
    saveas(fig, 'Fig_Severe_IL6_Knockout_UninfectedCells.fig');

    % Infected Cells
    fig = figure;
    hold on;
    plot(timeS, solS(3, :) * 1e9, 'Color', [32 52 79]/255, 'LineWidth', 3, 'DisplayName', 'Severe Case');
    plot(timeS, solIL6K(3, :) * 1e9, '--', 'Color', [255 0 0]/255, 'LineWidth', 3, 'DisplayName', 'IL6 Knockout');
    set(gca, 'yscale', 'log');
    title('Infected Cells');
    ylabel('cells/ml');
    xlabel('Time (days)');
    legend;
    set(gca, 'FontSize', 24);
    saveas(fig, 'Fig_Severe_IL6_Knockout_InfectedCells.png');
    saveas(fig, 'Fig_Severe_IL6_Knockout_InfectedCells.fig');

    % Dead Cells
    fig = figure;
    hold on;
    plot(timeS, solS(5, :) * 1e9, 'Color', [32 52 79]/255, 'LineWidth', 3, 'DisplayName', 'Severe Case');
    plot(timeS, solIL6K(5, :) * 1e9, '--', 'Color', [255 0 0]/255, 'LineWidth', 3, 'DisplayName', 'IL6 Knockout');
    set(gca, 'yscale', 'log');
    title('Dead Cells');
    ylabel('cells/ml');
    xlabel('Time (days)');
    legend;
    set(gca, 'FontSize', 24);
    saveas(fig, 'Fig_Severe_IL6_Knockout_DeadCells.png');
    saveas(fig, 'Fig_Severe_IL6_Knockout_DeadCells.fig');

    %Alveolar Macs
    fig = figure;
    hold on;
    plot(timeS, solS(6, :) * 1e9, 'Color', [32 52 79]/255, 'LineWidth', 3, 'DisplayName', 'Severe Case');
    plot(timeS, solIL6K(6, :) * 1e9, '--', 'Color', [255 0 0]/255, 'LineWidth', 3, 'DisplayName', 'IL6 Knockout');
    set(gca, 'yscale', 'log');
    title('Alveolar Macs');
    ylabel('cells/ml');
    xlabel('Time (days)');
    legend;
    set(gca, 'FontSize', 24);
    saveas(fig, 'Fig_Severe_IL6_Knockout_AlveolarMacs.png');
    saveas(fig, 'Fig_Severe_IL6_Knockout_AlveolarMacs.fig');

    
end