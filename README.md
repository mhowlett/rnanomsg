## rnanomsg

An R binding for <a href="http://nanomsg.org">nanomsg</a>.

### Development Status

Getting fairly complete now but mostly untested. I wouldn't use it yet, come back in about a week.

It is now a package, but it probably won't build/install correctly on your system (unless it's Ubuntu 14.04)

Code review appreciated from anyone who has experience with R/C interop.

### Install Notes

#### Linux x86/x64

First build and install nanomsg:

     autoreconf -fi
     ./configure --enable-shared
     make
     make install
     ldconfig

Build the R package from the source with:

     R CMD build rnanomsg
     
From an r command prompt:

     install.packages("<path to package>", repos=NULL, type="source")
     library("rnanomsg")

#### Windows

Definitely won't work yet.


### Examples

Run the reqrep client and server demos in two different instances of R on the same maching:

demo("reqrepClient") 
demo("reqrepServer")

