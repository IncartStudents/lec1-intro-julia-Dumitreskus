module Boids
using Plots
using LinearAlgebra

# Структура для хранения состояния одной птички
mutable struct Boid
    x::Float64      # Позиция по x
    y::Float64      # Позиция по y
    vx::Float64     # Скорость по x
    vy::Float64     # Скорость по y
end

# Структура для хранения состояния мира
mutable struct WorldState
    boids::Vector{Boid}  # Вектор птичек
    height::Float64      # Высота мира
    width::Float64       # Ширина мира
    vision_radius::Float64  # Радиус видимости для взаимодействия
    separation_weight::Float64  # Вес для разделения
    alignment_weight::Float64  # Вес для выравнивания
    cohesion_weight::Float64   # Вес для сплочения
    max_speed::Float64         # Максимальная скорость

    function WorldState(n_boids, width, height)
        # Создаем птичек со случайными позициями и скоростями
        boids = [Boid(rand() * width, rand() * height, rand() * 2 - 1, rand() * 2 - 1) for _ in 1:n_boids]
        new(boids, width, height, 5.0, 1.0, 1.0, 1.0, 2.0)
    end
end

# Функция для вычисления расстояния между двумя птичками
function distance(b1::Boid, b2::Boid)
    return sqrt((b1.x - b2.x)^2 + (b1.y - b2.y)^2)
end

# Правило разделения (Separation)
function separation(boid::Boid, state::WorldState)
    steer = (0.0, 0.0)
    count = 0
    for other in state.boids
        if other !== boid && distance(boid, other) < state.vision_radius
            diff = (boid.x - other.x, boid.y - other.y)
            steer = steer .+ diff
            count += 1
        end
    end
    if count > 0
        steer = steer ./ count
        steer = normalize(steer) .* state.max_speed
        steer = steer .- (boid.vx, boid.vy)
        steer = clamp.(steer, -state.max_speed, state.max_speed)
    end
    return steer
end

# Правило выравнивания (Alignment)
function alignment(boid::Boid, state::WorldState)
    avg_velocity = (0.0, 0.0)
    count = 0
    for other in state.boids
        if other !== boid && distance(boid, other) < state.vision_radius
            avg_velocity = avg_velocity .+ (other.vx, other.vy)
            count += 1
        end
    end
    if count > 0
        avg_velocity = avg_velocity ./ count
        avg_velocity = normalize(avg_velocity) .* state.max_speed
        steer = avg_velocity .- (boid.vx, boid.vy)
        steer = clamp.(steer, -state.max_speed, state.max_speed)
    else
        steer = (0.0, 0.0)
    end
    return steer
end

# Правило сплочения (Cohesion)
function cohesion(boid::Boid, state::WorldState)
    center_of_mass = (0.0, 0.0)
    count = 0
    for other in state.boids
        if other !== boid && distance(boid, other) < state.vision_radius
            center_of_mass = center_of_mass .+ (other.x, other.y)
            count += 1
        end
    end
    if count > 0
        center_of_mass = center_of_mass ./ count
        desired = center_of_mass .- (boid.x, boid.y)
        desired = normalize(desired) .* state.max_speed
        steer = desired .- (boid.vx, boid.vy)
        steer = clamp.(steer, -state.max_speed, state.max_speed)
    else
        steer = (0.0, 0.0)
    end
    return steer
end

# Нормализация вектора
function normalize(v)
    len = sqrt(v[1]^2 + v[2]^2)
    return len > 0 ? (v[1] / len, v[2] / len) : (0.0, 0.0)
end

# Обновление состояния мира
function update!(state::WorldState)
    for boid in state.boids
        sep = separation(boid, state)
        align = alignment(boid, state)
        coh = cohesion(boid, state)

        # Применяем правила с весами
        boid.vx += (sep[1] * state.separation_weight + align[1] * state.alignment_weight + coh[1] * state.cohesion_weight)
        boid.vy += (sep[2] * state.separation_weight + align[2] * state.alignment_weight + coh[2] * state.cohesion_weight)

        # Ограничиваем скорость
        speed = sqrt(boid.vx^2 + boid.vy^2)
        if speed > state.max_speed
            boid.vx = (boid.vx / speed) * state.max_speed
            boid.vy = (boid.vy / speed) * state.max_speed
        end

        # Обновляем позицию
        boid.x += boid.vx
        boid.y += boid.vy

        # Обеспечиваем периодические границы
        if boid.x > state.width
            boid.x -= state.width
        elseif boid.x < 0
            boid.x += state.width
        end

        if boid.y > state.height
            boid.y -= state.height
        elseif boid.y < 0
            boid.y += state.height
        end
    end
    return nothing
end

# Основная функция
function main()
    w = 100.0
    h = 100.0
    n_boids = 50

    state = WorldState(n_boids, w, h)

    anim = @animate for time = 1:200
        update!(state)
        
        # Получаем позиции и скорости для каждой птички
        x = [boid.x for boid in state.boids]
        y = [boid.y for boid in state.boids]
        u = [boid.vx for boid in state.boids]  # Компоненты скорости по x
        v = [boid.vy for boid in state.boids]  # Компоненты скорости по y

        # Рисуем стрелки
        quiver(x, y, quiver=(u, v), 
               xlim = (0, state.width), 
               ylim = (0, state.height), 
               legend = false, 
               title = "Boids Flocking Simulation",
               aspect_ratio = :equal)
    end
    gif(anim, "boids_flocking_arrows.gif", fps = 20)
end

export main

end

using .Boids
Boids.main()