function [ info ] = genSampleAccelData( tempTotal, dt, distance )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

d1 = 0.0;
d2 = distance;
t1 = 0.0;
t2 = tempTotal;
numSample = tempTotal / dt;
ds = distance / numSample;


info = zeros(numSample, 4);
    info(1, 1) = 0;%accel
    info(1, 2) = 0;%vel
    info(1, 3) = 0;%pos
    info(1, 4) = 0;%temps
    
    d1 = d1 + ds*rand;
    t1 = t1 + dt; 
    
    ds = (distance - d1)/(numSample-1);
    
for i = 2:numSample
    info(i, 3) = d1;
    info(i, 4) = t1;
    
    info(i, 2) = (info(i, 3) - info(i-1, 3)) / dt;
    info(i, 1) = (info(i, 2) - info(i-1, 2)) / dt;
    
    d1 = d1 + ds;
    
    if mod(clock,2) == 0
        d1 = d1 - ds * rand;
    else
        d1 = d1 + ds * rand;
    end
    
    ds = (distance - d1)/(numSample-i);
    t1 = t1 + dt;
end


% accel = zeros(numSample, 3);
%     accel(1, 1) = 0;
%     accel(1, 2) = 0;
%     accel(1, 3) = 0;
%     d1 = d1 + ds*rand;
%     t1 = t1 + dt; 
%     
%     ds = (distance - d1)/(numSample-1);
%     
% for i = 2:numSample
%     accel(i, 1) = 2.0*(d2-d1)/(t2^2 - t1^2);
%     accel(i, 2) = d1;
%     accel(i, 3) = t1;
%     
%     d1 = d1 + ds;
%     
%     if mod(i,2) == 0
%         d1 = d1 - ds * rand;
%     else
%         d1 = d1 + ds * rand;
%     end
%     
%     ds = (distance - d1)/(numSample-i);
%     t1 = t1 + dt;
% end

end

