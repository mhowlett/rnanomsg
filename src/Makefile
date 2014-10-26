CPPFLAGS = $(shell R CMD config --cppflags)
CC = $(shell R CMD config CC)
SHLIB_LD = $(shell R CMD config SHLIB_LD)
CFLAGS = $(shell R CMD config CFLAGS)
SHLIB_LDFLAGS = $(shell R CMD config SHLIB_LDFLAGS)
CPICFLAGS = $(shell R CMD config CPICFLAGS)
LDFLAGS = $(shell R CMD config --ldflags)

all: rnanomsg

rnanomsg: objs
	$(SHLIB_LD) $(SHLIB_LDFLAGS) -o rnanomsg.so rnanomsg.o $(LDFLAGS) -lnanomsg

objs: rnanomsg.c
	$(CC) $(CPPFLAGS) $(CPICFLAGS) $(CFLAGS) -c rnanomsg.c -o rnanomsg.o

clean:
	rm -f *~
	rm -f rnanomsg.so
	rm -f *.o
