% 基于反向传播back propagation算法的一个神经网络模型
% net0: 初始神经网络
% patstr: 训练数据集
% niter: 训练的迭代次数
% eta: 学习率，即步长
% nlev: 
% rs: random seed,随机种子，控制随机数生成器的初始化，保证实验的可重复性

function finalnet=bp3(net0,patstr,niter,eta,nlev,rs)
rng(rs) ;
netk=net0;
for i=1:niter
    netk=cyc3(netk,patstr,eta,nlev) ;
end
finalnet=netk;