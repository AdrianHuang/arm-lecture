set terminal pngcairo size 1024,768 enhanced font 'Verdana,10'
set output "fib-non-recursive.png"
set autoscale
set grid
set title 'Execution Time of Fibonacci Number'
set xlabel "F(n)"
set ylabel "Execution Time (seconds)"
plot 'fib-non-recursive.dat' w lp t 'Non-recursive'
