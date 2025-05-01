function ptseq = dynamo1D(initial,alpha,step,duration)
ptseq = [0,initial] ;
curr = initial ;
for t=step:step:duration
   curr=curr+step*alpha*curr ;
   ptseq=[ptseq;[t,curr]] ;
end
plot(ptseq(:,1),ptseq(:,2)) ;
end
