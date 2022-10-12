function dy = balloon(t,y,f,m,tau_mtt,alpha,tau)
% Calculate CBV and DeoxyHaem content using the balloon model with 
% eq. 10 and 11 in Buxton 2004
%
% INPUTS
% f: CBF normalised to baseline i.e f=1 at baseline
% m: CMR02 normalised to baseline
% tau_mtt: Transit time through the balloon
% alpha: Steady state flow-volume relation in eqn.1 v=f^alpha
% tau: Viscoelastic time constant
%
% OUTPUT
% dy: dy(1) represents dv / dt and dy(2) represents dq / dt

dy = zeros(2,1);
dy(1) = (f - y(1) .^ (1 / alpha)) ./ (tau_mtt + tau);
dy(2) = (1 / tau_mtt) .* (m - (y(2) / y(1)) .* (y(1) .^ (1 / alpha) + tau .* dy(1)));