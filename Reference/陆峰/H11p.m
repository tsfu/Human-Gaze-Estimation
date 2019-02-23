%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% H11p auxiliary function
function y = H11p(v, A, At, Dh, Dv, Dhx, Dvx, sigb, ft, fe, atr)

Dhv = Dh*v;
Dvv = Dv*v;

y = Dh'*((-1./ft + sigb.*Dhx.^2).*Dhv + sigb.*Dhx.*Dvx.*Dvv) + ...
  Dv'*((-1./ft + sigb.*Dvx.^2).*Dvv + sigb.*Dhx.*Dvx.*Dhv) - ...
  1/fe*At(A(v)) + 1/fe^2*(atr'*v)*atr; 
end
