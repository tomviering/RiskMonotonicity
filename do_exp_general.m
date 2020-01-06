function [R,true_risk_opt] = do_exp_general(n, q, lambda, loss)
% n = number of simulated samples
% q = probability of observing a
% lambda = regularization parameter
% loss = loss function

R = zeros(n,1);

Xa = 1;
Xb = 0.1;

%    a  b
Y = [1 1]';
Ya = Y(1);
Yb = Y(2); 

P = [q, 1-q];
Pa = P(1);
Pb = P(2);

for m = 1:n
    
    R(m) = 0;
    
    for na = 0:m
        
        nb = m-na;
        
        if loss=='abs' 
            
            if na*Xa > nb*Xb
                w_emp = Ya/Xa;
            elseif na*Xa < nb*Xb
                w_emp = Yb/Xb;
            else
                w_emp = min([Ya/Xa,Yb/Xb],[],2);
            end
            
            true_risk = Pa*abs(Xa*w_emp-Ya) + Pb*abs(Xb*w_emp-Yb);
            
        elseif loss=='sqr'
            
            w_emp = pinv(na*(Xa'*Xa)+nb*(Xb'*Xb) + lambda*eye(numel(Xa)))...
                *(na*(Xa'*Ya)+nb*(Xb'*Yb));
            true_risk = Pa*(Xa*w_emp-Ya)^2 + Pb*(Xb*w_emp-Yb)^2;
            
        end
                
        R(m)=R(m)+nchoosek(m,na)*q^na*(1-q)^nb*true_risk; 
        
    end
    
end

% find best model in H
if loss=='abs'
    
    if Pa*Xa > Pb*Xb
        w_opt = Ya/Xa;
    elseif Pa*Xa < Pb*Xb
        w_opt = Yb/Xb;
    else
        w_opt = min([Ya/Xa,Yb/Xb],[],2);
    end
    
    true_risk_opt = Pa*abs(Xa*w_opt-Ya) + Pb*abs(Xb*w_opt-Yb);
    
elseif loss=='sqr'
    
    w_opt = pinv(Pa*(Xa'*Xa)+Pb*(Xb'*Xb))...
        *(Pa*(Xa'*Ya)+Pb*(Xb'*Yb));
    true_risk_opt = Pa*(Xa*w_opt-Ya)^2 + Pb*(Xb*w_opt-Yb)^2;
    
end