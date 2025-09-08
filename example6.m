M = 4;
K = 4;

number_of_channels = 100;

randomized = zeros(1,number_of_channels);
original = zeros(1,number_of_channels);
rows = 1:number_of_channels;

for idx=1:100

    % Q = randn(M,M,K);
    %matrix A
    num_matrices = 4;
    
    Q = zeros(4, 4, num_matrices);
    
    for i = 1:num_matrices
        % Generate a random 4x4 matrix
        G = rand(4, 4);
        
        % Create a symmetric positive semidefinite matrix
        Q(:, :, i) = G' * G; 
    end

    cvx_begin
    variable X(M,M) 
    variable s(K,1)
    obj = trace(X)
    minimize(obj)
    subject to
        for i = 1:K
            trace(X*Q(:,:,i))-s(i,1) == 1
            s(i,1) >= 0
        end
    X == hermitian_semidefinite(M)
    X == X'
    cvx_end
    L = 6;
    samples = transpose(mvnrnd(zeros(4, 1), X, L));
    display(samples)
    sum_obj = zeros(4,1);
    scaling_samples = zeros(L,1);
    
    
    
    for k=1:L
        for c=1:4
            sum_obj(c) = samples(:,k)' * Q(:,:,c) * samples(:,k);
        end
        scaling_samples(k) = sqrt(min(sum_obj));
    end
    
    
    
    for n=1:L
       samples(:,n) =  samples(:,n)/(scaling_samples(n));
    end
    
    
    
    final_val = zeros(L,1);
    for m=1:L
       final_val(m) =   norm(samples(:,k))^2 ;
    end
    
    
    
    optimum_val_rand = min(final_val);

    randomized(idx) = optimum_val_rand;
    original(idx) = obj;
end
   

% Plot the figures
figure;
plot(rows, original, 'LineStyle', '-','DisplayName', 'SDR upperbound');
hold on;

plot(rows, randomized, 'LineStyle', '--','DisplayName', 'SDR with randomization');

xlabel('channel number');
ylabel('objective value');
hold off;

legend('show');


