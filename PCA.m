function [] = PCA(X,name,dim,color)

    % normalize so that features center around 
    % mean with unit variance
    Y = normalize(X); 
    [U,S,V] = svd(Y,'econ');
    PCs = Y*V(:,1:3);
    
    close all;
    figure;
    hold on; grid;
    
    if dim == 2
        scatter(PCs(:,1),PCs(:,2),20,color,'filled');
        xlabel('PCA 1');
        ylabel('PCA 2');
    elseif dim == 3
        scatter3(PCs(:,1),PCs(:,2),PCs(:,3),20,color,'filled');
        xlabel('PCA 1');
        ylabel('PCA 2');
        zlabel('PCA 3');
        view(3);
    end
  
    saveas(gcf,name);
    
end