/*
 Copyright (c) 2014 Matthew Howlett

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal 
 in the Software without restriction, including without limitation the rights 
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

#include <nanomsg/nn.h>
#include <nanomsg/reqrep.h>

#include <R.h>
#include <Rdefines.h>
#include <stdio.h>


SEXP rnn_socket(SEXP domain, SEXP protocol)
{
  SEXP result;
  int *p_result;
  const int len = 1;

  PROTECT(result = NEW_INTEGER(len));
  p_result = INTEGER_POINTER(result);

  int d = (INTEGER_POINTER(domain))[0];
  int p = (INTEGER_POINTER(protocol))[0];

  p_result[0] = nn_socket(d, p);

  UNPROTECT(1);
  return result;
}

SEXP rnn_close(SEXP s)
{
  SEXP result;
  int *p_result;
  const int len = 1;

  PROTECT(result = NEW_INTEGER(len));
  p_result = INTEGER_POINTER(result);

  int s_ = (INTEGER_POINTER(s))[0];

  p_result[0] = nn_close(s_);

  UNPROTECT(1);
  return result;
}

SEXP rnn_shutdown(SEXP s, SEXP how)
{
  SEXP result;
  int *p_result;
  const int len = 1;

  PROTECT(result = NEW_INTEGER(len));
  p_result = INTEGER_POINTER(result);

  int s_ = (INTEGER_POINTER(s))[0];
  int how_ = (INTEGER_POINTER(how))[0];

  p_result[0] = nn_shutdown(s_, how_);

  UNPROTECT(1);
  return result;
}

SEXP rnn_connect(SEXP s, SEXP addr)
{
  SEXP result;
  int *p_result;
  const int len = 1;

  PROTECT(result = NEW_INTEGER(len));
  p_result = INTEGER_POINTER(result);

  int s_ = (INTEGER_POINTER(s))[0];
  const char *addr_ = CHAR(STRING_ELT(addr, 0));

  p_result[0] = nn_connect(s_, addr_);
 
  UNPROTECT(1);
  return result;
}

SEXP rnn_bind(SEXP s, SEXP addr)
{
  SEXP result;
  int *p_result;
  const int len = 1;

  PROTECT(result = NEW_INTEGER(len));
  p_result = INTEGER_POINTER(result);

  int s_ = (INTEGER_POINTER(s))[0];
  const char *addr_ = CHAR(STRING_ELT(addr, 0));

  p_result[0] = nn_bind(s_, addr_);
 
  UNPROTECT(1);
  return result;
}

