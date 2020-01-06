function plot2(R, R2, save_to_file, fn)

if (nargin < 5)
    Aerm = 1;
end

lw = 3;
figure;
h = plot(R,':o','LineWidth',.01);
set(h,'MarkerFaceColor',get(h,'Color'))
hold on
h2 = plot(R2,':o','LineWidth',.01);
set(h2,'MarkerFaceColor',get(h2,'Color'))
%set(h2,'Color',get(h,'Color'))

xlabel('sample size $n$','Interpreter','Latex')
ylabel('expected risk $R_{\mathcal{D}}$','Interpreter','Latex')

legend('$A_\mathrm{erm}$','$A_\mathrm{reg}$','Interpreter','Latex')

set(gcf,'color','white')
set(findall(gcf,'-property','FontSize'),'FontSize',13)
set(gcf,'color','w');
title('');

if (save_to_file)
    export_fig([fn '.pdf'],'-nocrop')
    legend off
    export_fig([fn '_nolegend.pdf'],'-nocrop')
end