clc
clear all

a = load('indexfor1766GPDI.mat');
bacteria = a.indexfor1766GPDI;
sequence = cell(length(bacteria),4);
len = zeros(1766,1);

for i = 1:length(bacteria)
    str = sprintf('Read %dth bacteria\n',i);
    disp(str);
    sequence{i,1} = bacteria{i,4};
    sequence{i,2} = bacteria{i,5};
    sequence{i,3} = bacteria{i,6};
    num = bacteria{i,2};
    str1 = sprintf('Bacteria\\%d.txt',num);
    str2 = sprintf('Bacteria\\%d.seq',num);
    str3 = sprintf('PRJNA%d',num);
    temp1 = dir(str1);
    temp2 = dir(str2);
    try
        temp3 = getgenbank(str3);
        sequence{i,4} = temp3.SourceOrganism;
    catch
    end
    
    if size(temp1)
        file = fopen(str1,'r');
    else
        if size(temp2)
            file = fopen(str2,'r');
        else
            disp('error')
            continue;
        end
    end
    
    temp = fscanf(file,'%s');
    temp = split(temp,'^');
    temp = temp{end};
    len(i) = length(temp);
    fclose(file);
%     str = sprintf('Bacteria_%d.fas',i);
%     file = fopen(str,'w');
%     fprintf(file,'>%s\n%s\n',sequence{i,1},upper(temp));
%     fclose(file);
%     str = sprintf('Bacteria_%d.txt',i);
%     file = fopen(str,'w');
%     fprintf(file,'%s\n',temp);
%     fclose(file);    
end

save('bacteria.mat');