function aa = affnity(query, ref, acc)
    [query_num, attr_num] = size(query);
    aa = zeros(attr_num, attr_num);
    for ii=1:attr_num
        for jj=1:ii
            for kk=1:query_num
                if query(kk, ii) == 1 && query(kk, jj) == 1
                    aa(ii,jj) = aa(ii,jj) + sum(ref(kk,:) .* acc(kk,:));
                end
            end
            aa(jj,ii) = aa(ii,jj);
        end
    end
end