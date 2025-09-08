% input data
H = randn(4,1);
y = randn(4,1);
% transformed input data
%Q = [transpose(H)*H , -1*transpose(H)*y ; -1*transpose(y)*H, norm(y)^2];

M = 5;

number_of_channels = 100;

randomized = zeros(1,number_of_channels);
original = zeros(1,number_of_channels);
rank1_approx = zeros(1,number_of_channels);
rows = 1:number_of_channels;

for idx=1:100
    Q = randn(5,5);

    cvx_begin
        variable X(M,M) 
        
        obj = trace(Q*X);
        
        minimize(obj)
        subject to
            for i = 1:M
                X(i,i) == 1;
            end
            
            
            X == hermitian_semidefinite(M)
    cvx_end
    L = 150;
    
    samples = transpose(mvnrnd(zeros(5, 1), X, L));
    samples = sign(samples);

    [dominant_eigenvector, dominant_eigenvalue] = eigs(X, 1);
    a = dominant_eigenvalue * dominant_eigenvector * dominant_eigenvector';
    rank1_approx(idx) = trace(Q*a);


    sum_samples = zeros(L,1);
    for j=1:L
        sum_samples(j) = samples(:,j)' * Q * samples(:,j);
    end

    optimum_val_rand = min(sum_samples);

    randomized(idx) = optimum_val_rand;
    original(idx) = obj;
end
   

% Plot the figures
figure;
plot(rows, original, 'LineStyle', '-','DisplayName', 'SDR upperbound');
hold on;

plot(rows, randomized, 'LineStyle', '--','DisplayName', 'SDR with randomization');


hold on;

plot(rows, rank1_approx, 'LineStyle', ':' ,'DisplayName', 'SDR with rank 1 approximation');

xlabel('channel number');
ylabel('objective value');

legend('show');



