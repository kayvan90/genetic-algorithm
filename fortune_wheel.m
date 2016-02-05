function choice = fortune_wheel(weights)

new_weights = sum(weights) - weights;
accumulation = cumsum(new_weights);
p = rand() * accumulation(end);
choice = find(accumulation>p,1);

% chosen_index = -1;
% 
% for index = 1 : length(accumulation)
%     if (accumulation(index) > p)
%         chosen_index = index;
%         break;
%     end
% end

end