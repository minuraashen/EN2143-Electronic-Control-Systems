%declare parameters of the model
k_tau = 0.026; % Nm/A
k_B = 0.02;  % Vs/rad

L = 0.062; %inductance of armature
R = 2.5; %resistance of armature
n = 20; %gear ratio of reduction gear system
dur = 5; %time duration

J_eq = 0.00004; %equivalent inertia
b_eq = 0.001; %equivalent viscous damping constant

%numerator coefficients
a0 = k_tau/n;

%dinominator  coefficient
b0 = R*b_eq + k_B*k_tau;
b1 = L*b_eq + R*J_eq;
b2 = L*J_eq;

%transfer function can be decalred in two ways

%method 01
Pos_sys = tf(a0,[b2 b1 b0 0]);

%method02
s = tf('s');
G = a0/(b2*s^3+b1*s^2+b0*s+0);
H = a0/(b2*s^2+b1*s+b0);

%position response of the system
%unit step response is given by
% subplot(211);
% step(Pos_sys,dur); grid on; title("Position Response");

%Position response for a custom input can be given by
t = 0:0.001:dur;   %time vector
u = ones(size(t)); %custom input
u(1/0.001:3/0.001) = 2;
response = lsim(G, u, t); 
subplot(211);
plot(t,u,t,response); grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Position response to Unit Step');

%velocity respose of the system
%unit step response is given by
% Vel_sys = tf(a0,[b2 b1 b0]);
% subplot(212);
% step(Vel_sys,dur); grid on; title("Velocity Response"); ylabel("Velocity")

%Velocity resposnse output for a custom input can be given by
t = 0:0.001:dur;   %time vector
u = ones(size(t)); %custom input
u(1/0.001:3/0.001) = 2;
response = lsim(H, u, t);
subplot(212);
plot(t,u,t,response); grid on;
xlabel('Time (s)');
ylabel('Velocity');
title('Velocity Response to Unit Step');