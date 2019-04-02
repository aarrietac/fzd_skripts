function pRot = rotates(rotm, p)

% Simple matrix multiplication
% R = [cos(angle), -sin(angle);
%      sin(angle),  cos(angle)];
% x = x0.*cos(angle) - y0.*sin(angle);
% y = x0.*sin(angle) + y0.*cos(angle);

pRot = rotm*p.';
pRot = pRot.';

end