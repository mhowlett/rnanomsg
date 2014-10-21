## rnanomsg

rnanomsg is an R binding for <a href="http://nanomsg.org">nanomsg</a>.

### Development Status

Check back again in about a week..

Getting fairly complete now but mostly untested.

Is now a package, but it probably won't build/install correctly on your system (unless it's Ubuntu 14.04)

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


### Usage

Look at R/exmples.R for a bit of an idea
