function G = gauss(y0,w,wc,delta,A)
G = y0 + (A/(delta*sqrt(pi/2)))*(exp(-2*((w-wc)/delta).^2));
end