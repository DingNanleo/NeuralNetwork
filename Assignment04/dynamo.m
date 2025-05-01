function ptseq = dynamo(initial,step,niter)
ptseq=initial ;
curr = initial ;
for i=1:niter
    curr=circle(curr,step) ;
    ptseq=[ptseq;curr] ;
end
plot(ptseq(:,1),ptseq(:,2)) ;
end


function newx = circle(oldx,step)
vel(1) = -oldx(2) ;
vel(2) = oldx(1) ;
newx = oldx + vel*step ;
end 
