#include "encdecutils.h"
#include "aes256.h"
#include "gzip.h"
#include <stdlib.h>
/* -------------------------------------------------------------------------- */
void *encdecutils_malloc(int size)
{
    return malloc(size);
} /* encdecutils_malloc */

/* -------------------------------------------------------------------------- */
void encdecutils_free(void *buf)
{
    free(buf);
} /* encdecutils_free */

static int toBytes(int n, uint8_t *b) {
	b[0] = (uint8_t) (n >> 3 * 8);
	b[1] = (uint8_t) (n >> 2 * 8);
	b[2] = (uint8_t) (n >> 1 * 8);
	b[3] = (uint8_t) n;
	return 4;
}

static int fromBytes(uint8_t *b) {
	return (((uint_t)b[0] << 3 * 8) & 0xff000000) | (((uint_t)b[1] << 2 * 8) & 0xff0000) | (((uint_t)b[2] << 8) & 0xff00) | (uint_t)b[3];
}

static uint8_t* encchar = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-";
static uint8_t decchar[] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 63, -1, -1, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
		10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, 62, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
		46, 47, 48, 49, 50, 51, -1, -1, -1, -1 };

static int encrest[] = { 0, 2, 3 };

int encdecutils_encode64(uint8_t *md, int len, uint8_t *obuf) {
	int r, n, i, j, olen;
	uint8_t *s;

	r = len % 3;
	n = len - r;
	olen = (n / 3) * 4 + encrest[r];
	s = obuf;
	i = 0, j = 0;
	if (n >= 3) {
		for (i = 0, j = 0; i < n; i += 3, j += 4) {
			// r=0, xxxxyyyy xxxxyyyy xxxxyyyy => xxxxyy yyxxxx yyyyxx
			// xxyyyy
			s[j] = encchar[(md[i] & 0xfc) >> 2]; // xxxxyy
			s[j + 1] = encchar[((md[i] & 0x03) << 4) + ((md[i + 1] & 0xf0) >> 4)]; // yyxxxx
			s[j + 2] = encchar[((md[i + 1] & 0x0f) << 2) + ((md[i + 2] & 0xc0) >> 6)]; // yyyyxx
			s[j + 3] = encchar[(md[i + 2] & 0x3f)]; // xxyyyy
		}
	}
	if (r == 1) {
		// r=1, xxxxyyyy => xxxxyy xxyyyy
		s[j] = encchar[(md[i] & 0xfc) >> 2]; // xxxxyy
		s[j + 1] = encchar[(md[i] & 0x3f)]; // xxyyyy
	} else if (r == 2) {
		// r=2, xxxxyyyy xxxxyyyy => xxxxyy yyxxxx xxyyyy
		s[j] = encchar[(md[i] & 0xfc) >> 2]; // xxxxyy
		s[j + 1] = encchar[((md[i] & 0x03) << 4) + ((md[i + 1] & 0xf0) >> 4)]; // yyxxxx
		s[j + 2] = encchar[(md[i + 1] & 0x3f)]; // xxyyyy
	}
	return olen;
}

static int decrest[] = { 0, 0, 1, 2 };

