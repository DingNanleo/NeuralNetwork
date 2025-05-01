%% dynamo funcitons with decay term (2D)
function ptseq = dynamo2(initial,step,niter,decay)
ptseq=initial ;
curr = initial ;
for i=1:niter
    curr=newstate(curr,step,decay);
    ptseq=[ptseq;curr] ;
end
plot(ptseq(:,1),ptseq(:,2)) ;
hold on
axis equal
end

function newx = newstate(oldx,step,dk)
newx(1)=oldx(1)-oldx(2)*step - dk*oldx(1)*step;
newx(2)=oldx(2)+oldx(1)*step - dk*oldx(2)*step;
end 
