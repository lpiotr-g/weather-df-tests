from pyspark.sql import SparkSession

def fibonacci(n):
    fib = [0, 1]
    while len(fib) < n:
        fib.append(fib[-1] + fib[-2])
    return fib[:n]

if __name__ == "__main__":
    spark = SparkSession.builder.appName("Fibonacci").getOrCreate()
    print("Calculating Fibonacci sequence up to 10 numbers:")
    for i, val in enumerate(fibonacci(10)):
        print(f"Fibonacci({i}) = {val}")
    spark.stop()
