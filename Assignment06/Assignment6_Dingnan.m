%% Assignment 6 , Dina Ding, 2025-02-17, 4671340


%%  Question 1 %%
wine_data = readtable('wine/wine.data','FileType','text');
wine_data = table2array(wine_data);

Class = wine_data(:,1);     %% class, choose column 1
Features = wine_data(:,2:end);  %% features,choose other columns
%%disp(Class);
%%disp(Features);

Features = normalize(Features);

num_class = 3; %% according to wine.data, there are 3 class
Targets = full(ind2vec(Class')); %% change Class from column into row, converts the class labels into one-hot encoding 1:100,2:010,3:001
%disp(Targets);

% before training , choose out 10 samples for training
num_samples = 10;
test_indices = [];

for i = 1:num_class
   class_indices = find(Class == i);
   % only store "index" of 10 samples of each class in "test_indices", not the whole samples
   test_indices = [test_indices; class_indices(1:num_samples)]; 
   %disp(test_indices(1));
end


% because we need to use 10 itesm for testing, so all other datas could be used as training
%s setdiff(A, B) → Returns elements in A that are not in B
train_indices = setdiff(1:length(Class),test_indices); 

train_indices = train_indices(:); % make sure it is column vector
test_indices = test_indices(:);

% get train data
% neural network expects features in columns, samples in rows
% 这一点和数据本身的table不一致，数据本身是1个样本1行。 但神经网络想要：
%  1个样本1列，每1行为同1个特征，所以此处需要进行数据变换
X_train = Features(train_indices,:)'; %% to get out the “row” of train_indices from Features
Y_train = Targets(:,train_indices); %% one-hot encoded Class which has been changed into row, get "column"

% get test data
X_test = Features(test_indices,:)'; %% 30 columns
Y_test = Targets(:,test_indices); %% 30 columns
%%disp(X_test);
%%disp(Y_test);

hidden_units = 2;
net = patternnet(hidden_units);
net.trainParam.showWindow = true; % 显示训练窗口
net.trainParam.epochs = 1000; % 最大训练次数
net.trainParam.lr = 0.01; % 学习率
net.divideParam.trainRatio = 1.0;
%%net.divideParam.valRatio = 0.0;
%%net.divideParam.testRatio = 0.0;
% 输入层：13 个单元。隐藏层：2 个单元。输出层：3 个单元。
[net, tr] = train(net, X_train, Y_train);      
%%trained network is stored in net, training record stored in tr
%in matlab patternnet.train.tr， there are lots of attributes, like: 
% tr.epoch 训练的总迭代数
% tr.perf 每个epoch的训练误差
% tr.vperf 每个epoch的验证误差
% tr.tperf 每个epoch的测试误差
% tr.gradient 每个epoch的梯度值
% tr.num_epochs 实际训练的epoch数量
% tr.best_epoch 达到最佳性能的epoch号

% show error curve
figure;
plot(tr.epoch,tr.perf, 'LineWidth', 2);
xlabel('Epoch');
ylabel('Training Error');
title('Error Curve');
disp(tr.num_epochs);
disp(tr.best_epoch);

% Y_pred：神经网络的输出，通常是一个矩阵，每一行对应一个样本，每一列对应一个类别的概率（或得分）.
Y_pred = net(X_test);  % give test features, to see which class the tested samples belong to ? 
%disp(Y_pred);
%  max(Y_pred) 返回两个值：第一个值（用 ~ 忽略）是每个样本的最大概率值。第二个值（predicted_labels）是每个样本的最大概率值对应的类别索引。
[~, predicted_labels] = max(Y_pred); % Get highest probability class 
% Y_test：实际标签，是 one-hot 编码的矩阵，每一行是一个样本，每一列对应一个类别。
% max(Y_test) 返回两个值：第一个值（用 ~ 忽略）是每个样本的最大值（通常是 1）。第二个值（actual_labels）是每个样本的真实类别索引。
[~, actual_labels] = max(Y_test); % Get actual labels

% show comfusion matrix, confusionmat is matlab function
conf_matrix = confusionmat(actual_labels, predicted_labels); % Compute confusion matrix
disp('Confusion Matrix:');
disp(conf_matrix);

% get hidden unit output 
% IW: input weight, b: bias
hidden_output = net.IW{1} * X_train + net.b{1};  % 1个隐藏层，2个隐藏单元

% plot hidden unit
% the connection between hidden layers & hidden units: 1个隐藏层可以存在多个隐藏单元
figure;
gscatter(hidden_output(1,:)', hidden_output(2,:)', Class(train_indices), 'rgb', 'osd',8);
xlabel('Hidden Unit 1');
ylabel('Hidden Unit 2');
title('Hidden Unit Representations');
legend('Class 1', 'Class 2', 'Class 3');


%% Question 2


BMI_Ranges = [18,20,22,24,26,28,30,32,34,36,38,40];
Cancer = [0,1,4,10,19,19,13,13,4,10,6,1];
No_Cancer = [2,21,60,37,27,26,10,3,8,2,3,1];

Cancer_num = sum(Cancer);
Nocancer_num = sum(No_Cancer);

for i = 1:length(BMI_Ranges)
    TP(i) = sum(Cancer(i:end));   % True Positive 实际癌症，预测癌症数量
    FP(i) = sum(No_Cancer(i:end)); % False Positive 实际非癌症，预测癌症数量
    TN(i) = sum(No_Cancer(1:i)); % True Negative 预测非癌症，实际非癌症数量
    FN(i) = sum(Cancer(1:i)); % False Negative 实际癌症，预测非癌症数量

    FPR(i) = FP(i)/(FP(i)+TN(i)); % FPR = 1- specificity(false positve rate)=FP/FP+TN
    Sensitivity(i) = TP(i)/(TP(i)+FN(i)); % Sensitivity= TP/TP+FN
end 
%disp("TP:",TP);
%disp("FP:",FP);
%disp("TN:",TN);
%disp("FN:",FN);


figure;
plot(FPR, Sensitivity, '-o','LineWidth',2);
xlabel("FPR(1-specificity): False Positive Rate");
ylabel("Sensitivity:True Positive Rate");
title("ROC curve at each BMI level");
grid on;


% repelem(A,B): 按照B的个数，重复A的数值； repelem([18, 20], [2, 1])= [18,18,20]
% give cancer_BMI into a vector = [20,22,22,22,22,24,24,24,24,24,24,...,26,26,26,....26,]
Cancer_BMI = repelem(BMI_Ranges,Cancer); 
% give Nocacer_BMI into a vector=[18,18,20,20,...20,22,22,22....,22,24,24...,24,]
Nocancer_BMI = repelem(BMI_Ranges,No_Cancer); 

% cancer_BMI and nocancer_BMI be listed into a columnn
BMI_data = [Cancer_BMI, Nocancer_BMI]';
% repmat({'cancer'},length(),1): create label 'cancer' for each cancerBMI,
% using ; so cancer and no cancer lable will also be listed into a column
groups = [repmat({'Cancer'},length(Cancer_BMI),1);repmat({'NoCancer'},length(Nocancer_BMI),1)];
%disp(groups);

% Plot boxplot
figure;
boxplot(BMI_data, groups);
xlabel('Cancer & No Cancer');
ylabel('BMI Ranges');
title('BMI Distribution: Cancer vs No Cancer');

%% use perfcurve function
% Define BMI categories
BMI_levels = [17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39];
% Cancer patients at each BMI level
cancer_counts = [0, 1, 4, 10, 19, 19, 13, 13, 4, 10, 6, 1];
% Non-cancer patients at each BMI level
no_cancer_counts = [2, 21, 60, 37, 27, 26, 10, 3, 8, 2, 3, 1];
% Total patients in each BMI level
total_counts = cancer_counts + no_cancer_counts;
% Total number of cancer and non-cancer patients
total_cancer = sum(cancer_counts);       % 100
total_no_cancer = sum(no_cancer_counts); % 200
% Initialize TPR and FPR
TPR = zeros(size(BMI_levels));  % Sensitivity (Recall)
FPR = zeros(size(BMI_levels));  % 1 - Specificity
% Compute True Positives and False Positives at each threshold
for i = 1:length(BMI_levels)
    TP = sum(cancer_counts(i:end));       % Patients correctly identified as cancer
    FP = sum(no_cancer_counts(i:end));    % Non-cancer patients incorrectly classified as cancer
    TPR(i) = TP / total_cancer;           % Sensitivity
    FPR(i) = FP / total_no_cancer;        % 1 - Specificity
end


% Construct labels: 1 for cancer, 0 for no cancer
labels = [ones(1, total_cancer), zeros(1, total_no_cancer)];
% Construct scores: Assign BMI levels as "predicted scores"
scores = [repelem(BMI_levels, cancer_counts), repelem(BMI_levels, no_cancer_counts)];
% Compute ROC curve
[X, Y, ~, AUC] = perfcurve(labels, scores, 1);
% Plot ROC curve
figure;
plot(X, Y, 'b-', 'LineWidth', 2);
xlabel('False Positive Rate (FPR)');
ylabel('True Positive Rate (TPR)');
title(['ROC Curve (AUC = ', num2str(AUC), ')']);
grid on;

% Grouped BMI data for cancer and no cancer patients
cancer_BMI = repelem(BMI_levels, cancer_counts);
no_cancer_BMI = repelem(BMI_levels, no_cancer_counts);
% Create boxplot
figure;
boxplot([cancer_BMI, no_cancer_BMI], [ones(size(cancer_BMI)), zeros(size(no_cancer_BMI))], 'Labels', {'Cancer', 'No Cancer'});
ylabel('BMI');
title('BMI Distribution for Cancer and No Cancer Patients');
grid on;




%% Question 3

train.smat=2*rand(30,2)-1
dtrain = sqrt(diag(train.smat*train.smat'));
train.tmat=(dtrain<.85).*(dtrain>.45)
ktrain=[train.tmat,zeros(30,1),1-train.tmat];

figure
scatter(train.smat(:,1),train.smat(:,2),300,ktrain,'filled')

test.smat=2*rand(20,2)-1
dtest = sqrt(diag(test.smat*test.smat'));
test.tmat=(dtest<.85).*(dtest>.45)
ktest=[test.tmat,zeros(20,1),1-test.tmat];

hold on
scatter(test.smat(:,1),test.smat(:,2),100,ktest,'filled')

-------- teacher's answer------

n0=initnet3(2,4,1,3,3,133)
nf=bp3(n0,train,15000,.05,0)
af=forw3(nf,test) ;
[X,Y,T,AUC] = perfcurve(test.tmat,af.out,1);

----------nan's answer-------
% initialize the training network:  2 inputs（x&y）, 4 hidden units, 1 output
net0=initnet3(2,4,1,2,2,10);

% train the network 
net15k=bp3(net0,train,15000,.05,0,10);

% test it
% act15k is a vector with the 概率值
act15k=forw3(net15k,test);
act15k.out; % 不确定此值有没有归一化处理，是否在0-1之间？？？

% figure out ROC curve
% ROC: x:FPR(false positive rate): FP/FP+TN; Y: Sensitivity: TP/TP+FN true
% positve rate
% for this quesiton, the BMI groups change into X from 0-1
% cancer and nocancer change into predict right or wrong 
thresholds = linspace(0,1,50);
TPR = zeros(size(thresholds));
FPR = zeros(size(thresholds));
for i = 1:length(thresholds)
    predictions = (act15k.out >= thresholds(i)); %根据阈值，对比test数据的所有概率，大于阈值的为1， 反则为0
    TP = sum((predictions == 1) & (test.tmat == 1));  % predict: 1 real: 1
    TN = sum((predictions == 0) & (test.tmat == 0));  % predict: 0 real: 0
    FP = sum((predictions == 1) & (test.tmat == 0));  % predict: 1 real: 0
    FN = sum((predictions == 0) & (test.tmat == 1));  % predict: 0 real: 1
    
    TPR(i) = TP/(TP+FN);    % TPR = TP / TP + FN;
    FPR(i) = FP/(FP+TN);    % FPR = FP / FP + TN;
end

figure;
plot(FPR,TPR, '-o','LineWidth',2);
xlabel("FPR(1-specificity): False Positive Rate");
ylabel("Sensitivity:True Positive Rate");
title("ROC curve for test set");
grid on;



