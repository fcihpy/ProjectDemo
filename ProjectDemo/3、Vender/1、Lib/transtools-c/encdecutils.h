#ifndef __encdecutils_h__
#define __encdecutils_h__

#include "define.h"

#ifdef __cplusplus
extern "C" { 
#endif

/* 内存 */
void *encdecutils_malloc(int /* size */);
void encdecutils_free(void * /* buf */);

/*
base64编码
  obuf必须已经分配足够内存
  encode64可以分配len*2的内存
  decode64可以分配len的内存
返回结果字节数，<0函数错误
*/
int encdecutils_encode64(uint8_t * /* md */, int /* len */, uint8_t * /* obuf */);
int encdecutils_decode64(uint8_t * /* md */, int /* len */, uint8_t * /* obuf */);

/*
采用gzip和aes256编解码
  obuf由函数分配内存，使用后必须调用encdecutils_free释放
返回结果字节数，<0函数错误
*/
int encdecutils_encode(uint8_t * /* buf */, int /* len */, uint8_t * /* key */, int /* klen */, uint8_t ** /* obuf */);
int encdecutils_decode(uint8_t * /* buf */, int /* len */, uint8_t * /* key */, int /* klen */, uint8_t ** /* obuf */);

#ifdef __cplusplus
}
#endif

#endif /* __encdecutils_h__ */
