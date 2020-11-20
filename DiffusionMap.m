function [] = DiffusionMap(X,t,colors,name,dim)

    [n,~] = size(X);
    
    % compute the squared-distance matrix between points
    d = zeros(n);
    e = ones(n,1); 
    for i = 1:n
        d(i,:) = sum((X-e*X(i,:)).^2,2);
    end
    
    % choose epsilon
    drowmin = zeros(n,1);
    for i = 1:n
        drowmin(i) = min(d(i,setdiff(1:n,i)));
    end
    epsilon = 4*mean(drowmin);
    
    % compute diffusion kernel then convert into a stochastic matrix P
    K = exp(-1*d/epsilon); 
    Q = sum(K,2);
    P = K./Q;

    % compute stationary distribution by normalizing Q
    % compute K_hat, a symmetric matrix similar to P
    pi = Q./norm(Q);
    P_sym = diag(sqrt(pi))*P*diag(1./(sqrt(pi)));
    
    % columns of R are right eigenvectors of K_hat
    [V,lams,~] = eig(P_sym);
    lams = diag(lams);
    R = diag(1./(sqrt(pi)))*V;
    
    Y = zeros(n,dim);
    for i = 1:n
        for j = 1:dim
            Y(i,j) = lams(j+1)^t * R(i,j+1);
        end
    end
    
    figure;
    hold on; grid;
    if dim == 2
        scatter(Y(:,1),Y(:,2),20,colors,'filled');
        saveas(gcf,['figures/dm2_' name]);
    elseif dim == 3
        scatter3(Y(:,1),Y(:,2),Y(:,3),20,colors,'filled');
        view(3);
        saveas(gcf,['figures/dm3_' name]);
    end

end