#include <err.h>
#include <cuda.h>
#include <stdio.h>
#include <unistd.h>

#define BUFLEN (4096)

int
main(int argc, char *argv[])
{
	unsigned char host_buf[BUFLEN];
	unsigned char *gpu_buf;

	while (cudaMalloc(&gpu_buf, BUFLEN) == cudaSuccess) {
		if (cudaMemcpy(host_buf, gpu_buf, BUFLEN, cudaMemcpyDeviceToHost))
			err(1, "cudaMemcpy failed\n");
		write(STDOUT_FILENO, host_buf, BUFLEN);
	}

	return 0;
}
