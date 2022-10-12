function b = bold(V_0, a_1, a_2, q, v)
% Calculate the BOLD signal fraction from DeoxyHb content normalised 
% to baseline and CBV using eq. 9 in Buxton 2004
%
% INPUTS
% V_0: Baseline blood volume
% a_1: Weight for deoxyHb change
% a_2: Weight for CBV change
% q: DeoxyHb content normalised to baseline
% v: CBV normalised to baseline
%
% OUTPUT
% b: BOLD signal

b = V_0 .* (a_1 .* (1 - q) - a_2 .* (1 - v));