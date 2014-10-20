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
AF_SP <- 1L
AF_SP_RAW <- 2L

# PAIR
NN_PROTO_PAIR <- 1L
NN_PAIR <- NN_PROTO_PAIR * 16L + 0L

# PUBSUB
NN_PROTO_PUBSUB <- 2L
NN_PUB <- NN_PROTO_PUBSUB * 16L + 0L
NN_SUB <- NN_PROTO_PUBSUB * 16L + 1L
NN_SUB_SUBSCRIBE <- 1L
NN_SUB_UNSUBSCRIBE <- 2L

# REQREP
NN_PROTO_REQREP <- 3L
NN_REQ <- NN_PROTO_REQREP * 16L + 0L
NN_REP <- NN_PROTO_REQREP * 16L + 1L

# PIPELINE
NN_PROTO_PIPELINE <- 5L
NN_PUSH <- NN_PROTO_PIPELINE * 16L + 0L
NN_PULL <- NN_PROTO_PIPELINE * 16L + 1L

# SURVEY
NN_PROTO_SURVEY <- 6L
NN_SURVEYOR <- NN_PROTO_SURVEY * 16L + 0L
NN_RESPONDENT <- NN_PROTO_SURVEY * 16L + 1L
NN_SURVEYOR_DEADLINE <- 1L

# BUS
NN_PROTO_BUS <- 7L
NN_BUS <- NN_PROTO_BUS * 16L + 0L

# Generic socket options

NN_SOL_SOCKET <- 0L

NN_LINGER <- 1L
NN_SNDBUF <- 2L
NN_RCVBUF <- 3L
NN_SNDTIMEO <- 4L
NN_RCVTIMEO <- 5L
NN_RECONNECT_IVL <- 6L
NN_RECONNECT_IVL_MAX <- 7L
NN_SNDPRIO <- 8L
NN_RCVPRIO <- 9L
NN_SNDFD <- 10L
NN_RCVFD <- 11L
NN_DOMAIN <- 12L
NN_PROTOCOL <- 13L
NN_IPV4ONLY <- 14L
NN_SOCKET_NAME <- 15L

# send/recv options

NN_DONTWAIT <- 1L

# poll related

NN_POLLIN <- 1L
NN_POLLOUT <- 2L


nn_socket <- function(domain, protocol) {
  if (!is.integer(domain)) {
    stop("domain parameter must have type integer")
  }
  if (!is.integer(protocol))
  {
    stop("protocol parameter must have type integer")
  }

  .Call("rnn_socket", domain, protocol)
}

nn_close <- function(s) {
  if (!is.integer(s)) {
    stop("s parameter must have type integer")
  }

  .Call("rnn_close", s)
}

nn_shutdown <- function(s, how) {
  if (!is.integer(s)) {
    stop("s parameter must have type integer")
  }
  if (!is.integer(how)) {
    stop("how parameter must have type integer")
  }

  .Call("rnn_shutdown", s, how)
}

nn_connect <- function(s, addr) {
  if (!is.integer(s)) {
    stop("s parameter must have type integer")
  }
  if (!is.character(addr)) {
    stop("addr parameter must have type character")
  }

  .Call("rnn_connect", s, addr)
}

nn_bind <- function(s, addr) {
  if (!is.integer(s)) {
    stop("s parameter must have type integer")
  }
  if (!is.character(addr)) {
    stop("addr parameter must have type character")
  }

  .Call("rnn_bind", s, addr)
}

nn_send <- function(s, buf, flags) {
  if (!is.integer(s)) {
    stop("s parameter must have type integer")
  }
  if (!is.integer(flags)) {
    stop("flags parameter must have type integer")
  }

  .Call("rnn_send", s, as.raw(buf), flags)
}

nn_recv <- function(s, flags) {
  if (!is.integer(s)) {
    stop("s parameter must have type integer")
  }
  if (!is.integer(flags)) {
    stop("flags parameter must have type integer")
  }

  result <- .Call("rnn_recv", s, flags)
  list(rv = result[[1]], buf = result[[2]])
}

nn_device <- function(s1, s2) {
  if (!is.integer(s1)) {
    stop("s1 parameter must have type integer")
  }
  if (!is.integer(s2)) {
    stop("s2 parameter must have type integer")
  }

  .Call("rnn_device", s1, s2)
}

nn_term <- function() {
  .Call("rnn_term")
}

nn_errno <- function() {
  .Call("rnn_errno")
}

nn_strerror <- function(errnum) {
  if (!is.integer(errnum)) {
    stop("errnum parameter must have type integer")
  }

  .Call("rnn_strerror", errnum)
}

nn_getsockopt <- function(s, level, option, type, optvallen = 256L) {
  if (!is.integer(s)) {
    stop("s parameter must have type integer")
  }
  if (!is.integer(option)) {
    stop("option parameter must have type integer")
  }
  if (!is.integer(level)){
    stop("level parameter must have type integer")
  }
  if (!is.integer(optvallen)){
    stop("optvallen parameter must have type integer")
  }

  if (is.integer(type)) {
    .Call("rnn_getsockopt_int", s, level, option)
  } else if (is.character(type)) {
    .Call("rnn_getsockopt_char", s, level, option, optvallen)
  } else {
    stop("unsupported option type")
  }
}

nn_setsockopt <- function(s, level, option, optval) {
  if (!is.integer(s)) {
    stop("s parameter must have type integer")
  }
  if (!is.integer(option)) {
    stop("option parameter must have type integer")
  }
  if (!is.integer(level)){
    stop("level parameter must have type integer")
  }

  if (is.character(optval)) {
    .Call("rnn_setsockopt_char", s, level, option, optval)
  }
  else if (is.integer(optval)) {
    .Call("rnn_setsockopt_int", s, level, option, optval)
  }
  else if (is.double(optval) && round(optval) == optval) {
    # because an numeric literal is a double not an integer.
    .Call("rnn_setsockopt_int", s, level, option, as.integer(optval))
  }
  else {
    stop("optval type provided is not supported")
  }
}


# examples

rnanomsg_test_server <- function() {
  cat("server running...\n")
  s <- nn_socket(AF_SP, NN_REP)
  ep <- nn_bind(s, "tcp://127.0.0.1:8007")
  rv <- nn_recv(s, 0)
  cat("recieved: ", rv[["buf"]], "\n")
  payload <- as.raw(c(8, 8))
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
