# Выболнить большую часть заданий ниже - привести примеры кода под каждым комментарием


#===========================================================================================
1. Переменные и константы, области видимости, cистема типов:
приведение к типам,
конкретные и абстрактные типы,
множественная диспетчеризация,
=#

# Что происходит с глобальной константой PI, о чем предупреждает интерпретатор?
const PI = 3.14159
PI = 3.14

# Что происходит с типами глобальных переменных ниже, какого типа `c` и почему?
a = 1
b = 2.0
c = a + b

# Что теперь произошло с переменной а? Как происходит биндинг имен в Julia?
a = "foo"

# Что происходит с глобальной переменной g и почему? Чем ограничен биндинг имен в Julia?
g::Int = 1
g = "hi"
# Julia строго проверяет типы, когда переменная была явно типизирована. 
#В данном случае, g была объявлена как Int, и попытка присвоить ей значение другого типа 
#(String) вызывает ошибку.
function greet()
    g = "hello"
    println(g)
end
greet()

# Чем отличаются присвоение значений новому имени - и мутация значений?
v = [1,2,3]
z = v
v[1] = 3
v = "hello"
z
#Присвоение создаёт новую связь между именем и значением, не изменяя исходный объект.

#Мутация изменяет внутреннее состояние объекта, на который ссылается имя.
# Написать тип, параметризованный другим типом

struct Box{T}
    value::T
end
# Создаём Box для Int
int_box = Box{Int}(10)
println(int_box.value)  # Выведет 10

# Создаём Box для String
str_box = Box{String}("Hello")
println(str_box.value)  # Выведет "Hello"

# Создаём Box для Float64
float_box = Box{Float64}(3.14)
println(float_box.value)  # Выведет 3.14
#=
Написать функцию для двух аругментов, не указывая их тип,
и вторую функцию от двух аргментов с конкретными типами,
дать пример запуска
=#
# Общий метод для любых типов
function add1(a, b)
    return a + b
end

# Специализированный метод для Int
function add2(a::Int, b::Int)
    return a + b
end

# Специализированный метод для String
function add3(a::String, b::String)
    return string(a, b)
end
# Используется общий метод
println(add1(2.5, 3.7))  # Выведет 6.2

# Используется метод для Int
println(add2(2, 3))  # Выведет 5

# Используется метод для String
println(add3("Hello, ", "World!"))  # Выведет "Hello, World!"
#=
Абстрактный тип - ключевое слово? abstract type
Примитивный тип - ключевое слово? primitive type
Композитный тип - ключевое слово? struct
=#

#=
Написать один абстрактный тип и два его подтипа (1 и 2)
Написать функцию над абстрактным типом, и функцию над её подтипом-1
Выполнить функции над объектами подтипов 1 и 2 и объяснить результат
(функция выводит произвольный текст в консоль)
=#
# Абстрактный тип и подтипы
abstract type Animal end

struct Dog <: Animal
    name::String
end

struct Cat <: Animal
    name::String
end

# Функция для абстрактного типа
function make_sound(animal::Animal)
    println("This animal makes a sound.")
end

# Функция для подтипа Dog
function make_sound(dog::Dog)
    println("$(dog.name) says: Woof!")
end


# Функция для подтипа Cat
function make_sound(dog::Cat)
    println("$(dog.name) says: Miay!")
end
# Создание объектов
dog = Dog("Sharik")
cat = Cat("Tom")

# Вызов функций
make_sound(dog)  # Buddy says: Woof!
make_sound(cat)  # This animal makes a sound.


#===========================================================================================
2. Функции:
лямбды и обычные функции,
переменное количество аргументов,
именованные аргументы со значениями по умолчанию,
кортежи
=#

# Пример обычной функции
# Обычная функция
# Обычная функция
function greet(name)
    println("Hello, $name!")
end

# Лямбда-функция
square = x -> x^2



# Функция с именованными аргументами
function greet_person(; name!, age)
    println("Hello, $name! You are $age years old.")
end


# Вызов функций
greet("Alice")  # Hello, Alice!
println(square(4))  # 16
println(sum_all(1, 2, 3, 4))  # 10
greet_person(name="Bob", age=30) 








# Пример функции с переменным количеством аргументов
function sum_all(args...)
    return sum(args)
