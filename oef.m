function E = oef(E_0, m, f)
% Calculate the oxygen extraction fraction from CMRO2 and CBF
%
% INPUTS
% E_0: Baseline oxygen extraction fraction
% m: CMR02 normalised to baseline
% f: CBF normalised to baseline i.e f=1 at baseline
%
% OUTPUT
% E: oxygen extraction fraction

E = E_0 .* m ./ f;
