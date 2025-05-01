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
