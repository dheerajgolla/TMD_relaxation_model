sigsq = 150; %sigma squared = width of the envelope squared in fs^2
I = @(t) exp((-t.^2)/(2*sigsq)); %intensity envelope
N=50000; dt=1;
n_c=zeros(1,N); c_rel_time = 100;c_cap_time=10000;
n_ex=zeros(1,N);ex_rel_time=1000;
n_d=zeros(1,N); d_rel_time=100000;
n_d_init=0;n_d(1)=n_d_init;
for ii=1:N-1
    t=(ii-1)*dt;
    n_c(ii+1) = dt*(I(t-200) - (n_c(ii)/c_rel_time)-(n_c(ii)/c_cap_time))+n_c(ii);
    n_ex(ii+1) = dt*((n_c(ii)/c_rel_time) - (n_ex(ii)/ex_rel_time))+n_ex(ii);
    n_d (ii+1) = dt*((n_c(ii)/c_cap_time) - ((n_d(ii)-n_d_init)/d_rel_time))+n_d(ii);
end
alphaexc=10;alphadef=5;n_ex_sat=max(n_ex)/2;
diffabs = -alphaexc*(n_ex/n_ex_sat) + alphadef*(n_d - n_d_init);
t = dt*(1:N);
figure
hold on
plot(t,n_c,'k')
plot(t,n_d,'b')
plot(t,n_ex,'g')
hold off
figure;
plot(t,diffabs)
