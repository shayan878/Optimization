K = 4;
M = 4;

number_of_channels = 100;

randomized = zeros(1,number_of_channels);
original = zeros(1,number_of_channels);
rows = 1:number_of_channels;


original = zeros(1,number_of_channels);
rank1_approx = zeros(1,number_of_channels);
rows = 1:number_of_channels;

    for idx=1:100

        % input data
        Hi_s = randn(M,M);
        H = zeros(M,M,K);
        for b=1:M
            H(:,:,b) = Hi_s(:,b) * Hi_s(:,b)' ;
        end
        
    
        cvx_begin
            variable X(M,M)
            variable t
            obj = t;
            
            maximize(obj)
            subject to
                for i = 1:K
                    trace(X*H(:,:,i)) >= t
                end
                trace(X) == 1
                X == hermitian_semidefinite(M)
        cvx_end
        original(idx) = obj;



        [dominant_eigenvector, dominant_eigenvalue] = eigs(X, 1);
        a = dominant_eigenvalue * dominant_eigenvector * dominant_eigenvector';
        cvx_begin
            variable t
            obj1 = t;
            
            maximize(obj1)
            subject to
                for i = 1:K
                    trace(a*H(:,:,i)) >= t
                end
        cvx_end


        rank1_approx(idx) = obj1;
        
    end

    % Plot the figures
figure;
plot(rows, original, 'LineStyle', '-','DisplayName', 'SDR upperbound');
hold on;


plot(rows, rank1_approx, 'LineStyle', ':' ,'DisplayName', 'SDR with rank 1 approximation');

xlabel('channel number');
ylabel('objective value');

legend('show');