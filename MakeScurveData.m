function MakeScurveData(variance)
tt = [-1:0.1:0.5]*pi; uu = tt(end:-1:1); hh = [0:0.1:1]*5;
xx = [cos(tt) -cos(uu)]'*ones(size(hh));
yy = ones(size([tt uu]))'*hh;
zz = [sin(tt) 2-sin(uu)]'*ones(size(hh));
cc = [tt uu]' * ones(size(hh));
name = '';
if variance > 0
    xx = xx+sqrt(variance)*randn(size(xx));
    yy = yy+sqrt(variance)*randn(size(yy));
    zz = zz+sqrt(variance)*randn(size(zz));
    name = ['_' num2str(variance) '_'];
end
data3 = [xx(:),yy(:),zz(:)];
color = reshape(kron(jet(length(tt)*2),ones(size(hh))), [16*11*2, 3]);

close all;
figure;
hold on;
% plot3(xx(:),yy(:),zz(:),'.','Markersize',20,'color',color);
scatter3(xx(:),yy(:),zz(:),20,color,'filled');
daspect([1,1,1]);
set(gca,'fontsize',16);
view(3);
grid;

saveas(gcf,['figures/ScurveData' name '.png']);
save(['data/ScurveData' name '.mat'],'data3','color');
end
 
  