end
Base.sum
sum_all(1,2,3)

sum_all(1,2,3)


#=
Передать кортеж в функцию, которая принимает на вход несколько аргументов.
Присвоить кортеж результату функции, которая возвращает несколько аргументов.
Использовать splatting - деструктуризацию кортежа в набор аргументов.
=#
# Функция, принимающая три аргумента
function sum_three(a, b, c)
    return a + b + c
end

# Кортеж
my_tuple = (1, 2, 3)

# Передача кортежа в функцию с использованием splatting
result = sum_three(my_tuple...)
println(result)  

#===========================================================================================
3. loop fusion, broadcast, filter, map, reduce, list comprehension
=#

#=
Перемножить все элементы массива
- через loop fusion и
- с помощью reduce
=#
# Массив
arr = [1, 2, 3, 4, 5]

# Перемножение элементов через loop fusion
function multiply_elements(arr)
    result = 1
    for x in arr
        result *= x
    end
    return result
end
result = multiply_elements(arr)
println(result)  
#=
Написать функцию от одного аргумента и запустить ее по всем элементам массива
с помощью точки (broadcast)
c помощью map
c помощью list comprehension
указать, чем это лучше явного цикла?
=#

# Функция, которая удваивает значение
function double(x)
    return 2 * x
end

# Массив
arr = [1, 2, 3, 4, 5]

# Broadcasting
result_broadcast = double.(arr)
println("Broadcasting: ", result_broadcast)  

# map
result_map = map(double, arr)
println("map: ", result_map)  

# List comprehension
result_comprehension = [double(x) for x in arr]
println("List comprehension: ", result_comprehension)  

# Явный цикл
function apply_function_with_loop(func, arr)
    result = similar(arr)
    for i in eachindex(arr)
        result[i] = func(arr[i])
    end
    return result
end

result_loop = apply_function_with_loop(double, arr)
println("Explicit loop: ", result_loop)  
# Перемножить вектор-строку [1 2 3] на вектор-столбец [10,20,30] и объяснить результат

# Вектор-строка
row_vector = [1 2 3]  

# Вектор-столбец
col_vector = [10, 20, 30]  

# Умножение
result = row_vector * col_vector
println(result)  
# В одну строку выбрать из массива [1, -2, 2, 3, 4, -5, 0] только четные и положительные числа
# Исходный массив
arr = [1, -2, 2, 3, 4, -5, 0]
result_filter = filter(x -> x % 2 == 0 , arr)
println("Четные: ", result_filter)  

# Функция filter
result_filter = filter(x -> x > 0 , arr)
println("Положительные: ", result_filter)  
result_filter = filter(x -> x > 0 && x % 2 == 0, arr)
println("Filter: ", result_filter)  # Выведет: [2, 4]

# Объяснить следующий код обработки массива names - что за number мы в итоге определили?
using Random
Random.seed!(123)
names = [rand('A':'Z') * '_' * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]
# ---
same_names = unique(map(y -> split(y, ".")[1], filter(x -> startswith(x, "A"), names)))
numbers = parse.(Int, map(x -> split(x, "_")[end], same_names))
numbers_sorted = sort(numbers)
number = findfirst(n -> !(n in numbers_sorted), 0:9)

# Упростить этот код обработки:


#===========================================================================================
4. Свой тип данных на общих интерфейсах
=#

#=
написать свой тип ленивого массива, каждый элемент которого
вычисляется при взятии индекса (getindex) по формуле (index - 1)^2
=#
# Определение типа
struct LazyArray
    size::Int
end

# Реализация getindex
import Base: getindex

function getindex(arr::LazyArray, index::Int)
    if index < 1 || index > arr.size
        throw(BoundsError(arr, index))
    end
    return (index - 1)^2
end

# Реализация size
import Base: size

function size(arr::LazyArray)
    return (arr.size,)
end

# Пример использования
arr = LazyArray(5)

println(arr[1])  
println(arr[2])  
println(arr[3])  
println(arr[4])  
println(arr[5])  
#=
Написать два типа объектов команд, унаследованных от AbstractCommand,
которые применяются к массиву:
`SortCmd()` - сортирует исходный массив
`ChangeAtCmd(i, val)` - меняет элемент на позиции i на значение val
Каждая команда имеет конструктор и реализацию метода apply!
=#
# Абстрактный тип
abstract type AbstractCommand end

