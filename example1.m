K = 4;
M = 4;
gamma = 1;
rows = 1:100;
col = zeros(1,100);
for z = 1:100
    H = randn(K,M);
    cvx_begin
    variable tau nonnegative
    variable W(M,K) complex
    minimize(tau)
    subject to
        for i = 1:K 
            norm(H(i,1:M)*W)<=sqrt(1+1/gamma)*real(H(i,1:M)*W(1:M,i));
            imag(H(i,1:M)*W(1:M,i)) == 0;
        end
        norm(vec(W))<=sqrt(tau);
    cvx_end
    col(z) = tau;
end
 % Plot the figures
figure;
plot(rows, col);

xlabel('channel number');
ylabel('objective value(power minimization');
title('M=4, K=4 , gamma=1, variance=1');