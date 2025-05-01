%输入extin,外部输入，通常为0，表示无外部输入
%输入initact,网络初始状态
%输入conmat,权重矩阵
%输入dt,时间步长
%输入niter,迭代次数
% 输出finalact， 更新后的网络状态
%功能：通过多次调用iaciter函数，迭代更新网络状态finalact,使其收敛到稳定态
function finalact=iacn(extin,initact,conmat,dt,niter)
finalact=initact;
for k=1:niter
finalact=iaciter(extin,finalact,conmat,dt);
end
end