% shufle dataset
[D,n] = size(dataset);
dsrand = dataset(randperm(D), :);

sensitivity = 1;
epsilon = 0.1;
scale = sensitivity/epsilon;


for i=1:520
    ageValue = dsrand(i,1);
    if ageValue >=10 && ageValue < 20 
        dsrand(i,1) = 1;
    end
    if ageValue >=20 && ageValue < 30 
        dsrand(i,1) = 2;
    end
    if ageValue >=30 && ageValue < 40 
        dsrand(i,1) = 3;
    end
    if ageValue >=40 && ageValue < 50 
        dsrand(i,1) = 4;
    end
    if ageValue >=50 && ageValue < 60 
        dsrand(i,1) = 5;
    end
    if ageValue >=60 && ageValue < 70 
        dsrand(i,1) = 6;
    end
    if ageValue >=70 && ageValue < 80 
        dsrand(i,1) = 7;
    end
    if ageValue >=80 && ageValue < 90 
        dsrand(i,1) = 8;
    end
    if ageValue >=90 && ageValue < 100 
        dsrand(i,1) = 9;
    end
end


t = dsrand(:,17);
x = dsrand(:,1:16);
age = x(:,1);


% plot age
% f1 = figure;
% histogram(age);
% set(gca, 'XTickLabel',{'10-19', '20-29', '30-39', '40-49', '50-59', '60-69', '70-79', '80-89', '90-99'})
% %set(gca,'XTick',binranges)
% 
% %set(gca,'ytick',[0:10:90],'FontSize',15)
% %xlim([0, 10]);
% 
% title('Age Distribution With K-anonymity','FontSize',18);
% ylabel('Samples','FontSize',18);
% xlabel('Age (years)','FontSize',18);
% print('BarPlotRange','-depsc')


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

