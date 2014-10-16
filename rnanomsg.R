# Copyright (c) 2014 Matthew Howlett
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights 
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


# sp address families
AF_SP <- 1
AF_SP_RAW <- 2


# protocols
NN_PROTO_REQREP <- 3
NN_REQ <- NN_PROTO_REQREP * 16 + 0
NN_REP <- NN_PROTO_REQREP * 16 + 1


nn_socket <- function(domain, protocol) {
  res <- .C("rnn_socket", 
    as.integer(domain), as.integer(protocol), result=integer(1))
  res[["result"]]
}

nn_close <- function(s) {
  res <- .C("rnn_close",
    as.integer(s), result = integer(1))
  res[["result"]]
}

nn_shutdown <- function(s, how) {
  res <- .C("rnn_shutdown",
    as.integer(s), as.integer(how), result = integer(1))
  res[["result"]]
}

nn_connect <- function(s, addr) {
  res <- .C("rnn_connect", as.integer(s), addr, result=integer(1))
  res[["result"]]
}

nn_bind <- function(s, addr) {
  res <- .C("rnn_bind", as.integer(s), addr, result=integer(1))
  res[["result"]]
}

