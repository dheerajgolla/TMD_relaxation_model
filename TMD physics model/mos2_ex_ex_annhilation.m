%% MoS2 exciton - xciton annhilation model%% dezheng sun et al ACS

N0 = 1.1*10^(12); %initial exciton density cm^-2
ka = 5*10^(-2)*10^(-15);  % annhilation rate cm^2/s
dt=10;tmax=40000;
%timearray = 0:dt:tmax;
Nmax = tmax/dt;N= zeros(1,Nmax);t=zeros(1,Nmax);
for ii = 1:Nmax
    N(ii) = (N0)./(1+N0*ka*dt*(ii-1));
    t(ii) = dt*(ii-1);
end
figure;plot(t,N);