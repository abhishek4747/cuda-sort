#include <iostream>
#include <stdlib.h>


using namespace std;

__global__ void add(int *a, int *b, int *c, int n){
	int index = threadIdx.x + blockIdx.x*blockDim.x;
	if (index < n){
		c[index] = a[index] + b[index];
	}
}

int main(int argc, char *argv[]){
	cout<<"****** Array Addition ******\n"<<endl;
	int *a, *b, *c;
	int size = 10;
	a = (int*) malloc(size*sizeof(int));
	b = (int*) malloc(size*sizeof(int));
	c = (int*) malloc(size*sizeof(int));

	int *d_a, *d_b, *d_c;

	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_b, size);
	cudaMalloc((void **)&d_c, size);
	
	

	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
	

	add<<<1,10>>>(d_a, d_b, d_c, size);
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	free(a);
	free(b);
	free(c);
	return 0;
}

