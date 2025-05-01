
%% Assignment 3 DinaDing %%
%% Question 1 %%
% Define 4 x 8 matrix pn representing the patterns 
pn=[1,1,-1,-1,-1,-1,-1,1; % First pattern (random noise)
    -1,1,1,1,-1,-1,1,-1; % Second pattern (circular shape)
    -1,-1,1,1,1,-1,-1,-1; % Third pattern (triangular shape)
    1,-1,-1,1,-1,1,-1,1]; % Fourth pattern (square shape)
disp('Matrix pn:');
disp(pn);

%% Question 2 %%
% compute the Hopfield weight matrix using the memstor function
function mem=memstor(parts)
% each row of the matrix pats is a pattern
[np nd]=size(parts);
mem=zeros(nd);
for i=1 :nd
    for j=1:nd
        if(i~=j)for k=1:np
                mem(i,j)=mem(i,j)+parts(k,i)*parts(k,j);
        end
        end
    end
end
end

w=memstor(pn);
disp('Hopfield Weight Matrix w:');
disp(w);

%% Question 3 %%
function gvals = goodness( hopnet )
%calculates goodness for all patterns in a Hopfield Network
gvals=[];
pmat=[] ;
netsize=size(hopnet,1) ;
for k=0:(2^netsize-1) 
    binaryStr = dec2bin(k, netsize);
    pvec = 2 * double(binaryStr - '0') - 1; % Convert to ±1
    %pvec=2*dec2bin(k,netsize)-1 ;
    %pvec=pvec([end:-1:1]) ;
    pmat=[pmat;pvec];
    g=0;
    for i=1:(netsize-1)
        for j=(i+1):netsize
            g=g+hopnet(i,j)*pvec(i)*pvec(j) ;
        end
    end
    gvals=[gvals, g] ;
    
end
gvals=gvals';
[pmat,gvals]; 
end

[gvals]=goodness(w);
disp('Display Goodness values for all possible patterns:');
disp(max(gvals));
disp(min(gvals));


%% Question 4 %%
% Generate a boxplot or histogram that shows the distribution of Goodness values across all 28 binary patterns
% Generate a Boxplot 
figure;
boxplot(gvals, 'Labels', {'Goodness Values'});
title('Boxplot of Goodness Values for All 256 Binary Patterns');
ylabel('Goodness Value (Energy)');
grid on;

% Generate a histogram 
figure;
histogram(gvals, 20); % Histogram with 20 bins
title('Distribution of Goodness Values for All Patterns');
xlabel('Goodness Value (Energy)');
ylabel('Frequency');
grid on;


%% Question 5 %%
% Using hopupdate.m and the Necker cube weights (both from the slide set), 
% run a Hopfield net for many iterations and interpret the result.  
% (show a printout of the final activities -- a plot is great, just numbers is sufficient)

% Define the necker cude weight
 hmat = [
 0.0  1.0  1.0  0.0  1.0  0.0  0.0  0.0 -1.5  0.0 -1.5  0.0  0.0  0.0  0.0  0.0
 1.0  0.0  0.0  1.0  0.0  1.0  0.0  0.0  0.0 -1.5  0.0 -1.5  0.0  0.0  0.0  0.0
 1.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0 -1.5  0.0 -1.5  0.0  0.0  0.0  0.0  0.0
 0.0  1.0  1.0  0.0  0.0  0.0  0.0  1.0  0.0 -1.5  0.0 -1.5  0.0  0.0  0.0  0.0
 1.0  0.0  0.0  0.0  0.0  1.0  1.0  0.0  0.0  0.0  0.0  0.0 -1.5  0.0 -1.5  0.0
 0.0  1.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0  0.0  0.0  0.0  0.0 -1.5  0.0 -1.5
 0.0  0.0  1.0  0.0  1.0  0.0  0.0  1.0  0.0  0.0  0.0  0.0 -1.5  0.0 -1.5  0.0
 0.0  0.0  0.0  1.0  0.0  1.0  1.0  0.0  0.0  0.0  0.0  0.0  0.0 -1.5  0.0 -1.5
-1.5  0.0 -1.5  0.0  0.0  0.0  0.0  0.0  0.0  1.0  1.0  0.0  1.0  0.0  0.0  0.0
 0.0 -1.5  0.0 -1.5  0.0  0.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0  1.0  0.0  0.0
-1.5  0.0 -1.5  0.0  0.0  0.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0
 0.0 -1.5  0.0 -1.5  0.0  0.0  0.0  0.0  0.0  1.0  1.0  0.0  0.0  0.0  0.0  1.0
 0.0  0.0  0.0  0.0 -1.5  0.0 -1.5  0.0  1.0  0.0  0.0  0.0  0.0  1.0  1.0  0.0
 0.0  0.0  0.0  0.0  0.0 -1.5  0.0 -1.5  0.0  1.0  0.0  0.0  1.0  0.0  0.0  1.0
 0.0  0.0  0.0  0.0 -1.5  0.0 -1.5  0.0  0.0  0.0  1.0  0.0  1.0  0.0  0.0  1.0
 0.0  0.0  0.0  0.0  0.0 -1.5  0.0 -1.5  0.0  0.0  0.0  1.0  0.0  1.0  1.0  0.0
 ];

 function newact = hopupdate( hmat,oldact,niter)
% hopfield updates for a fixed number of iterations
% (not the traditional stopping criterion)
newact=oldact ;
for ii=1:niter
    %rrownum=randi([1,size(hmat,1)],1) ;
    %if (hmat(rrownum,:)*newact>0) newact(rrownum)=1 ;
    rrownum=randi(size(hmat,1)) ;
    if (hmat(rrownum,:)*newact>0) newact(rrownum)=1 ;
    else newact(rrownum)=-1 ;
    end
end
end

% Initial state of the network (random activation)
oldact = 2 * randi([0, 1], 16, 1) - 1; % Generates random state (-1 or +1)

% Number of iterations to run the network
niter = 100;

% Call hopupdate function
final_state = hopupdate(hmat, oldact, niter);

% Display final state
disp('Final state after iterations:');
disp(final_state');

% Plot the final state
figure;
plot(final_state, 'o-', 'LineWidth', 2);
title('Final Activity of Neuron States');
xlabel('Neuron Index');
ylabel('Neuron Activity');
grid on;



%% Question 6 %%
% Replicate the TSP example from the slides using a set of 6 random cities (instead of 7)

locations=rand(6,2); % creates 6 random locations
scatter(locations(:,1),locations(:,2),400,'red','filled');
dmat=squareform(pdist(locations));

disp('Display dmat:');
disp(dmat);
disp('Display locations:');
disp(locations);

tspmat=hopfieldwts(6,40,dmat); % 用hopfield 获得权重矩阵
iacn(.05*rand(6,6),0.2*rand(6,6),tspmat,.05,100000) 
%输入extin,外部输入，通常为0，表示无外部输入
%输入initact,网络初始状态
%输入conmat,权重矩阵
%输入dt,时间步长
%输入niter,迭代次数
% 输出finalact， 更新后的网络状态
%功能：通过多次调用iaciter函数，迭代更新网络状态finalact,使其收敛到稳定态
% function finalact=iacn(extin,initact,conmat,dt,niter)

rseq=[3 6 1 5 4 2];
hold on;
plot(locations(rseq,1),locations(rseq,2),'k');

%% Question 7 %%
%running tsp.m and try differetn input for locations and magnitudes, please
%see the jpg file ,the figure saved for Q7.