function [f, m] = cbf_cmro2(tau_f, tau_m, delta_tf, delta_tm, f_1, n, t_step, t_end, t, N)
% Calculate the CBF (f) and CMRO2 (m) from the neural response using 
% eqs. 12 and 13 in Buxton 2004
%
% INPUTS
% tau_f: Width of CBF impulse response
% tau_m: Width of CMRO2 impulse response
% delta_tf: Delay of CBF response to model lag of hemodynamic response
% delta_tm: Delay of CMRO2 response to model lag of hemodynamic response
% f_1: Response shape scaling
% n: Steady state flow-metabolism relation in eqn.3 n=f-1/m-1
% t_step: Time interval (s)
% t_end: End time (s)
% t: Time
% N: neural response to stimulus
%
% OUTPUTS
% f: CBF normalised to baseline i.e f=1 at baseline
% m: CMR02 normalised to baseline

k = 3;
tau_h = 0.242 .* tau_f;

h = zeros(1, length(t) + delta_tf ./ t_step + 1);  % Delay the response by delta_tf
h(delta_tf / t_step + 2 : end) = (1 ./ (k .* tau_h .* factorial(k - 1))) .* (t ./ tau_h) .* exp(-t ./ tau_h);  
h = h(1 : t_end / t_step + 1); % Chop off the end of vector as its unimportant
h = h ./ sum(h);

tau_g = 0.242 .* tau_m;
g = zeros(1, length(t) + delta_tm ./ t_step + 1);  % Delay the response by delta_tm
g(delta_tm / t_step + 2 : end) = (1 ./ (k .* tau_g .* factorial(k - 1))) .* (t ./ tau_g) .* exp(-t ./ tau_g);
g = g(1 : t_end / t_step + 1); % Chop off the end of vector as its unimportant
g = g ./ sum(g);

m_1 = ((f_1 - 1) ./ n) + 1;

f = 1 + conv((f_1 - 1) .* h, N, 'full');
m = 1 + conv((m_1 - 1) .* g, N, 'full');

f=f(1 : t_end / t_step + 1);
m=m(1 : t_end / t_step + 1);