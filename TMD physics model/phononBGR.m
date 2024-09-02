pulsewidth=50;
sigsq = pulsewidth.^2; %sigma squared = width of the envelope squared in fs^2
I0 = 0.5;
I = @(t) I0*exp((-t.^2)/(2*sigsq)); %intensity envelope
N=100000; dt=1;
n_c=zeros(1,N);
n_ex=zeros(1,N);
%c_rel_time = 100;
%c_cap_time=1000;
ex_cap_time=800;%zeros(1,N);
c_rel_time=500;
d_rel_time=38000;
ex_rel_time=2500;
ph_rel_time = 27000;
n_d=zeros(1,N); 
n_ph=zeros(1,N);
for ii=1:N-1
    t=(ii-1)*dt;
    n_c(ii+1) = dt*(I(t-200) - (n_c(ii)/c_rel_time))+n_c(ii);
    n_ex(ii+1) = dt*((n_c(ii)/c_rel_time) - (n_ex(ii)/ex_rel_time)-(n_ex(ii)/ex_cap_time))+n_ex(ii);
    n_d (ii+1) = dt*((n_ex(ii)/ex_cap_time) - (n_d(ii)/d_rel_time))+n_d(ii);
    if n_d(ii+1)<n_d(ii)
        n_ph(ii)=n_ph(ii) + 12*(n_d(ii)-n_d(ii+1));
    end
    if n_ph(ii)>0
        n_ph(ii+1) = -dt*(n_ph(ii)/ph_rel_time) + n_ph(ii);
    end
end
%*(100-n_d(ii));*(100-n_d(ii))
alphaexc=1.7;alphadef=0.00005;n_d_init=n_d(1);alphacarrierBGR=1.3;%(1000-n_d(ii))
alphaphBGR=+0.8;factor = 0.1;
%n_ph = circshift(n_ph,-11636,2);
diffabs = factor*(-alphaexc*(n_ex) + alphadef*(n_d - n_d_init) - alphacarrierBGR*(n_c) - 0.7*alphaphononBGR(N,dt)-alphaphBGR*n_ph);
t = dt*(1:N)/1000;
n_ph = circshift(n_ph,-3136,2)
figure
hold on
plot(t,n_c,'k','DisplayName','n_c')
plot(t,n_d,'b','DisplayName','n_d')
plot(t,n_ex,'r','DisplayName','n_x')
plot(t,n_ph,'g','DisplayName','n_p')
%plot(t,n_ph,'c','DisplayName','n_p')
legend('show');
xlim([0 70])
hold off
figure;
hold on
plot(t-0.443,diffabs)
plot(data620(:,1),1000*data620(:,2))
xlim([-5 70])
hold off


