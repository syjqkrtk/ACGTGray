clear;

a = load('indexfor1766GPDI.mat');
bacteria = a.indexfor1766GPDI;
info = cell(1,4);
len = zeros(1766,1);

for i = 1:1766
    str = sprintf('Read %dth bacteria\n',i);
    disp(str);
    info{1,1} = bacteria{i,4};
    info{1,2} = bacteria{i,5};
    info{1,3} = bacteria{i,6};
    num = bacteria{i,2};
    str1 = sprintf('Bacteria\\%d.txt',num);
    str2 = sprintf('Bacteria\\%d.seq',num);
    str3 = sprintf('PRJNA%d',num);
    temp1 = dir(str1);
    temp2 = dir(str2);
    try
        temp3 = getgenbank(str3);
        info{1,4} = temp3.SourceOrganism;
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
    sequence = upper(temp);
    sequence = (sequence=='A')+2*(sequence=='T')+3*(sequence=='C')+4*(sequence=='G');

        
    for k = 1:5
        load('data.mat');
        %% Gene sequence에서 기존의 k-word pdf를 이용하여 그래프를 얻음
        num = 4^k;
        WordPdf = zeros(num,1);
        temp = zeros(1,k);

        %% word pdf 구하기
        for j = 1:length(sequence)-k+1
            temp = sequence(j:j+k-1);
            if temp(:,:) ~= 0
                index = 0;
                for l = 1:k
                    index = index + 4^(l-1)*(temp(1,l)-1);
                end
                index = index+1;
                WordPdf(index) = WordPdf(index)+1;
            end
        end
        temp = zeros(1,k);
    %     disp(Str);

        %% Repeat pdf normalization
        WordPdf(:) = WordPdf(:)/sum(WordPdf(:));

        %% Clustering 및 denrogram
        % Z = linkage(WordPdf,'ward','Euclidean');
        % C = cluster(Z,'maxclust',3);
        % dendrogram(Z,0);

        DeBruijnPdf = WordPdf(kDeBruijn{k}+1)/max(WordPdf);
        Str = sprintf('Result\\result_%d\\DeBruijnPdf_%d.bmp',k,i);
        imwrite(DeBruijnPdf, Str);
    end
end