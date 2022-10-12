function N = neural_response(kappa, tau_i, t_step, s)
% Calculate the neural response to a stimulus s using eq. 14 in Buxton 2004
%
% INPUTS
% kappa: Inhibitory gain factor 
% tau_i: Inhibitory time constant
% t_step: Time interval (s)
% s: Stimulus pattern
%
% OUTPUT
% N: neural response to stimulus

options = odeset('RelTol', 1e-4, 'AbsTol', 1e-4);  

initial_I = zeros(1, length(s));
I = zeros(1, length(s));
N = zeros(1, length(s));

for ii = 1 : length(s)
    if ii == 1
        initial_I(1) = 0;
    elseif ii > 1
        initial_I(ii) = I(ii - 1);
    end
 
    [~, y] = ode45(@neural, [0 t_step], initial_I(ii), options, s(ii), kappa, tau_i);
    I(ii) = y(end, 1);
    N(ii) = s(ii) - I(ii); 

    if N(ii)<0
        N(ii)=0;
    end
end