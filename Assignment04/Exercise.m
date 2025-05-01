%% Exercise

%% dynamo1D
dts=[1 .5 .25];
figure
for k=1:3
    dynamo1D(1,1,dts(k),3);
    hold on;
end
xv=linspace(0,3,50);
yv=exp(xv);
plot(xv,yv);

%% dynamo (2D)
dynamo([.7 .7],.02,1000)
dynamo([-.7 .7],.02,1000)

%% dynamo with decay  (2D)
dynamo2([-.7 .7],.02,1000,.03);
dynamo2([-.7 .7],.02,1000,.005);
dynamo2([-.7 .7],.02,1000,.001);


%% dynamo3
cmat=[[-.3 1];[-1 -.3]];
dynamo3([-2 2],.02,3000,cmat);
dynamo3([2 -2],.02,3000,cmat);
hold on
qplot(cmat,[0 0]',[-3:.5:3]);

%% dynamo4x
M = [[-1 2];[-1 -2]];
dynamo4x([-3:.1:3],.02,1000,M,[0 0]');
Trace_Determinant(M);

%% quiverplots
A=[[0 1];[-1 0]];
k=[0 0]';
qplot(A,k,[-2:.5:2]);

%% gravity example
gravity(100,0,-9.8,4,.5);
