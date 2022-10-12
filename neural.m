function [dI,N] = neural(t, I, s, kappa, tau_i)
% Calculate neural response with eq 14 in Buxton 2004
%
% INPUTS
% I: Inhibitory input
% s: Stimulus pattern
% kappa: Inhibitory gain factor 
% tau_i: Inhibitory time constant
%
% OUTPUTS
% dI: Change in inhibitory input
% N: neural response to stimulus

N = s - I;
dI = (kappa .* N - I) ./ tau_i;
