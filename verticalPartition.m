function [R1, R2] = verticalPartition(new_order, ref, acc, query)
    line = length(new_order);
    best = -inf;
    for ii=1:line-1
        for jj = line - 1:-1:1
            z = ctq(new_order, ref, acc, query, jj) * ... 
                cbq(new_order, ref, acc, query, jj) - ...
                coq(new_order, ref, acc, query, jj) ^ 2;
            if z > best
                best = z;
                R1 = new_order(1:jj);
                R2 = new_order(jj+1:end);
            end
        end
        new_order = circshift(new_order, 1, 2);
    end
end

function r = ctq(new_order, ref, acc, query, index)
    [query_num, ~] = size(query);
    [~, site_num] = size(acc);
    r = 0;
    for ii=1:query_num
        if min(ismember(find(query(ii,:) == 1), new_order(1:index))) == 1
            for jj=1:site_num
                r = r + ref(ii, jj) * acc(ii, jj);
            end
        end
    end
end

function r = cbq(new_order, ref, acc, query, index)
    [query_num, ~] = size(query);
    [~, site_num] = size(acc);
    r = 0;
    for ii=1:query_num
        if min(ismember(find(query(ii,:) == 1), new_order(index+1:end))) == 1
            for jj=1:site_num
                r = r + ref(ii, jj) * acc(ii, jj);
            end
        end
    end
end

function r = coq(new_order, ref, acc, query, index)
    [query_num, ~] = size(query);
    [~, site_num] = size(acc);
    r = 0;
    for ii=1:query_num
        cond = and(max(ismember(find(query(ii,:) == 1), new_order(1:index))) == 1, ...
                   max(ismember(find(query(ii,:) == 1), new_order(index+1:end))) == 1);
        if cond
            for jj=1:site_num
                r = r + ref(ii, jj) * acc(ii, jj);
            end
        end
    end
end