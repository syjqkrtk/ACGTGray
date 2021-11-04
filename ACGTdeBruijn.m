clear;

rawDeBruijn = cell(6,1);
kDeBruijn = cell(6,1);
ACGT = cell(6,1);


for k = 1:6
    
    rawDeBruijn{k} = DeBruijn(4,k);
    len = 4^k;
%     width = 4^k;
    
%     kDeBruijn{k} = zeros(4^k,width);
    kDeBruijn{k} = zeros(4^k,1);
    
    for i = 1:len
        for l = 1:k
            kDeBruijn{k}(i,1) = kDeBruijn{k}(i,1) + 4^(k-l)*rawDeBruijn{k}(mod(i+l-2,len)+1);
        end
    end
%     for i = 2:width
%         kDeBruijn{k}(1:end-i+1,i) = kDeBruijn{k}(i:end,1);
%         kDeBruijn{k}(end-i+2:end,i) = kDeBruijn{k}(1:i-1,1);
%     end
            
    order = kDeBruijn{k};
%     result = reshape(dec2base(reshape(order, [4^k,width]),4)-'0',[4^k,width,k]);
    result = reshape(dec2base(reshape(order, [4^k,1]),4)-'0',[4^k,1,k]);
    temp = char(('A'*(result==0))+('T'*(result==1))+('C'*(result==2))+('G'*(result==3)));
    ACGT{k} = num2cell(temp,3);

end

save('data.mat');