# Команда сортировки
struct SortCmd <: AbstractCommand
    SortCmd() = new()
end

function apply!(cmd::SortCmd, target::Vector)
    sort!(target)
    return target
end

# Команда изменения элемента
struct ChangeAtCmd <: AbstractCommand
    i::Int
    val::Any

    function ChangeAtCmd(i::Int, val::Any)
        if i < 1
            throw(ArgumentError("Index must be positive"))
        end
        new(i, val)
    end
end

function apply!(cmd::ChangeAtCmd, target::Vector)
    if cmd.i > length(target)
        throw(BoundsError(target, cmd.i))
    end
    target[cmd.i] = cmd.val
    return target
end

# Пример использования
arr = [3, 1, 4, 1, 5, 9]

sort_cmd = SortCmd()
apply!(sort_cmd, arr)
println("After SortCmd: ", arr)  # [1, 1, 3, 4, 5, 9]

change_cmd = ChangeAtCmd(3, 10)
apply!(change_cmd, arr)
println("After ChangeAtCmd: ", arr)  # [1, 1, 10, 4, 5, 9]
abstract type AbstractCommand end
#apply!(cmd::AbstractCommand, target::Vector) = error("Not implemented for type $(typeof(cmd))")


# Аналогичные команды, но без наследования и в виде замыканий (лямбда-функций)


#===========================================================================================
5. Тесты: как проверять функции?
=#

# Написать тест для функции
using Test

# Тесты для SortCmd
@testset "SortCmd Tests" begin
    arr = [3, 1, 4, 1, 5, 9]
    expected = [1, 1, 3, 4, 5, 9]

    apply!(SortCmd(), arr)
    @test arr == expected
end

# Тесты для ChangeAtCmd
@testset "ChangeAtCmd Tests" begin
    arr = [1, 2, 3, 4, 5]

    apply!(ChangeAtCmd(3, 10), arr)
    @test arr == [1, 2, 10, 4, 5]

    @test_throws BoundsError apply!(ChangeAtCmd(10, 10), arr)
    @test_throws ArgumentError ChangeAtCmd(-1, 10)
end

#===========================================================================================
6. Дебаг: как отладить функцию по шагам?
=#

#=
Отладить функцию по шагам с помощью макроса @enter и точек останова
=#
using Pkg
Pkg.add("Debugger")
function my_function(x, y)
    z = x + y
 
    z * 2
end

using Debugger: @enter
@enter my_function(3, 4)

#===========================================================================================
7. Профилировщик: как оценить производительность функции?
=#

#=
Оценить производительность функции с помощью макроса @profview,
и добавить в этот репозиторий файл со скриншотом flamechart'а
=#
function generate_data(len)
    vec1 = Any[]
    for k = 1:len
        r = randn(1,1)
        append!(vec1, r)
    end
    vec2 = sort(vec1)
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)
    return vec3
end

@time generate_data(1_000_000);

using Pkg
Pkg.add("ProfileView")
Pkg.add("Profile")
using ProfileView

function generate_data(len)
    vec1 = Vector{Float64}(undef, len)  # Предварительное выделение памяти
    for k = 1:len
        vec1[k] = randn()  # Заполнение массива
    end
    vec2 = sort(vec1)  # Сортировка
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)  # Математические операции
    return vec3
end

# Профилируем функцию
@profview generate_data(1_000_000)
# Переписать функцию выше так, чтобы она выполнялась быстрее:


#===========================================================================================
8. Отличия от матлаба: приращение массива и предварительная аллокация?
=#

#=
Написать функцию определения первой разности, которая принимает и возвращает массив
и для каждой точки входного (x) и выходного (y) выходного массива вычисляет:
y[i] = x[i] - x[i-1]
=#
function difference(x::Vector{T}) where T <: Number
    # Создаём массив для результата
    y = similar(x)

    # Первый элемент не имеет предыдущего, поэтому оставляем его равным 0
    y[1] = 0

    # Вычисляем разности для остальных элементов
    for i in 2:length(x)
        y[i] = x[i] - x[i-1]
    end

    return y
end

# Входной массив
x = [10, 15, 20, 25, 30]

# Вычисляем первую разность
y = difference(x)

