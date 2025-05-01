%% quiverplots
function qv = qplot( cmat,cvec,rang )
%This function generates a quiver plot for the linear system
%specified by cmat. rang is the range (for both x and y)
[xx yy] = meshgrid(rang) ;
qx=cmat(1,1)*xx+cmat(1,2)*yy+cvec(1,1) ; 
qy=cmat(2,1)*xx+cmat(2,2)*yy+cvec(2,1) ;
quiver(xx,yy,qx,qy,'black') ;
axis equal
axis([[rang(1) rang(end)],[rang(1) rang(end)]]) ;
end