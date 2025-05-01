%% Assignment 5 DinaDing %%

%% Question 1
%% For XOR, the connection for x1,x2 and y are show below:
%% if x1 x2    x1+x2    Raw(h)=x1+x2-0.5      h      Raw(y)=x1+x2-2h      y
%%    0  0       0          0                 0          0                0  
%%    0  1       1          0.5               1          -1               1
%%    1  0       1          0.5               1          -1               1
%%    1  1       2          1.5               1          0                0
%%  Without hidden layer, we can not get y from x1,x2 directly,since XOR is not linearly separable.
%%  By using hidden layer,we can tranform the inputs x1,x2 into a new space to get XOR
%%  Assume h=x1+x2-0.5, if we use TLU model(threshold linear unit)(<0,=0; >=0,=1),we can get h=0,1,1,1 
%%  Assume y=x1+x2-2h, if we use TLU again(<0,=1;>=0,=0), we can get y=0,1,1,0

x = [0,0;0,1;1,0;1,1];
y = [0;1;1;0];
weight_hidden=[1,1];
bias_hidden=-0.5;

h_raw=x*weight_hidden'+bias_hidden;
h=h_raw>=0;

y_raw=x(:,1)+x(:,2)-2*h;
y=y_raw<0;

disp('Predicted XOR outputs:');
disp(y);




%% Question 2

% define the input stimulas and target
task2.smat=[[0,0,0];[0,0,1];[0,1,0];[1,0,0];[0,1,1];[1,0,1];[1,1,0];[1,1,1]];
task2.tmat=[0,1,1,1,1,1,1,0]';
[task2.smat,task2.tmat];

% initialize the network 3 inputs, 2 hiddens, 1 output
task2net0=initnet3(3,2,1,2,2,0);

% train the network 
net20k=bp3(task2net0,task2,20000,.02,0,0);

% test it
act20k2=forw3(net20k,task2)
act20k2.out

% figure out
kolor=[task2.tmat,zeros(size(task2.tmat)),1-task2.tmat]
jitter_strength=0.05;
%scatter(act20k2.hid(:,1)+jitter_strength*randn(size(act20k2.hid(:,1))), ...
%        act20k2.hid(:,2)+jitter_strength*randn(size(act20k2.hid(:,2))), ...
%       200,kolor,'filled');
scatter(act20k2.hid(:,1),act20k2.hid(:,2),100,kolor,'filled');
title("hidden units scatterplot");
xlabel("hidden unit 1");
ylabel("hidden unit 2");

