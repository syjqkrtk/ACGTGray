function result = DeBruijn(k,n)

    w = zeros(k^n,1);
    w2 = zeros(k^n,1);
    
    perm = zeros(k^n,1);
    
    for i = 1:k
        w((i-1)*k^(n-1)+1:i*k^(n-1)) = i-1;
        w2(i:k:i+k^n-k) = i-1;
        
        perm((i-1)*k^(n-1)+1:i*k^(n-1)) = i:k:i+k^n-k;
    end
    
    group = zeros(k^n,1);
    sequence = zeros(k^n,1);
    count = 0;
    count2 = 0;
    
    for i = 1:k^n
        if group(i) == 0
            count = count+1;
            group(i) = count;
            count2 = count2+1;
            sequence(count2) = i;
            temp = i;
            while(perm(temp)~=i)
                temp = perm(temp);
                group(temp) = count;
                count2 = count2+1;
                sequence(count2) = temp;
            end
        end
    end
    
    result = w(sequence);

end