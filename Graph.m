clear;

result = zeros(3,200);

for k = 1 : 3
    str = sprintf('Result\\result_%d\\result.txt',k);
    file = fopen(str,'r');
    
    for i = 1:200
        result(k,i) = str2num(fgetl(file));
    end
    fclose(file);
end

plot(result(:,2:end)');
xlabel('No. of Epochs');
ylabel('Test Accuracy');
legend({'Proposed method (k=1)', 'Proposed method (k=2)', 'Proposed method (k=3)'},'Interpreter','latex');
