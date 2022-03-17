function [YY Q1] = uniqueroute(XX, QQ)

[rows, cols] = size(XX);

YY = zeros(rows, cols);
Q1 = zeros(1, cols);
act_size = 1;
YY(act_size, :) = XX(1,:);
Q1(act_size) = QQ(1);
for i=2:rows,
    if ((QQ(i-1) ~= QQ(i)) || ~isequal(XX(i-1,:), XX(i,:))),
        act_size = act_size + 1;
        YY(act_size, :) = XX(i,:);
        Q1(act_size) = QQ(i);
    end
end

YY = YY(1:act_size, :);
Q1 = Q1(1:act_size);

end %uniqueroute