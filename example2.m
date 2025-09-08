M = 4;
K = 4;
gamma = 1;
rows = 1:100;
col = zeros(1,100);
for z = 1:100
    
    H = 0.35*randn(M,M,K);
    
    cvx_begin
    variable X(M,M,K)
    variable s(K,1)
    obj = 0;
    for i = 1:K
        obj = obj + trace(X(:,:,i));
    end
    minimize(obj)
    subject to
        for i = 1:K
            cstr = 0;
            for j = 1:K
                if j ~=i
                    cstr = cstr + trace(H(:,:,i)*X(:,:,j));
                end
            end
            trace(H(:,:,i)*X(:,:,i)) - gamma*cstr - s(i,1) == gamma;
            s(i,1) >= 0;
            X(:,:,i) == hermitian_semidefinite(M)
        end
    cvx_end
    col(z) = obj;
end
 % Plot the figures
figure;
plot(rows, col);

xlabel('channel number');
ylabel('objective value(power minimization');
title('M=4, K=4 , gamma=1, variance=1');