%% Trace and Determinant
function [Tr Det Type] = Trace_Determinant(M)
Tr=M(1,1)+M(2,2);
Det=M(1,1)*M(2,2)-M(1,2)*M(2,1);
if Tr > 0
    if Tr^2>4*Det
        Type = 0;   % unstable
    else 
        Type = 1;   % unstable spirals
    end
elseif Tr < 0
    if Tr^2>4*Det
        Type = 2;   % stable
    else
        Type = 3;   % stable spirals
    end
elseif Tr == 0
    if Det >0
        Type =4;   % Det saddles
    else 
        Type =5;   % Tr saddles
    end
end

fprintf("Type0: unstable ; Type1: unstable spirals; Type2: stable; Type3: stable spirals; Type4: Det saddles; Type5:Tr saddles  \n");
fprintf("Trace : %.2f, Determinant : %.2f, Type: %d\n",Tr,Det,Type);
end

