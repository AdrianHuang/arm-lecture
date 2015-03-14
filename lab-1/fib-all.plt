set terminal pngcairo size 1024,768 enhanced font 'Verdana,10'
set output "fib.png"
set autoscale
set grid
set title 'Execution Time of Fibonacci Number (Recursive versus Non-recursive)'
set xlabel "F(n)"
set ylabel "Execution Time (seconds)"
plot 'fib-recursive.dat' w lp t 'Recursive', 'fib-non-recursive.dat' w lp t 'Non-recursive'
