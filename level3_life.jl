
using Plots


# New code
mutable struct Life2
    step1 ::Matrix{Int}
    step2 ::Matrix{Int}
end
function step(state::Life2)
    curr = state.step1
    next = state.step2
    n, m = size(curr)

    for i in 1:n, j in 1:m
        # Считаем количество живых соседей с учётом периодических граничных условий (тор)
        live_neighbors = 0
        for di in -1:1, dj in -1:1
            if di == 0 && dj == 0
                continue
            end
            ni, nj = mod1(i + di, n), mod1(j + dj, m)
            live_neighbors += curr[ni, nj]
        end

        # Применяем правила игры "Жизнь"
        if curr[i, j] == 1
            if live_neighbors == 2 || live_neighbors == 3
                next[i, j] = 1
            else
                next[i, j] = 0
            end
        else
            if live_neighbors == 3
                next[i, j] = 1
            else
                next[i, j] = 0
            end
        end
    end

    # Меняем текущий и следующий кадры местами
    state.step1, state.step2 = state.step2, state.step1

    return nothing
end
function main1(ABGR)
    a,b =1000, 1000
    initalization=rand(0:1,a,b)
    game=Life2(initalization,zeros(a,b))
    anim = @animate for time = 1:100
        step(game)   
        cf=game.step1
        custom_colors = cgrad([:black, :green])    
        white_pixels = sum(cf .== 1)
        black_pixels = sum(cf .== 0)

        # Создаём heatmap
       
        # Добавляем текстовую аннотацию с количеством живых и мёртвых клеток
       
        plt = heatmap(cf, color=custom_colors, clim=(0, 1), 
        aspect_ratio=1, axis=false, legend=false, title="Шаг $time Живые: $white_pixels, Мёртвые: $black_pixels")  
       
    end
    
    gif( anim, "life1.gif", fps = 10)
end
main1("")
