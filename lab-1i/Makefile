CC	= arm-linux-gnueabihf-gcc
CFLAGS	= -O1 -Wall
#CFLAGS	= -O1 -Wall -DCONFIG_PERF_OUTPUT_FILE=\"fib-non-recursive.dat\"
LDFLAGS = -fno-stack-protector

objects	= fibseq.o fib.o

default: fibseq

.PHONY: default clean qemu

fibseq: $(objects)
	$(CC) $(LDFLAGS) -o $@ $^

fib.o: fib.s
fibseq.o: fibseq.c

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o: %.s
	$(CC) -c $(CFLAGS) -o $@ $<

clean:
	rm -f $(objects) fibseq

QEMU_CMD = qemu-arm -L /usr/arm-linux-gnueabihf ./fibseq &
UNITTEST_CMD = ./unittest.sh ./fibseq
CMD = yes 9 | $(call QEMU_CMD) && sleep 1
qemu: fibseq
	@$(UNITTEST_CMD)
