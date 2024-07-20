function createfigure4(YMatrix1)
% References:
% Z. Jia, M. K. Ng, and G. -J. Song,``Lanczos Method for Large-Scale
% Quaternion Singular Value Decomposition'',preprint.

%by Zhigang Jia
%on Feb 13 2018

% Create figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(YMatrix1,'MarkerSize',8,'LineWidth',3);
set(plot1(1),'DisplayName','CPCA-eigQ','Marker','+','Color',[0 0 1]);
set(plot1(2),'DisplayName','CPCA-lansvdQ','Marker','o','Color',[1 0 1]);

% Create xlabel
xlabel('Number of eigenfaces','FontWeight','bold','FontSize',16);

% Create ylabel
ylabel('Accuracy of face recognition','FontWeight','bold','FontSize',16);

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',14,'FontWeight','bold');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.61225642779375 0.313358681932636 0.228613569321534 0.123382844163815],...
    'FontSize',16);

