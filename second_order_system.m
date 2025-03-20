m = 50; % mass of the object in kg
%c = 700; k = 125;          % case 1: c in Ns/cm and k in N/cm over damped
c = 700; k = c^2/(4*m);    % case 2: c in Ns/cm and k in N/cm critically damped
%c = 300; k = 2450;          % case 3: c in Ns/cm and k in N/cm under damped

%system parameters(model coefficients)
sigma = c/(2*m) ;
rho = k/m ;
eta = 1/m ;

%external forcing function 
A = 10*m;

%initial conditions
y_0 = -1.50;
yd_0 = 1.80;
k_1 = y_0;    k_2 = 2*sigma*y_0 + yd_0;

%simulation time and interval
duration = 25;
t = 0:0.001:duration;

%second order mechanical system 
%determinant of the characteristic equation
delta = 4*(sigma^2-rho);

%over damped system
if delta > 0
    alpha_1 = -sigma-sqrt(sigma^2-rho);
    alpha_2 = -sigma+sqrt(sigma^2-rho);
    p_1 = (k_1*alpha_1+k_2)/(alpha_1-alpha_2);
    p_2 = (k_1*alpha_2+k_2)/(alpha_2-alpha_1);
    q_1 = 1/(alpha_1*(alpha_1-alpha_2));
    q_2 = 1/(alpha_2*(alpha_2-alpha_1));
    q_3 = 1/(alpha_1*alpha_2);
    %homogeneous response
    y_H = p_1*exp(alpha_1*t) + p_2*exp(alpha_2*t);
    %exogeneous response
    y_E = eta*A*(q_1*exp(alpha_1*t)) + eta*A*(q_2*exp(alpha_2*t)) + eta*A*q_3;

%critically damped system
elseif delta == 0
    alpha = -sigma;
    p_5 = k_1;
    p_6 = k_1*alpha + k_2;
    p_7 = 1/alpha^2;
    p_8 = -1/alpha^2;
    p_9 = 1/alpha;
    %homogeneous response
    y_H = p_5*exp(alpha*t) + p_6*t.*exp(alpha*t);
    %exogeneous response
    y_E = eta*A*p_7 + eta*A*p_8*exp(alpha*t) + eta*A*p_9*t.*exp(alpha*t);

%under damped system
else
    omega = sqrt(-delta/4);
    phi = atan2(omega,sigma);
    y_H = exp(-sigma*t).*((k_1*cos(omega*t)+((k_2-sigma*k_1)/omega)*sin(omega*t)));
    y_E = eta*A/omega*(omega/(omega^2+sigma^2)-(1/sqrt(omega^2+sigma^2))*exp(-sigma*t).*sin(omega*t+phi));

end

%total response
y_T = y_H + y_E;

%plotting graphs
subplot(311); plot(t,y_H); axis([0 duration -2.8 5]);
ylabel('Homogeneous response'); grid on;
subplot(312); plot(t,y_E); axis([0 duration -2.8 5]);
ylabel('Exogeneous response'); grid on;
subplot(313); plot(t,y_T); axis([0 duration -2.8 5]);
ylabel('Total response'); xlabel('time[s]'); grid on;

