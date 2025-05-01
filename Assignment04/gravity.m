%% gravity example
function slist = gravity( xinit, vinit, acc, duration, eta )
%describes one iteration of a falling object
xx=xinit ;
vv=vinit ;
slist=[0,0,0,vinit,xinit];
for ii=0:eta:duration
    dv = eta*acc ;
    dx = eta*vv ;
    vv=vv+dv ;
    xx=xx+dx ;
    slist=[slist;[ii,dv,dx,vv,xx]];
end
plot(slist(:,1),slist(:,5),'b','LineWidth',3) ;
hold on
xp=linspace(0,duration,100) ;
yp=xinit+vinit*xp+.5*acc*xp.*xp ; % exact solution
plot(xp,yp,'r') ;
end