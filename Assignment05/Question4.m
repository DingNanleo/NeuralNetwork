%% Assignment 5 DinaDing %%

%% Question 4
% Train a network on the XOR task.  
% Plot the representations of the training set in the hidden unit space. 
% Challenge: Create a contour plot of the output unit's response in the 
% stimulus space.

% define the input stimulas and target
xor_data.smat=[[0,0];[0,1];[1,0];[1,1]];
xor_data.tmat=[0,1,1,0]';

[xor_data.smat,xor_data.tmat];

% initialize the network, 2 inputs, 2 hiddens, 1 outputs
xornet=initnet3(2,2,1,3,3,0);

% train the network 
nf=bp3(xornet,xor_data,30000,.005,0,0);

% test it
act20k4=forw3(nf,xor_data);
act20k4.out

% figure out
kolor=[xor_data.tmat,zeros(size(xor_data.tmat)),1-xor_data.tmat];
jitter_strength=0.05;
figure;
%scatter(act20k4.hid(:,1)+jitter_strength*randn(size(act20k4.hid(:,1))), ...
%        act20k4.hid(:,2)+jitter_strength*randn(size(act20k4.hid(:,2))), ...
%        200,kolor,'filled');
scatter(act20k4.hid(:,1),act20k4.hid(:,2),100,kolor,'filled');
title("hidden units scatterplot for XOR");
xlabel("hidden unit 1");
ylabel("hidden unit 2");
colorbar;

% create contour plot in stimulus space
x1=linspace(0,1,100);
x2=linspace(0,1,100);
[x1,x2]=meshgrid(x1,x2);

grid_input=[x1(:),x2(:)];
% struct('smat', grid_input) 创建了一个结构体，其中字段 smat 的值为 grid_input。
% grid_input 是输入空间的网格点，格式为 N×2 的矩阵（N是网格点的数量）。
% 为什么需要：forw3 函数可能期望输入是一个结构体，其中包含字段 smat（类似于 xor_data 的结构）。
% 通过 struct('smat', grid_input)，将网格点数据包装成与训练数据相同的格式，以便 forw3 函数能够处理。
grid_act=forw3(nf,struct('smat',grid_input));
%grid_act=forw3(nf,grid_input);
grid_output=grid_act.out;


%contourf 函数需要输入一个二维矩阵来绘制等高线图。通过 reshape，
% 将 grid_output（原本是一个N*1的矩阵） 转换为 100×100的矩阵，以便与 x1 和 x2 对应
z=reshape(grid_output,size(x1));

figure;
contourf(x1,x2,z,20,'LineColor','none');
title('Contour plot for output response in stimulus space');
xlabel('input 1');
ylabel('input 2');
colorbar;