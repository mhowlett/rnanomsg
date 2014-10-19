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
  const int result_len = 1;

  PROTECT(result = NEW_INTEGER(result_len));
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
  const int result_len = 1;

  PROTECT(result = NEW_INTEGER(result_len));
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
  const int result_len = 1;

  PROTECT(result = NEW_INTEGER(result_len));
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
  const int result_len = 1;

  PROTECT(result = NEW_INTEGER(result_len));
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
  const int result_len = 1;

  PROTECT(result = NEW_INTEGER(result_len));
  p_result = INTEGER_POINTER(result);

  int s_ = (INTEGER_POINTER(s))[0];
  const char *addr_ = CHAR(STRING_ELT(addr, 0));

  p_result[0] = nn_bind(s_, addr_);
 
  UNPROTECT(1);
  return result;
}

SEXP rnn_send(SEXP s, SEXP buf, SEXP flags)
{
  SEXP result;
  int *p_result;
  const int result_len = 1;

  PROTECT(result = NEW_INTEGER(result_len));
  p_result = INTEGER_POINTER(result);

  void *p_buf = RAW_POINTER(buf);
  int s_ = (INTEGER_POINTER(s))[0];
  int flags_ = (INTEGER_POINTER(flags))[0];
  int buf_len = LENGTH(buf);

  p_result[0] = nn_send(s_, p_buf, buf_len, flags_);
 
  UNPROTECT(1);
  return result;
}

SEXP rnn_recv(SEXP s, SEXP flags)
{
  int protect_count = 0;
 
  int s_ = (INTEGER_POINTER(s))[0];
  int flags_ = (INTEGER_POINTER(flags))[0];

  void *nnbuf = NULL;
  int rv = nn_recv(s_, &nnbuf, NN_MSG, flags_);

  SEXP ret;
  const int ret_len = 1;
  PROTECT(ret = NEW_INTEGER(ret_len));
  int *p_ret = INTEGER_POINTER(ret);
  p_ret[0] = rv;
  protect_count += 1;

  SEXP a;
  if (rv == -1) {
    a = list2(ret, R_NilValue);
  }
  else
  {
    SEXP buf;
    unsigned char *p_buf;
    int buf_len = rv;
    PROTECT(buf = NEW_RAW(buf_len));
    p_buf = RAW_POINTER(buf);
    protect_count +=1;

    memcpy(p_buf, nnbuf, buf_len);

    int rv2 = nn_freemsg(nnbuf);
    if (rv2 == -1)
    {
      // may not be catastrophic, but let's assume it is.
      p_ret[0] = rv2;
      a = list2(ret, R_NilValue);
    }
    else
    {
      a = list2(ret, buf);
    }
  }

  UNPROTECT(protect_count);
  return a;
}

SEXP rnn_device(SEXP s1, SEXP s2)
{
  SEXP result;
  int *p_result;
  const int result_len = 1;

  PROTECT(result = NEW_INTEGER(result_len));
  p_result = INTEGER_POINTER(result);

  int s1_ = (INTEGER_POINTER(s1))[0];
  int s2_ = (INTEGER_POINTER(s2))[0];

  p_result[0] = nn_device(s1_, s2_);

  UNPROTECT(1);
  return result;
}

SEXP rnn_term()
{
  nn_term();
  return R_NilValue;
}

SEXP rnn_errno()
{
  SEXP result;
  int *p_result;
  const int result_len = 1;

  PROTECT(result = NEW_INTEGER(result_len));
  p_result = INTEGER_POINTER(result);

  p_result[0] = nn_errno();

  UNPROTECT(1);
  return result;
}

SEXP rnn_strerror(SEXP errnum)
{
  SEXP result;
  const int result_len = 1;
  PROTECT(result = NEW_CHARACTER(result_len));

  int errnum_ = (INTEGER_POINTER(errnum))[0];

  const char* error_string = nn_strerror(errnum_);
  SET_STRING_ELT(result, 0, mkChar(error_string));

  UNPROTECT(1);
  return result;
}
