#include <err.h>
#include <cuda.h>
#include <stdio.h>
#include <unistd.h>
#include <stdint.h>

#define BUFLEN (4096)

int byte_sum(uint8_t* bytes, int size)
{
    int i = 0;
    int sum = 0;
    for(; i< size; i++)
    {
        sum += bytes[i];
    }
    return sum;
}
void print_nonzeros(uint8_t* bytes, int size)
{
    int i = 0;
    for(; i< size; i++)
    {
        if (bytes[i] != 0)
            printf("%x", bytes[i]);
    }
    return;
}
    int
main(int argc, char *argv[])
{
    unsigned char host_buf[BUFLEN];
    unsigned char *gpu_buf;
    uint64_t num_bytes =0;

    while (cudaMalloc(&gpu_buf, BUFLEN) == cudaSuccess) {
        num_bytes+=BUFLEN;
        if (cudaMemcpy(host_buf, gpu_buf, BUFLEN, cudaMemcpyDeviceToHost))
            err(1, "cudaMemcpy failed\n");
    
        if (byte_sum(host_buf, BUFLEN) < 768)
        {
            continue;
        }
        write(fileno(stdout), host_buf, BUFLEN);
        printf("\n");
    }
    printf("%lld bytes copied\n",num_bytes);

    return 0;
}
