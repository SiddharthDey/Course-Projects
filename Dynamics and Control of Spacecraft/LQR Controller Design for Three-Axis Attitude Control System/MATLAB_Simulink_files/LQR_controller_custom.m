clc, clear, close all;

A = [ 0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;
1.807*10^-8 0 0 0 0 1.07*10^-3;0 3.171*10^-8 0 0 0 0;
0 0 1.989*10^-8 -1.892 0 0 ];
B = [ 0 0 0;0 0 0;0 0 0; 0.102 0 0; 0 0.103 0; 0 0 0.103];
C = [ 0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1 ];
D = [ 0 0 0;0 0 0;0 0 0; 0 0 0;0 0 0;0 0 0];

Qs = [1 2 3 4 5 6 7 8];
Rs = [0.1 5 10];
mat_data = zeros(24,11);
count = 1;
for Q_cur = Qs
    for R_cur = Rs
      Q = Q_cur*diag([1, 1, 1, 1, 1, 1]);
      R = R_cur*diag([1, 1, 1]);
      [K,S,e] = lqr(A,B,Q,R); 
      sim('LQR_State_Space.slx');
      roll_rate = stepinfo(roll_rate.data,roll_rate.time);
      pitch_rate = stepinfo(pitch_rate.data,pitch_rate.time);
      yaw_rate = stepinfo(yaw_rate.data,yaw_rate.time);
      mat_data(count,1) = roll_rate.Peak;
      mat_data(count,2) = roll_rate.RiseTime;
      mat_data(count,3) = roll_rate.SettlingTime;
      mat_data(count,4) = pitch_rate.Peak;
      mat_data(count,5) = pitch_rate.RiseTime;
      mat_data(count,6) = pitch_rate.SettlingTime;
      mat_data(count,7) = yaw_rate.Peak;
      mat_data(count,8) = yaw_rate.RiseTime;
      mat_data(count,9) = yaw_rate.SettlingTime;
      mat_data(count,10) = Q_cur;
      mat_data(count,11) = R_cur;
      count = count + 1;
    end
end
%% 
[roll_rate_peak_min,roll_rate_peak_min_ind] = min(mat_data(:,1));
[roll_rate_RiseTime_min,roll_rate_RiseTime_min_ind] = min(mat_data(:,2));
[roll_rate_SettlingTime_min,roll_rate_SettlingTime_min_ind] = min(mat_data(:,3));

[pitch_rate_peak_min,pitch_rate_peak_min_ind] = min(mat_data(:,4));
[pitch_rate_RiseTime_min,pitch_rate_RiseTime_min_ind] = min(mat_data(:,5));
[pitch_rate_SettlingTime_min,pitch_rate_SettlingTime_min_ind] = min(mat_data(:,6));

[yaw_rate_peak_min,yaw_rate_peak_min_ind] = min(mat_data(:,7));
[yaw_rate_RiseTime_min,yaw_rate_RiseTime_min_ind] = min(mat_data(:,8));
[yaw_rate_SettlingTime_min,yaw_rate_SettlingTime_min_ind] = min(mat_data(:,9));
