function [ retM ] = EMA( M, alpha, init )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
retM = M;

[m,n] = size(M);

for i = 1:n
    filt = init;
    for j = 1:m
        filt = (1 - alpha)*filt + alpha*M(j,i);
        retM(j,i) = filt;
    end
end

end

