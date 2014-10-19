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


dyn.load('rnanomsg.so')

# SP Address Families
AF_SP <- 1
AF_SP_RAW <- 2

# PAIR
NN_PROTO_PAIR <- 1
NN_PAIR <- NN_PROTO_PAIR * 16 + 0

# PUBSUB
NN_PROTO_PUBSUB <- 2
NN_PUB <- NN_PROTO_PUBSUB * 16 + 0
NN_SUB <- NN_PROTO_PUBSUB * 16 + 1
NN_SUB_SUBSCRIBE <- 1
NN_SUB_UNSUBSCRIBE <- 2

# REQREP
NN_PROTO_REQREP <- 3
NN_REQ <- NN_PROTO_REQREP * 16 + 0
NN_REP <- NN_PROTO_REQREP * 16 + 1

# PIPELINE
NN_PROTO_PIPELINE <- 5
NN_PUSH <- NN_PROTO_PIPELINE * 16 + 0
NN_PULL <- NN_PROTO_PIPELINE * 16 + 1

# SURVEY
NN_PROTO_SURVEY <- 6
NN_SURVEYOR <- NN_PROTO_SURVEY * 16 + 0
NN_RESPONDENT <- NN_PROTO_SURVEY * 16 + 1
NN_SURVEYOR_DEADLINE <- 1

# BUS
NN_PROTO_BUS <- 7
NN_BUS <- NN_PROTO_BUS * 16 + 0


nn_socket <- function(domain, protocol) {
  .Call("rnn_socket", as.integer(domain), as.integer(protocol))
}

nn_close <- function(s) {
  .Call("rnn_close", as.integer(s))
}

nn_shutdown <- function(s, how) {
  .Call("rnn_shutdown", as.integer(s), as.integer(how))
}

nn_connect <- function(s, addr) {
  .Call("rnn_connect", as.integer(s), addr)
}

nn_bind <- function(s, addr) {
  .Call("rnn_bind", as.integer(s), addr)
}

nn_send <- function(s, buf, flags) {
  .Call("rnn_send", as.integer(s), as.raw(buf), as.integer(flags))
}

nn_recv <- function(s, flags) {
  result <- .Call("rnn_recv", as.integer(s), as.integer(flags))
  list(rv = result[[1]], buf = result[[2]])
}

nn_device <- function(s1, s2) {
  .Call("rnn_device", as.integer(s1), as.integer(s2))
}

nn_term <- function() {
  .Call("rnn_term")
}

nn_errno <- function() {
  .Call("rnn_errno")
}

nn_strerror <- function(errnum) {
  .Call("rnn_strerror", as.integer(errnum))
}


rnanomsg_test_server <- function() {
  cat("server running...\n")
  s <- nn_socket(AF_SP, NN_REP)
  ep <- nn_bind(s, "tcp://127.0.0.1:8007")
  rv <- nn_recv(s, 0)
  cat("recieved: ", rv[["buf"]], "\n")
  payload <- as.raw(c(8,8))
  rv <- nn_send(s, payload, 0)
  cat("sent: ", payload, "\n")
}

rnanomsg_test_client <- function() {
  cat("client running...\n")
  s <- nn_socket(AF_SP, NN_REQ)
  ep <- nn_connect(s, "tcp://127.0.0.1:8007")
  payload <- as.raw(c(1, 2, 3))
  rv <- nn_send(s, payload, 0)
  cat("sent: ", payload, "\n")
  rv <- nn_recv(s, 0)
  cat("received: ", rv[["buf"]], "\n")
}
