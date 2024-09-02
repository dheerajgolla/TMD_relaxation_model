t = -1000:1:1000;
sigsq = 30; %sigma squared = width of the envelope squared in fs^2
syms I(tt) l IInt(l)
I(tt) = exp((-tt.^2)/(2*sigsq)); %intensity envelope
II = int(I,[-40,l]);
IInt(l) = II;
plot(t,IInt(t))
%td = t-200;
C1=0;
C2= 0;
A1 = 1;B1=1;
a1=0.01;b1=0.01;
A2 = -5; B2= -5;
a2=0.2;b2=0.30;
f1 = A1*exp(-a1*t) + B1*exp(-b1*t);
f2 = A2*exp(-a2*t) + B2*exp(-b2*t);
f=f1+f2;
A3 = 5;a3=1/50;f3=zeros(1,length(t));
f3(t>=0) = A3*(1-exp(-a3*t(t>=0)));
%f3(t<0)= -A3*exp(a3*t(t<0));
% hold on
% plot(t,f3)
% plot(t,f1)
% plot(t,f1+f3)
% hold off