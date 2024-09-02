S = 2.47;
homega = 50;
E0 = 2.09;
kb= 8.617*10^(-2);
T = 100:1:1000;
E = E0 - (S*homega).*0.001*(coth(homega./(2*kb*T))-1);
n = 1./(exp(50./kb*T)-1);
figure
plot(T,E)
figure
plot(T,n)