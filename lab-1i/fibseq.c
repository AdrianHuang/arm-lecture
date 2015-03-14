#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

#ifdef CONFIG_PERF_OUTPUT_FILE
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <sys/time.h>
#include <fcntl.h>

#define PERF_FILE CONFIG_PERF_OUTPUT_FILE
#endif

extern int fibonacci(int x);

void usage(char *filename)
{
	printf("Usage: %s fibonacci_number\n", filename);
	return;
}

int main(int argc, char **argv)
{
  int number=0;
  int result=0;
#ifdef CONFIG_PERF_OUTPUT_FILE
  struct timeval tv1, tv2;

  int fd;
  char buf[32];
#endif

  if (argc != 2) {
	  usage(argv[0]);
	  return -EINVAL;
  }

#ifdef CONFIG_PERF_OUTPUT_FILE
  if((fd = open(PERF_FILE, O_WRONLY | O_CREAT | O_APPEND, 0644)) == -1) {
	fprintf(stderr, "Cannot open %s\n", PERF_FILE);
	exit(1);
  }

  gettimeofday(&tv1, NULL);
#endif

  number = atoi(argv[1]);
  result = fibonacci(number);   

#ifdef CONFIG_PERF_OUTPUT_FILE
  gettimeofday(&tv2, NULL);
#endif

  printf("The fibonacci sequence at %d is: %d\n", number, result);

#ifdef CONFIG_PERF_OUTPUT_FILE

  sprintf (buf, "%d\t%f\n", number,
		(double) (tv2.tv_usec - tv1.tv_usec) / 1000000 +
		(double) (tv2.tv_sec - tv1.tv_sec));
  if(write(fd, buf, strlen(buf)) == -1) {
	fprintf(stderr, "Failed to write content '%s' to file %s \n",
		buf, PERF_FILE);
  }

  close(fd);
#endif

  return 0;
}

