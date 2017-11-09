function [ Accel, LAccel, LAccelW, G, Gyro, Mag, Q, Heading, avgDt, totalTime]  = loadDMPSensorsData( file_name )
% Load raw accelerometer, gyrosope & magnetometer data acquired on Arduino.
% sampleCnt:1
% dt:0.0040
% T_a:8,-32,16272
% T_m:81,-6,-423
% T_g:29,11,3

fileID = fopen(file_name);
tline = fgetl(fileID);
sampleCount = 0;
dt = 0;
avgDt = 0;
timeT = 0;
while ~feof(fileID)
    if strncmpi(tline, 'dt:', 3) == 1
       A = sscanf(tline, 'dt:%f');
       [m,n] = size(A);
       if m == 1
          dt = A;
          avgDt = avgDt + dt;
          timeT = timeT + dt;
          sampleCount = sampleCount + 1;
       end
    elseif strncmpi(tline, 'accel:', 6) == 1
       A = sscanf(tline, 'accel:%d,%d,%d');
       [m,n] = size(A);
       if m == 3
          Accel(sampleCount,:) = [A;timeT;dt];
       end    
    elseif strncmpi(tline, 'laccel:', 7) == 1
       A = sscanf(tline, 'laccel:%d,%d,%d');
       [m,n] = size(A);
       if m == 3
          LAccel(sampleCount,:) = [A;timeT;dt];
       end  
    elseif strncmpi(tline, 'laccelw:', 8) == 1
       A = sscanf(tline, 'laccelw:%d,%d,%d');
       [m,n] = size(A);
       if m == 3
          LAccelW(sampleCount,:) = [A;timeT;dt];
       end  
    elseif strncmpi(tline, 'g:', 2) == 1
       A = sscanf(tline, 'g:%f,%f,%f');
       [m,n] = size(A);
       if m == 3
          G(sampleCount,:) = [A;timeT;dt];
       end  
    elseif strncmpi(tline, 'gyro:', 5) == 1
       A = sscanf(tline, 'gyro:%d,%d,%d');
       [m,n] = size(A);
       if m == 3
          Gyro(sampleCount,:) = [A;timeT;dt];
       end
    elseif strncmpi(tline, 'mag:', 4) == 1
       A = sscanf(tline, 'mag:%f,%f,%f');
       [m,n] = size(A);
       if m == 3
          Mag(sampleCount,:) = [A;timeT;dt];
       end
    elseif strncmpi(tline, 'q:', 2) == 1
       A = sscanf(tline, 'q:%f,%f,%f,%f');
       [m,n] = size(A);
       if m == 4
          Q(sampleCount,:) = [A;timeT;dt];
       end   
    elseif strncmpi(tline, 'heading:', 8) == 1
       A = sscanf(tline, 'heading:%f');
       [m,n] = size(A);
       if m == 1
          Heading(sampleCount,:) = [A;timeT;dt];
       end
    elseif strncmpi(tline, 'TotalTime:', 10) == 1
       A = sscanf(tline, 'TotalTime:%f');
       [m,n] = size(A);
       if m == 1
          totalTime = A;
       end
    end
    tline = fgetl(fileID);
end
avgDt = avgDt / sampleCount;
fclose(fileID);

end

