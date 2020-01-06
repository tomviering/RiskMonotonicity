function plot1(R, Rbest, save_to_file, fn, topright)

if (nargin < 5)
    topright = 0;
end

lw = 3;
figure;
h = plot(R,':o','LineWidth',.01);
set(h,'MarkerFaceColor',get(h,'Color'))
hold on
if length(Rbest) > 0
    h2 = plot(repmat(Rbest,length(R),1),'-','LineWidth',lw);
    set(h2,'Color',get(h,'Color'))
end

xlabel('sample size $n$','Interpreter','Latex')
ylabel('expected risk $R_{\mathcal{D}}$','Interpreter','Latex')

legend('performance of $A_\mathrm{erm}$','best possible model in $\mathcal{H}$','Interpreter','Latex','Location','NorthWest');

if (topright == 1)
    legend('Location','NorthEast')
end

set(gcf,'color','white')
set(findall(gcf,'-property','FontSize'),'FontSize',13)
set(gcf,'color','w');
title('');

if (save_to_file)
    export_fig([fn '.pdf'],'-nocrop')
    legend off
    export_fig([fn '_nolegend.pdf'],'-nocrop')
end