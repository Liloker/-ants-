function couple = parent_selection(Ws)

couple = [0 0];
for i = 1:2,
    while couple(i) == 0,
        couple(i) = ceil(rand* Ws);
    end
end

end %parent_selection