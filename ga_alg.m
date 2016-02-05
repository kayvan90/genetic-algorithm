function [generation_hist] = ga_alg(fit_func, dim, var_min, var_max, pop_size, max_gen)
% genetic algorithm function
disp('optimizing...');
%% to be returned:
generation_hist = zeros(1, max_gen);

%% initialize:
mu_rate = .03;
cross_rate = .5;
population = (var_max - var_min) .* rand(pop_size, dim) + var_min;
pop_fit = zeros(1, pop_size);


%% Main Loop
for itr=1:max_gen
    % calc fitness:
    for i=1:pop_size
        pop_fit(i) = fit_func(population(i,:));
    end
    % elite:
    [~, elite_id] = min(pop_fit);
    elite = population(elite_id,:);
    % selection & crossover:
    k = ceil(cross_rate * pop_size + .5);
    [~, to_multiply] = sort(pop_fit);
    to_multiply = to_multiply(1:k);
    for candid = to_multiply
        child = zeros(1, dim);
        par1 = candid;
        par2 = fortune_wheel(pop_fit);
        for g=1:dim
            if rand >= .5
                child(g) = population(par1, g);
            else
                child(g) = population(par2, g);
            end
        end
        % mutation:
        for g=1:dim
            if rand < mu_rate
                child(g) = (var_max - var_min)*rand + var_min;
            end
        end
        
        % replace:
        child_fit = fit_func(child);
        [worse, worse_id] = max(pop_fit);
        if child_fit <= worse
            population(worse_id,:) = child;
            pop_fit(worse_id) = child_fit;
        end
    end
    population(elite_id, :) = elite; % save elite in population
    % report:
    generation_hist(itr) = min(pop_fit);
end

end