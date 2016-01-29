#ifndef __gzip_h__
#define __gzip_h__
	
#include <zlib.h>
#include "define.h"

#ifdef __cplusplus
extern "C" { 
#endif

int gzip_compress(uint8_t * /* buf */, int /* len */, uint8_t ** /* obuf */);
int gzip_uncompress(uint8_t * /* buf */, int /* len */, uint8_t ** /* obuf */);

#ifdef __cplusplus
}
#endif

#endif /* __gzip_h__ */
