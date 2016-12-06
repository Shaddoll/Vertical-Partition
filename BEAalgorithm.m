function [ca, new_order] = BEAalgorithm(aa)
    [row, line] = size(aa);
    caa = zeros(row, line);
    if row ~= line
        return;
    end
    caa(:,1:2) = aa(:,1:2);
    new_order = 1:line;
    for index = 3:line
        loc = index;
        maxVal = 0;
        for ii = 1:(index - 1)
            temp = contribution(aa, ii - 1, index, ii);
            if temp > maxVal
                loc = ii;
                maxVal = temp;
            end
        end
        temp = contribution(aa, index - 1, index, index + 1);
        if temp > maxVal
            loc = index;
        end
        for jj = index:-1:loc+1
            caa(:,jj) = caa(:,jj - 1);
            new_order(jj) = new_order(jj - 1);
        end
        caa(:,loc) = aa(:,index);
        new_order(loc) = index;
    end
    % ordering rows
    ca = caa;
    for ii=1:row
        ca(ii,:) = caa(new_order(ii),:);
    end
end

function r = bond(aa, ii, jj)
    r = 0;
    [~, line] = size(aa);
    if ii <= 0 || ii > line || jj <= 0 || jj > line
        return;
    end
    r = sum(aa(:,ii) .* aa(:, jj));
end

function r = contribution(aa, ii, jj, k)
    r = 2 * (bond(aa, ii, k) + bond(aa, jj, k) - bond(aa, ii, jj));
end