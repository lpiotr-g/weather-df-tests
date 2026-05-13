def fibonacciTen():
    print("Calculating Fibonacci sequence up to 10 numbers:")
    for i, val in enumerate(fibonacci(10)):
        print(f"Fibonacci({i}) = {val}")

def fibonacci(number: int):
    fib = [0, 1]
    while len(fib) < number:
        fib.append(fib[-1] + fib[-2])
    return fib[:number]