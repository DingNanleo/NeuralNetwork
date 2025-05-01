function newx = onestep( oldx,cmat,cvec,dt)
newx=oldx+(cmat*oldx+cvec)*dt ;
end
