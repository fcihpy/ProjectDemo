#include "gzip.h"
#include "encdecutils.h"
#include <stdlib.h>
int gzip_compress(uint8_t *buf, int len, uint8_t **obuf)
{
	z_stream stream;
	uint8_t *_obuf;
	int code, rinLen, routLen, outLen, i;
	
	memset(&stream, 0, sizeof(stream));
	if (deflateInit2(&stream,Z_DEFAULT_COMPRESSION,Z_DEFLATED,15+16,8,Z_DEFAULT_STRATEGY) != Z_OK)
		return -1;
	routLen = -1;
	outLen = ((len*2)/256)*256+256;
	for (i=0; i<3; i++) {
		_obuf = (uint8_t *)encdecutils_malloc(outLen);
		stream.next_in = buf;
		stream.avail_in = len;
		stream.next_out = _obuf;
		stream.avail_out = outLen;
		code = deflate(&stream, Z_FINISH);
		if (code == Z_OK) {
			routLen = outLen - stream.avail_out;
		} else if (code == Z_BUF_ERROR) {
			outLen *= 2;
			free(_obuf);
			continue;
		} else if (code == Z_STREAM_END) {
			routLen = outLen - stream.avail_out;
		} else {
			routLen = -1;
		}
		break;
	}
	deflateEnd(&stream);
	if (routLen<0) {
		encdecutils_free(_obuf);
		return routLen;
	}
	*obuf = _obuf;
	return routLen;
}/* gzip_compress */

#define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
#define HEAD_CRC     0x02 /* bit 1 set: header CRC present */
#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
#define COMMENT      0x10 /* bit 4 set: file comment present */
#define RESERVED     0xE0 /* bits 5..7: reserved */

enum  { GZIP_INIT = 0, GZIP_OS, GZIP_EXTRA0, GZIP_EXTRA1, GZIP_EXTRA2, GZIP_ORIG, GZIP_COMMENT, GZIP_CRC };

static int checkHeader( uint8_t *buf, int len )
{	
	Bytef *p, *pe, c;
	int skips, flags, mode, nlens;

	p = buf;
	pe = p+len;
	mode = GZIP_INIT;
	skips = 0;
	nlens = 0;
	while( p<pe ) {
		switch( mode ) {
			case GZIP_INIT:
				c = *p++;
				/* gzip magic header */
				if (skips == 0 && ((unsigned)c & 0xFF) != 0x1f)
					return -1;
				if (skips == 1 && ((unsigned)c & 0xFF) != 0x8b)
					return -1;
				if (skips == 2 && ((unsigned)c & 0xFF) != Z_DEFLATED)
					return -1;
				skips++;
				if (skips == 4) {
					flags = (unsigned) c & 0xFF;
					if (flags & RESERVED)
						return -1;
					mode = GZIP_OS;
					skips = 0;
				}
				break;
			case GZIP_OS:
				c = *p++;
				skips++;
				if (skips == 6)
					mode = GZIP_EXTRA0;
				break;
			case GZIP_EXTRA0:
				if (flags & EXTRA_FIELD) {
					c = *p++;
					nlens = (uint_t)c & 0xFF;
					mode = GZIP_EXTRA1;
				} else
					mode = GZIP_ORIG;
				break;
			case GZIP_EXTRA1:
				c = *p++;
				nlens |= ((uint_t)c & 0xFF) << 8;
				skips = 0;
				mode = GZIP_EXTRA2;
				break;
			case GZIP_EXTRA2:
				if (skips == nlens)
					mode = GZIP_ORIG;
				else {
					c = *p++;
					skips++;
				}
				break;
			case GZIP_ORIG:
				if (flags & ORIG_NAME) {
					c = *p++;
					if (c == 0)
						mode = GZIP_COMMENT;
				} else
					mode = GZIP_COMMENT;
				break;
			case GZIP_COMMENT:
				if (flags & COMMENT) {
					c = *p++;
					if (c == 0) {
						mode = GZIP_CRC;
						skips = 0;
					}
				} else {
					mode = GZIP_CRC;
					skips = 0;
				}
				break;
			case GZIP_CRC:
				if (flags & HEAD_CRC) {
					c = *p++;
					skips++;
					if (skips == 2) {
						return p-buf;
					}
				} else {
					return p-buf;
				}
			break;
		}
	}
	return p-buf;
}

int gzip_uncompress(uint8_t *buf, int len, uint8_t **obuf)
{
	z_stream stream;
	uint8_t *_obuf;
	int code, rinLen, routLen, outLen, i;

	int off = checkHeader(buf, len);
	if (off<0)
		return -1;
	if (off==len)
		return 0;
	
	
	memset(&stream, 0, sizeof(stream));
	if (inflateInit2(&stream, -MAX_WBITS) != Z_OK)
		return -1;
	routLen = -1;
	outLen = ((len*10)/256)*256+256;
	for (i=0; i<10; i++) {
		_obuf = (uint8_t *)encdecutils_malloc(outLen);
		stream.next_in = buf+off;
		stream.avail_in = len-off;
		stream.next_out = _obuf;
		stream.avail_out = outLen;
		code = inflate(&stream, Z_FINISH);
		if (code == Z_OK) {
			routLen = outLen - stream.avail_out;
		} else if (code == Z_BUF_ERROR) {
			outLen *= 2;
			free(_obuf);
			continue;
		} else if (code == Z_STREAM_END) {
			routLen = outLen - stream.avail_out;
		} else {
			routLen = -1;
		}
		break;
	}
	inflateEnd(&stream);
	if (routLen<0) {
		encdecutils_free(_obuf);
		return routLen;
	}
	*obuf = _obuf;
	return routLen;
}/* gzip_uncompress */