println("Входной массив: ", x)
println(" Разность: ", y)
#=
Аналогичная функция, которая отличается тем, что внутри себя не аллоцирует новый массив y,
а принимает его первым аргументом, сам массив аллоцируется до вызова функции
=#
function first_difference!(y::Vector{T}, x::Vector{T}) where T <: Number
    # Проверка размеров массивов
    if length(y) != length(x)
        throw(ArgumentError("Массивы y и x должны иметь одинаковую длину"))
    end

    # Первый элемент не имеет предыдущего, поэтому оставляем его равным 0
    y[1] = 0

    # Вычисляем разности для остальных элементов
    for i in 2:length(x)
        y[i] = x[i] - x[i-1]
    end

    return y
end
#=
Написать код, который добавляет элементы в конец массива, в начало массива,
в середину массива
=#
# Исходный массив
arr = [10, 20, 30]

# Добавляем элемент в конец
push!(arr, 40)
println("После добавления в конец: ", arr)  # Вывод: [10, 20, 30, 40]

# Добавляем элемент в начало
pushfirst!(arr, 5)
println("После добавления в начало: ", arr)  # Вывод: [5, 10, 20, 30, 40]

# Добавляем элемент в середину
insert!(arr, 3, 15)
println("После добавления в середину: ", arr)  # Вывод: [5, 10, 15, 20, 30, 40]

#===========================================================================================
9. Модули и функции: как оборачивать функции внутрь модуля, как их экспортировать
и пользоваться вне модуля?
=#


#=
Написать модуль с двумя функциями,
экспортировать одну из них,
воспользоваться обеими функциями вне модуля
=## 


module Foo2
    # Экспортируем функцию exported_function
export exported_function1



function exported_function1(x)
    return x * 2
end


function exported_function2(x)
    return x + 10
end

end
using .Foo2
import .Foo2 
exported_function1(10)
exported_function2(2)
#===========================================================================================
10. Зависимости, окружение и пакеты
=#

# Что такое environment, как задать его, как его поменять во время работы?
#изолированная среда, которая содержит список пакетов и их версий, используемых в проекте
using Pkg
Pkg.activate(".")
# Что такое пакет (package), как добавить новый пакет?
Pkg.add("Profile")
# Как начать разрабатывать чужой пакет?

#=
Как создать свой пакет?
(необязательно, эксперименты с PkgTemplates проводим вне этого репозитория)
=#


#===========================================================================================
11. Сохранение переменных в файл и чтение из файла.
Подключить пакеты JLD2, CSV.
=#
using Pkg
Pkg.add("JLD2")  # Для работы с бинарными файлами
Pkg.add("CSV")   # Для работы с CSV-файлами
Pkg.add("DataFrames")  # Для удобной работы с таблицами (опционально)
# Сохранить и загрузить произвольные обхекты в JLD2, сравнить их
using JLD2

# Создадим произвольные объекты
array = [1, 2, 3, 4]
dict = Dict("a" => 1, "b" => 2)
custom_object = (name="Julia", version=1.8, features=["fast", "dynamic", "open-source"])

# Сохраним объекты в файл
@save "objects.jld2" array dict custom_object

# Загрузим объекты из файла
@load "objects.jld2" array dict custom_object

println("Загруженный массив: ", array)
println("Загруженный словарь: ", dict)
println("Загруженный пользовательский объект: ", custom_object)
# Сохранить и загрузить табличные объекты (массивы) в CSV, сравнить их
using CSV
using DataFrames
# Создадим табличные данные (массив)
table = [1 2 3; 4 5 6; 7 8 9]
df = DataFrame(table, :auto) 
# Сохраним массив в CSV-файл
CSV.write("table.csv", df)

# Загрузим массив из CSV-файла
loaded_table = CSV.read("table.csv", DataFrame)

println("Загруженная таблица:")
println(loaded_table)

#===========================================================================================
12. Аргументы запуска Julia
=#

#=
Как задать окружение при запуске?
=#

#=
Как задать скрипт, который будет выполняться при запуске:
а) из файла .jl
б) из текста команды? (см. флаг -e)
=#
#б) julia -e 'println("Привет из командной строки!")'
#=
После выполнения задания Boids запустить julia из командной строки,
передав в виде аргумента имя gif-файла для сохранения анимации
=#
