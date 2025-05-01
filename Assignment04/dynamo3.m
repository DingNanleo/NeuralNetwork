%% dynamo3 function
function ptseq = dynamo3( initial,step,niter,cmtx )
curr = initial' ;
ptseq = initial';
ha=scatter(initial(1),initial(2),150,'Filled') ;
for i=1:niter
    curr=onestep(curr,cmtx,[0 0]',step) ;
    ptseq=[ptseq,curr];
end
plot(ptseq(1,:),ptseq(2,:)) ;
axis equal
end


function newx = onestep( oldx,cmat,cvec,dt)
newx=oldx+(cmat*oldx+cvec)*dt ;
end