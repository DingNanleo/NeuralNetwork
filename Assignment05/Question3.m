%% Assignment 5 DinaDing %%

%% Question 3
% define the input stimulas and target 16 patterns
task3.smat=[[0,0,0,0];[0,0,0,1];[0,0,1,0];[0,1,0,0];[1,0,0,0];
            [1,1,0,0];[1,0,1,0];[1,0,0,1];[0,1,1,0];[0,1,0,1];
            [0,0,1,1];[1,1,1,0];[1,1,0,1];[1,0,1,1];[0,1,1,1];[1,1,1,1]]
task3.tmat=[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0]';
[task3.smat,task3.tmat];

% initialize the network, 4 inputs, 2 hiddens, 1 outputs
task3net0=initnet3(4,2,1,2,2,0);

% train the network 
net20k=bp3(task3net0,task3,20000,.05,0,0);

% test it
act20k3=forw3(net20k,task3)
act20k3.out

% figure out
kolor=[task3.tmat,zeros(size(task3.tmat)),1-task3.tmat]
jitter_strength=0.05;
%scatter(act20k3.hid(:,1)+jitter_strength*randn(size(act20k3.hid(:,1))), ...
 %       act20k3.hid(:,2)+jitter_strength*randn(size(act20k3.hid(:,2))), ...
%        200,kolor,'filled');
scatter(act20k3.hid(:,1),act20k3.hid(:,2),100,kolor,'filled');
title("hidden units scatterplot");
xlabel("hidden unit 1");
ylabel("hidden unit 2");
colorbar;