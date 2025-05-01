% This function takes two inputs:
        % netwk → A neural network structure containing weights and biases.
        % pats → A structure containing input patterns (pats.smat).
% It returns netact, a structure that contains:
        % The stimulus (input data)
        % The hidden layer activations
        % The output layer activations

function netact=forw3(netwk,pats)
netact.stim=pats.smat;
netact.hid=layersigpn(netact.stim,netwk.wih,netwk.hbias) ;
netact.out=layersig01(netact.hid,netwk.whout,netwk.obias) ;
end