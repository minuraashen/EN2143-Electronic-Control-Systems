%system parameters
R = 1000; % 1kohm
C = 0.0002; % 200 ufarad
a = 2/(R*C);
b= 1/(R*C);

dur = 0.6;
%output voltage of the system 
subplot(211);
k=2; G = tf(b, [1 a+k*b]); step(G, dur); hold on;
k=0; G = tf(b, [1 a+k*b]); step(G, dur); hold on;
k=-1; G = tf(b, [1 a+k*b]); step(G, dur); hold on;  %unity DC gain
k=-1.5; G = tf(b, [1 a+k*b]); step(G, dur); hold on;
k=-2; G = tf(b, [1 a+k*b]); step(G, dur); hold on;
k=-2.1; G = tf(b, [1 a+k*b]); step(G, dur); hold on;
ylabel('Output Voltage');
title('Step Response for Different Values of k in RC Feedback System');


%control input to the system
subplot(212);
k=2; H = tf([1 a], [1 a+k*b]); step(H, dur); hold on;
k=0; H = tf([1 a], [1 a+k*b]); step(H, dur); hold on;
k=-1; H = tf([1 a], [1 a+k*b]); step(H, dur); hold on;  %unity DC gain
k=-1.5; H = tf([1 a], [1 a+k*b]); step(H, dur); hold on;
k=-2; H = tf([1 a], [1 a+k*b]); step(H, dur); hold on;
k=-2.1; H = tf([1 a], [1 a+k*b]); step(H, dur); hold on;
ylabel('Control Voltage');
title('Step Response for Different Values of k in RC Feedback System');