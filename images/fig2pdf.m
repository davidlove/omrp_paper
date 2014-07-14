function fig2pdf( files, fs )

if nargin < 2
    fs = 16;
    if nargin < 1
        files = '*.fig';
    end
end

s = dir(files);
for j = 1:length(s)
    hf = open(s(j).name);
    htext = findall(hf,'type','text','-or','type','axes');
    set(htext,'fontsize',fs)
    
    % Make figure boundaries tight
    %ti = get(gca,'TightInset');
    %set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
    
    % Get rid of pdf boundaries in pdf
    set(gca,'units','centimeters');
    pos = get(gca,'Position');
    ti = get(gca,'TightInset');
    set(gcf, 'PaperUnits','centimeters');
    set(gcf, 'PaperSize', [(pos(3)+ti(1)+ti(3))*1.03 (pos(4)+ti(2)+ti(4))*1.03]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
    
    [~,filename,~] = fileparts(s(j).name);
    % saveas(hf,[filename '.fig'])
    saveas(hf,[filename '.pdf'])
    close(hf);
end