all: rnanomsg

rnanomsg: objs
	gcc -std=gnu99 -shared -o rnanomsg.so rnanomsg.o -L/usr/lib/R/lib -lR -lnanomsg

objs: rnanomsg.c
	gcc  -std=gnu99 -I/usr/local/include -I/usr/share/R/include -DNDEBUG -fpic -O3 -pipe -g -c rnanomsg.c -o rnanomsg.o

clean:
	rm -f *~
	rm -f rnanomsg.so
	rm -f *.o
