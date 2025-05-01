%% Assignment 4 DinaDing %%

%% Question 1
M = [[-1 2];[-1 -2]];
dynamo4x([-3:.1:3],.02,1000,M,[0 0]');  % for dynamo4x function, please see below.
[Tr,Det,Type] = Trace_Determinant(M);    % for Trace_Determinant function, please see below.


%% Question 2
M2=[[1 -2];[1 2]];
dynamo4x([-3:.1:3],.02,1000,M2,[0 0]');
[Tr,Det,Type] = Trace_Determinant(M2);


%% Question 3
x=[0,.1,1];
y=[0,1,1];
linear_fit=polyfit(x,y,1);
second_fit=polyfit(x,y,2);
x_fit=linspace(-.1,1.1,100);  % generate points for plotting the fits
y_linear=polyval(linear_fit,x_fit);
y_second=polyval(second_fit,x_fit);

figure;
hold on;
scatter(x,y,'MarkerFaceColor','r');
plot(x_fit,y_linear,"linewidth",2);
plot(x_fit,y_second,"LineWidth",2);
legend('Data points','Linear fit','2nd order fit');
xlabel('x');
ylabel('y');
title('Linear and 2nd order fit');
grid on;
hold off;

%% for dynamo4x function
function ptseq = dynamo4x( rang,step,niter,cmtx,cvct )
figure
xinit=[rang rang rang(1)*ones(size(rang)) rang(end)*ones(size(rang))];
yinit=[rang(1)*ones(size(rang)) rang(end)*ones(size(rang)) rang rang];
[xcr,ycr] = meshgrid(linspace(rang(1),rang(end),100));
nullx=cmtx(1,1)*xcr+cmtx(1,2)*ycr+cvct(1,1);
nully=cmtx(2,1)*xcr+cmtx(2,2)*ycr+cvct(2,1);
% size(xinit)
for k=1:max(size(xinit))
    ptseq = [xinit(k);yinit(k)];
    curr = [xinit(k);yinit(k)];
    for i=1:niter
        curr=onestep(curr,cmtx,cvct,step);
        ptseq=[ptseq,curr];
    end
    plot(ptseq(1,:),ptseq(2,:),'blue');
    axis equal;
    hold on;
end
axis([rang(1) rang(end) rang(1) rang(end)]);
contour(xcr,ycr,nullx,[0 0],'red','LineWidth',2) ;
contour(xcr,ycr,nully,[0 0],'red','LineWidth',2) ;
qplot(cmtx,cvct,rang(1):.5:rang(end))
end

%% Trace and Determinant
function [Tr Det Type] = Trace_Determinant(M)
Tr=M(1,1)+M(2,2);
Det=M(1,1)*M(2,2)-M(1,2)*M(2,1);
if Tr > 0
    if Tr^2>4*Det
        Type = 0;   % unstable
    else 
        Type = 1;   % unstable spirals
    end
elseif Tr < 0
    if Tr^2>4*Det
        Type = 2;   % stable
    else
        Type = 3;   % stable spirals
    end
elseif Tr == 0
    if Det >0
        Type =4;   % Det saddles
    else 
        Type =5;   % Tr saddles
    end
end

fprintf("Type0: unstable ; Type1: unstable spirals; Type2: stable; Type3: stable spirals; Type4: Det saddles; Type5:Tr saddles  \n");
fprintf("Trace : %.2f, Determinant : %.2f, Type: %d\n",Tr,Det,Type);
end


