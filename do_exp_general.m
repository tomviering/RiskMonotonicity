function [R,true_risk_opt] = do_exp_general(n, q, lambda, loss)
% Performs linear regression experiment (ERM) with squared or absolute loss
% with two objects A (Xa = 1, Ya = 1) and B (Xb = 0.1, Yb = 1)
% and generates the learning curve of the true risk averaged over all 
% possible training sets.
%
% Inputs:
% n = maximum training set size for the learning curve
% q = probability of observing A
% lambda = regularization parameter (only implemented for squared loss!)
% loss = loss function: 'sqr' for squared loss, 'abs' for absolute loss
%
% Outputs:
% R = learning curve 
% true_risk_opt = the best risk we can achieve using linear regression 
%                 note this ignores any regularization

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

for m = 1:n % loop over the training set size
    
    R(m) = 0;
    
    for na = 0:m % how many times A is observed
        
        nb = m-na; % how many times B is observed
        
        if loss=='abs' 
            
            % compute solution of ERM with abs. loss
            if na*Xa > nb*Xb
                w_emp = Ya/Xa;
            elseif na*Xa < nb*Xb
                w_emp = Yb/Xb;
            else
                w_emp = min([Ya/Xa,Yb/Xb],[],2);
            end
            
            % compute the true risk using abs. loss
            true_risk = Pa*abs(Xa*w_emp-Ya) + Pb*abs(Xb*w_emp-Yb);
            
        elseif loss=='sqr'
            
            % compute solution of ERM with squared loss
            % pinv gives minimum norm solution
            w_emp = pinv(na*(Xa'*Xa)+nb*(Xb'*Xb) + lambda*eye(numel(Xa)))...
                *(na*(Xa'*Ya)+nb*(Xb'*Yb));
            % compute the true risk using squared loss
            true_risk = Pa*(Xa*w_emp-Ya)^2 + Pb*(Xb*w_emp-Yb)^2;
            
        end

        % multiply the true risk by probability of observing this training set
        % to get average over all possible training sets
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