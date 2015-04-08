T = 10
P = 1
S = q

G_ARGS = 

all:
	echo "try 'make test'"

bhelper: helper.cu
	nvcc $(G_ARGS) helper.cu -o helper.o

bpquick: pquick.cu
	nvcc $(G_ARGS) pquick.cu 

bquick: quicksort.cu
	nvcc $(G_ARGS) quicksort.cu -o quicksort.o 

bmerge: mergesort.cu
	nvcc $(G_ARGS) mergesort.cu -o mergesort.o

bradix: radixsort.cu
	nvcc $(G_ARGS) radixsort.cu 

bother: othersort.cu
	nvcc $(G_ARGS) othersort.cu 

bsort: sort.cu
	nvcc $(G_ARGS) sort.cu

ball: bquick bmerge bradix bother bsort bpquick bhelper

blib: ball
	nvcc -shared -o libpsort.so quicksort.o mergesort.o radixsort.o othersort.o sort.o pquick.o helper.o

btest: blib test.cu 
	nvcc -fopenmp test.cu -o test -L. -lpsort

test: btest
	LD_LIBRARY_PATH=. ./test $(T) $(P) $(S)

clean:
	rm -f *.o
	rm -f *.so
	rm -f test
	rm -f *.out
	clear

small: bquick bmerge bhelper
	nvcc --shared -o libpsort.so quicksort.o mergesort.o helper.o
		

