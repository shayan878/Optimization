%channel dimensions and number of recievers
M = 4;
K = 4;

number_of_channels = 100;

randomized = zeros(1,number_of_channels);
original = zeros(1,number_of_channels);
rows = 1:number_of_channels;

for idx=1:100
    % matrix C
    C = zeros(4, 4);
    C(:, :) = gallery('lehmer', 4);
    
    
    
    %matrix A
    num_matrices = 4;
    
    A = zeros(4, 4, num_matrices);
    
    for i = 1:num_matrices
        % Generate a random 4x4 matrix
        G = rand(4, 4);
        
        % Create a symmetric positive semidefinite matrix
        A(:, :, i) = G' * G; 
    end
    
    
    
    
    b = [1;1;1;1];
    %solving problem
    cvx_begin
        variable X(M,M)
        variable s(K,1)
        
        obj = trace(C*X);
        
        minimize(obj)
        subject to
            for i = 1:K
                trace(A(:,:,i)*X) - s(i,1) == b(i,1);
                s(i,1) >= 0;
            end
            X == hermitian_semidefinite(M);
    cvx_end
    
    
    L = 5;
    samples = transpose(mvnrnd(zeros(4, 1), X, L));
    sum_obj = zeros(4,1);
    scaling_samples = zeros(L,1);
    
    
    
    for k=1:L
        for c=1:4
            sum_obj(c) = samples(:,k)' * A(:,:,c) * samples(:,k);
        end
        scaling_samples(k) = min(sum_obj);
    end
    
    
    
    for n=1:L
       samples(:,n) =  samples(:,n)/(sqrt(scaling_samples(n)));
    end
    
    
    
    final_val = zeros(L,1);
    for m=1:L
       final_val(m) =  samples(:,m)' * C * samples(:,m) ;
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