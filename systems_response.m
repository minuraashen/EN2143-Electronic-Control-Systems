%initialize variables 
R_1 = 1000;
R_2 = 2000;
C = 200*10^-6;
%system variables
a = (R_1+R_2)/(R_1*R_2*C);
b = 1/(R_1*C);
V_0 = 2; %initial voltage across the capasitor
duration = 1;
t = 0:0.001:duration;

Homogeneous_response = V_0*exp(-a*t);
Exogeneous_response = (b/a)*(1-exp(-a*t));
Total_response = Homogeneous_response + Exogeneous_response;

%plotting homogeneous response
subplot(311);
plot(t,Homogeneous_response);
axis([0 duration 0 2]);
ylabel("Homogeneous response");
grid("on");

%plotting exogeneous response
subplot(312);
plot(t,Exogeneous_response);
axis([0 duration 0 2]);
ylabel("Exogeneous response");
grid("on");

%plotting total response
subplot(313);
plot(t,Total_response);
axis([0 duration 0 2]);
ylabel("Total response");
grid("on");



