## rnanomsg

rnanomsg is an R binding for <a href="http://nanomsg.org">nanomsg</a>.

### Development Status

Incomplete - I've written just the bits that I need for myself. Should find time to flesh this out more and turn it into a package sometime over the next week or two.

### Building Notes

#### Linux x86/x64

Build nanomsg:

     autoreconf -fi
     ./configure --enable-shared
     make
     make install

.so library is in /usr/local/lib

Update the rnanomsg Makefile to reflect the location of libraries and includes on your system and then make.

#### Windows

more difficult. not tried.


### Usage

Look at rnanomsg.R for what's implemented.

    source('rnanomsg.R')

There are two test functions in rnanomsg.R - rnanomsg_test_client and rnanomsg_test_server. Run them in two instances of R on the same machine.
