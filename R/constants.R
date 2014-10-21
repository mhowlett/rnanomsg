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

