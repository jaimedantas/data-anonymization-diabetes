% shufle dataset
[D,n] = size(dataset);
dsrand = dataset(randperm(D), :);

t = dsrand(:,17);
x = dsrand(:,1:16);
age = x(:,1);

% plot age
% f1 = figure;
% histogram(age);
% set(gca,'xtick',[0:10:100],'FontSize',15)
% set(gca,'ytick',[0:10:90],'FontSize',15)
% xlim([0, 100]);
% 
% title('Age Distribution Original','FontSize',18);
% ylabel('Samples','FontSize',18);
% xlabel('Age (years)','FontSize',18);
% print('BarPlot','-depsc')


%---------FFNN
target_t = [];
for i=1:520
if t(i) == 1 
target_t = [target_t; 1 0]; % stable
else
target_t = [target_t; 0 1]; % unstable
end
end

% FFNN for classification with one hidden layer of size 10.
net = patternnet([48 32], 'trainscg');

% performance function (loss function)
net.performFcn = 'crossentropy';
net.performParam.regularization = 0.01;
net.performParam.normalization = 'none';

% training, testing and validation are 0.7, 0.15 and 0.15.
net.divideFcn= 'divideind'; % divide the data manually
net.divideParam.trainInd= 1:332; % training data indices 80% from training
net.divideParam.valInd= 333:416; % validation data indices 20% from training
net.divideParam.testInd= 417:520;  % testing data indices from testing dataset- 20% of total

% transfer function
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';

% train
net = train(net,x',target_t');
            
view(net)

% targets
y = net(x);