# переписать ниже примеры из первого часа из видеолекции: 
# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции
println("Huber")
myAnswer=42
typeof(myAnswer)
myPi=3.14
typeof(myPi)
myName="Jane"
typeof(myName)
# How to comment
#=
Матеатический синтаксис
=#
sum=1+7
differ=10-3
prod=20*5
qq=100/2
power=2^2
modulus=102%20
# How to get String
s1="I am a string"
s2="""I am also a string"""
typeof('a')
#string intrrpolation
name="Jane"
numFingers=10
numToes=10
println("Hello, my name is $name. ")
println("I have $numFingers fingers and $numToes toes")
string("How many cats","are to many cats")
string("How many cats ", 10 ," are to many cats")
s3="How many cats"
s4="are too many  cats"
s3*s4
#date structures
iphonebook=Dict("Jenny"=>"867-5309","Gost"=>"888-4596")
iphonebook["Jenny7"]="555-Filk"
iphonebook
pop!(iphonebook,"Jenny7")
iphonebook[0]
iphonebook[1]
#Tuples
myfavoriteAnimals=("penguins","cats","sugargliders")
myfavoriteAnimals[1]
# arrays
myFriends=["Ted","Wet"]
fibonscci=[1,1,2,3,5,8,13]
mix=[1,1.2,"hi"]
myFriends[1]
push!(fibonscci,21)
pop!(fibonscci)
fibonscci
favorites=[["aa","bb","cc"],["a1","b1","c1"]]
numbers=[[1,2,3],[2,3,4],[2,35,5]]
rand(4,3)
rand(4,3,2)
#циклы
n=0
while n<10
    n+=1
    println(n)
end

for n in 1:10
    println(n)
end
myFriend=["Ted","Robyn","Barney","Lily","Marshall"]
for friend in myFriend
  println("Hi $friend, it is great to ee you!")
end
m,n =5,6
A=zeros(m,n)
for i in 1:m
    for j in 1:n
        A[i,j]=i+j
    end
end
A
# alternativly
B=zeros(m,n)
for i in 1:m,j in 1:n
    B[i,j]=i+j
end
B
C=[i+j for i in 1:m,j in 1:n]
F=0
for n in 1:10
    F=[i+j for i in 1:n,j in 1:n]
    display(F)
end
F
# Conditionals
x=3
y=4
if x>y 
    println("$x is larger than $y")
elseif y>x 
    println("$y is larger than $x")
else  
     println("$x and $y are equal")
end

if x>y
    x
else
    y
end

(x>y) ? x : y
(x>y) && println("$x is larger than $y")
(x<y) && println("$y is larger than $x")
#Functions
function  sayhi(name)
    println("hi $name, it is great to see you!")
    
end
sayhi("jon")
function f(x)
    x^2  
end
f(42)
A= rand(3,3)
A
f(A)
v=rand(3)
f(v)
v=[2,3,5]
sort(v)

# broadcast
A=[i+3*j for j in 0:2, i in 1:3]
f(A)
B=f.(A)
A[2,2]
A[2,2]^2
B[2,2]
v=[1,2,3]
f.(v)
#Packeges
using  Example
#Pkg.add("Example")
using  Colors
palette =distinguishable_colors(100)
rand(palette,3,3)
# Plotting

using Plots
import Pkg; Pkg.add("Plots")
Pkg.add("Plots")
x=-3:0.1:3
f(x)=x^2
y=f.(x)
gr()
plot(x,y,label="line")
scatter(x,y,label="poins")
plotlyjs()
plot(x,y,label="line")
scatter!(x,y,label="poins")

globaltempreture[]

# Multiple date
methods(+)
@which 3+3
@which 5.0+5.1
@which 3+3.0
import Base:+
"hello"+"world!"
@which "hello"+"word!"
+(x::String,y::String)= string(x,y)
"hello"+"world!"
"hello"+"world!"
@which "hello"+"word!"
foo(x,y)=println("duck-typed foo!")
foo(x::Int,y::Float64)=println("foo with an integer and float")
foo(x::Float64,y::Float64)=println("foo with an float and float")
foo(x::Int,y::Int)=println("foo with an integer and intrger")
foo(1,1)
foo(1.,1.)
foo(1,1.0)
# Basic linar algebra
A=rand(1:4,3,3)
B=A
C=copy(A)
[B C]
A[1]=17
[B C]
x=ones(3)
b=A*x
Asym= A+A'
A'#transpose matrix
A
Apd=A'A
A\b
Atall=A[:,1:2]
display(Atall)
Atall\b
A=rand(3,3)
[A[:,1]A[:,1]]\b
Ashort=A[1:2,:]
display(Ashort)
Ashort\b[1:2]
