function [R,true_risk_opt] = do_exp_general_withbias(n, X, Y, P)
% Performs the linear regression experiment in 1D with objects given by 
% the vectors X and Y and their corresponding probabilities P.
% X and Y must have length 3. The samples are called A, B, C.
% Squared loss with ERM is used to make the learning curve of the true
% risk.
%
% Inputs:
% n = maximum number of training samples
% X = 3 marginal samples (inputs)
% Y = 3 target values (outputs)
% P = probabilities of observing said samples
%
% Outputs:
% R = learning curve
% true_risk_opt = the best risk we can achieve using this class

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

for m = 1:n % loop over training set sizes
    
    R(m) = 0;
    
    for na = 0:m % number of times we observe A
        
        for nb = 0:(m-na) % number of times we observe B
            
            nc = m-na-nb; % number of times we observe C

            % compute ERM solution using squared loss
            % pinv gets minimum norm solution
            w_emp = pinv(na*(Xa'*Xa)+nb*(Xb'*Xb)+nc*(Xc'*Xc))...
                *(na*(Xa'*Ya)+nb*(Xb'*Yb)+nc*(Xc'*Yc));
            true_risk = Pa*(Xa*w_emp-Ya)^2+Pb*(Xb*w_emp-Yb)^2+Pc*(Xc*w_emp-Yc)^2;
                        
            big_p = mnpdf([na,nb,nc],[Pa,Pb,Pc]); % probability of observing this training set
            % multiply true risk by probability to average over all
            % possible training sets
            R(m)=R(m)+big_p*true_risk;      
            
        end
        
    end
    
end

% compute best in class
w_opt = pinv(Pa*(Xa'*Xa)+Pb*(Xb'*Xb)+Pc*(Xc'*Xc))...
    *(Pa*(Xa'*Ya)+Pb*(Xb'*Yb)+Pc*(Xc'*Yc));
true_risk_opt = Pa*(Xa*w_opt-Ya)^2+Pb*(Xb*w_opt-Yb)^2+Pc*(Xc*w_opt-Yc)^2;       