function [v, q] = balloon_response(alpha, tau_mtt, tau, t_step, f, m)
% Calculate CBV and DeoxyHaem content using the balloon model with 
% eq. 10 in Buxton 2004
%
% INPUTS
% alpha: Steady state flow-volume relation in eqn.1 v=f^alpha
% tau_mtt: Transit time through the balloon
% tau: Viscoelastic time constant
% t_step: Time interval (s)
% f: CBF normalised to baseline i.e f=1 at baseline
% m: CMR02 normalised to baseline
%
% OUTPUTS
% v: CBV normalised to baseline
% q: DeoxyHb content normalised to baseline

options = odeset('RelTol', 1e-4, 'AbsTol', 1e-4);  

v = zeros(1, length(f));
q = zeros(1, length(f));
initial_1 = zeros(1, length(f));
initial_2 = zeros(1, length(f));
for ii = 1 : length(f)
    if ii == 1
        initial_1(1) = 1;
        initial_2(1) = 1;
    elseif ii > 1
        initial_1(ii) = v(ii - 1);
        initial_2(ii) = q(ii - 1);
    end
    [~, y] = ode45(@balloon, [0 t_step], [initial_1(ii) initial_2(ii)], options, f(ii), m(ii), tau_mtt, alpha, tau);
    v(ii) = y(end, 1);
    q(ii) = y(end, 2);
end