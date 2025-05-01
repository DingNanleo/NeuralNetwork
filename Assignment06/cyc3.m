%% core function (each iteration) for bp3(traning, backpropagation)model
% Computes forward propagation (calculates predictions).
% Calculates error (difference between actual and expected output).
% Backpropagates error (adjusts weights using gradient descent).
% Updates the weights

% nstruct → The current neural network structure (weights & biases).
% pstruct → The training data structure, containing:
        % pstruct.smat: Input patterns (stimulus matrix).
        % pstruct.tmat: Corresponding target outputs.
% dt → The learning rate (step size for weight updates).
% noi → A parameter possibly controlling noise level in training.


function newstruct=cyc3(nstruct,pstruct,dt,noi)
newstruct=nstruct;
szs=size(pstruct.smat);
patk=ceil(szs(1)*rand());
activity=forw1p3(nstruct,pstruct,patk,noi);
odelt=(pstruct.tmat(patk,:)-activity.out); %output deltas
hdelt=0.5*(nstruct.whout'*odelt').*(1+activity.hid').*(1-activity.hid');%hid deltas
%adjust weights and biases
newstruct.whout=newstruct.whout+dt*odelt'*activity.hid;
newstruct.obias=newstruct.obias+dt*odelt ;
newstruct.wih=newstruct.wih+dt*hdelt*activity.stim;
newstruct.hbias=newstruct.hbias+dt*hdelt' ;
end