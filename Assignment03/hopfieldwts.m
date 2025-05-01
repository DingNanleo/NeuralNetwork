function hmtx=hopfieldwts(nc,mag,distances)
% nc = number of cities
% mag = magnitude of constraint (usually between 10 and 50)
% matrix is [target (city, position), source (target, position) ]
hmtx=zeros(nc,nc,nc,nc) ;
% 4维矩阵，1st:城市，2nd位置，3rd源城市，4th源位置
mdist=max(max(distances)) ;
nsd=10.0 ;
revdist=10*(mdist-distances+1).*(mdist-distances+1)/(mdist*mdist) ;
%计算反向距离矩阵 revdist，用于表示路径长度的权重
%revdist=0.1+10*exp(-distances.*distances/(mdist*mdist/(nsd*nsd))) ;
%revdist=0.1./(0.1+distances.*distances) ;
for j=1:nc
hmtx(j,:,j,:)=mag*(eye(nc)-1) ;
hmtx(:,j,:,j)=mag*(eye(nc)-1) ;
end
for j=2:nc
for k=1:(j-1)
% for each distance in the matrix distances
for m1=1:nc
m2=1+mod(m1,nc) ;
hmtx(j,m1,k,m2) = revdist(j,k) ;
hmtx(k,m1,j,m2) = revdist(j,k) ;
hmtx(j,m2,k,m1) = revdist(j,k) ;
hmtx(k,m2,j,m1) = revdist(j,k) ;
end
end
end
end