function [R,true_risk_opt] = do_exp_general_withbias(n, X, Y, P)
% n = number of simulated samples
% X = marginal samples
% Y = target values
% P = probability of observing said samples

R = zeros(n,1);

Xa = [X(1) 1];
Xb = [X(2) 1];
Xc = [X(3) 1];

Ya = Y(1);
Yb = Y(2);
Yc = Y(3);

Pa = P(1);
Pb = P(2);
Pc = P(3);

for m = 1:n
    
    R(m) = 0;
    
    for na = 0:m
        
        for nb = 0:(m-na)
            
            nc = m-na-nb;

            w_emp = pinv(na*(Xa'*Xa)+nb*(Xb'*Xb)+nc*(Xc'*Xc))...
                *(na*(Xa'*Ya)+nb*(Xb'*Yb)+nc*(Xc'*Yc));
            true_risk = Pa*(Xa*w_emp-Ya)^2+Pb*(Xb*w_emp-Yb)^2+Pc*(Xc*w_emp-Yc)^2;
                        
            big_p = mnpdf([na,nb,nc],[Pa,Pb,Pc]); % probability of observing this S_n
            R(m)=R(m)+big_p*true_risk;      
            
        end
        
    end
    
end

% compute best in class
w_opt = pinv(Pa*(Xa'*Xa)+Pb*(Xb'*Xb)+Pc*(Xc'*Xc))...
    *(Pa*(Xa'*Ya)+Pb*(Xb'*Yb)+Pc*(Xc'*Yc));
true_risk_opt = Pa*(Xa*w_opt-Ya)^2+Pb*(Xb*w_opt-Yb)^2+Pc*(Xc*w_opt-Yc)^2;       