int encdecutils_decode64(uint8_t *md, int len, uint8_t *obuf) {
	int r, n, olen, i, j;
	uint8_t *s;

	r = len % 4;
	if (r == 1)
		return -1;
	n = len - r;
	olen = (n / 4) * 3 + decrest[r];
	s = obuf;
	i = 0, j = 0;
	if (n >= 4) {
		for (i = 0, j = 0; i < n; i += 4, j += 3) {
			// r=0, xxxxyy yyxxxx yyyyxx xxyyyy => xxxxyyyy xxxxyyyy
			// xxxxyyyy
			if (md[i] < 0 || md[i + 1] < 0 || md[i + 2] < 0 || md[i + 3] < 0 || decchar[md[i]] == -1 || decchar[md[i + 1]] == -1 || decchar[md[i + 2]] == -1
					|| decchar[md[i + 3]] == -1)
				return -1;
			s[j] = (uint8_t) ((decchar[md[i]] << 2) + ((decchar[md[i + 1]] & 0x30) >> 4));
			s[j + 1] = (uint8_t) (((decchar[md[i + 1]] & 0x0f) << 4) + ((decchar[md[i + 2]] & 0x3c) >> 2));
			s[j + 2] = (uint8_t) (((decchar[md[i + 2]] & 0x03) << 6) + (decchar[md[i + 3]]));
		}
	}
	if (r == 2) {
		// r=2, xxxxyy xxyyyy => xxxxyyyy
		if (md[i] < 0 || md[i + 1] < 0 || decchar[md[i]] == -1 || decchar[md[i + 1]] == -1)
			return -1;
		s[j] = (uint8_t) ((decchar[md[i]] << 2) + (decchar[md[i + 1]] & 0x03));
	} else if (r == 3) {
		// r=3, xxxxyy yyxxxx xxyyyy => xxxxyyyy xxxxyyyy
		if (md[i] < 0 || md[i + 1] < 0 || md[i + 2] < 0 || decchar[md[i]] == -1 || decchar[md[i + 1]] == -1 || decchar[md[i + 2]] == -1)
			return -1;
		s[j] = (uint8_t) ((decchar[md[i]] << 2) + ((decchar[md[i + 1]] & 0x30) >> 4));
		s[j + 1] = (uint8_t) (((decchar[md[i + 1]] & 0x0f) << 4) + (decchar[md[i + 2]] & 0x0f));
	}
	return olen;
}

static int hashCode(uint8_t *buf, int len) {
	int h, i;
	
	h = 0;
	if (len > 0) {
		for (i = 0; i < len; i++) {
			h = 31 * h + (char)buf[i];
		}
	}
	return h;
}


/* -------------------------------------------------------------------------- */
int encdecutils_encode(uint8_t *buf, int len, uint8_t *key, int klen, uint8_t **obuf) {
	// key+1|0+compress(buf)
	uint8_t *cbuf, *ebuf, *_ebuf;
	int clen, i, _klen, _elen, blen;
	uint8_t _key[32];
	aes256_context ctx;

	_klen = encdecutils_decode64(key, klen, _key);
	if (_klen!=32)
		return -1;
	
	ebuf = (uint8_t *)encdecutils_malloc(len*2+256);
	i = toBytes(hashCode(key, klen), ebuf);
	if (buf) { // has param
		clen = gzip_compress(buf, len, &cbuf);
		if (clen>0 && clen < len) {
			ebuf[i++] = 1;
			memcpy(ebuf+i, cbuf, clen);
			i += clen;
		} else {
			ebuf[i++] = 0;
			memcpy(ebuf+i, buf, len);
			i += len;
		}
		encdecutils_free(cbuf);
	} else { // null
		ebuf[i++] = 2;
	}
	aes256_init(&ctx, _key);
	_elen = aes256_encrypt(&ctx, ebuf, i, &_ebuf);
	aes256_done(&ctx);

	blen = encdecutils_encode64(_ebuf, _elen, ebuf);
	encdecutils_free(_ebuf);
	*obuf = ebuf;
	return blen;
} /* encdecutils_encode */

/* -------------------------------------------------------------------------- */
int encdecutils_decode(uint8_t *buf, int len, uint8_t *key, int klen, uint8_t **obuf) {
	// key+1|0+compress(buf)
	uint8_t *ebuf;
	int elen, _klen, clen;
	uint8_t _key[32];
	aes256_context ctx;
	
	_klen = encdecutils_decode64(key, klen, _key);
	if (_klen!=32)
		return -1;

	ebuf = (uint8_t *)encdecutils_malloc(len*2+256);
	elen = encdecutils_decode64(buf, len, ebuf);

	aes256_init(&ctx, _key);
	clen = aes256_decrypt(&ctx, ebuf, elen);
	aes256_done(&ctx);

	if (fromBytes(ebuf) != hashCode(key, klen)) {
		encdecutils_free(ebuf);
		return -2;
	}
	if (ebuf[4] == 2) { // null
		encdecutils_free(ebuf);
		return 0;
	}
	if (ebuf[4] == 0) { // no compress
		memmove(ebuf, ebuf+5, clen-5);
		*obuf = ebuf;
		return clen-5;
	}
	if (ebuf[4] == 1) { // compress
		elen = gzip_uncompress(ebuf+5, clen-5, obuf);
		encdecutils_free(ebuf);
		return elen;
	}
	encdecutils_free(ebuf);
	return -3;
} /* encdecutils_decode */


