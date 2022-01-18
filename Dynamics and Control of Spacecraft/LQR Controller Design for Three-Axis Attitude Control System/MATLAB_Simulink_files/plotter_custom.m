clc,close;
A = [ 0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;
1.807*10^-8 0 0 0 0 1.07*10^-3;0 3.171*10^-8 0 0 0 0;
0 0 1.989*10^-8 -1.892 0 0 ];
B = [ 0 0 0;0 0 0;0 0 0; 0.102 0 0; 0 0.103 0; 0 0 0.103];
C = [ 0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;
0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1 ];
D = [ 0 0 0;0 0 0;0 0 0; 0 0 0;0 0 0;0 0 0];



Q = 1*diag([1, 1, 1, 1, 1, 1]);
R = 10*diag([1, 1, 1]);
[K,S,e] = lqr(A,B,Q,R);

%% plot
figure;
plot(roll_rate.time,roll_rate.data,pitch_rate.time,pitch_rate.data,yaw_rate.time,yaw_rate.data,'LineWidth',1.5)
ylabel('Angular Rate');
xlabel('Time (in sec)');
title('Angular rates');
legend({'Roll Rate','Pitch rate','Yaw Rate'},'Location','northeast','FontSize',12)

figure;
plot(e,'o','LineWidth',2);
hold on;
xx = (-1.5:0.001:1);
yy = (-1:0.001:1);
zers_x = zeros(length(xx));
zers_y = zeros(length(yy));
plot(xx,zers_x,'LineWidth',1.5,'Color',[0,0,0]);
hold on;
plot(zers_y,yy,'LineWidth',1.5,'Color',[0,0,0]);
hold off;
title('Closed-Loop poles'); 

figure;
plot(power.time,power.data,'LineWidth',1.5);
ylabel('Power');
xlabel('Time (in sec)');
title('Power consumed');