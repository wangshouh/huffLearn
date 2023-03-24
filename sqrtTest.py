import sys
import math

def main():
	input = eval(sys.argv[1])
	sqrt_result = math.floor((math.sqrt(input)))
	print("{:0>64x}".format(sqrt_result), end="")

if __name__ == '__main__':
	main()