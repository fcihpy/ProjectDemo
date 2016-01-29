#ifndef __encdecutils_h__
#define __encdecutils_h__

#include "define.h"

#ifdef __cplusplus
extern "C" { 
#endif

/* �ڴ� */
void *encdecutils_malloc(int /* size */);
void encdecutils_free(void * /* buf */);

/*
base64����
  obuf�����Ѿ������㹻�ڴ�
  encode64���Է���len*2���ڴ�
  decode64���Է���len���ڴ�
���ؽ���ֽ�����<0��������
*/
int encdecutils_encode64(uint8_t * /* md */, int /* len */, uint8_t * /* obuf */);
int encdecutils_decode64(uint8_t * /* md */, int /* len */, uint8_t * /* obuf */);

/*
����gzip��aes256�����
  obuf�ɺ��������ڴ棬ʹ�ú�������encdecutils_free�ͷ�
���ؽ���ֽ�����<0��������
*/
int encdecutils_encode(uint8_t * /* buf */, int /* len */, uint8_t * /* key */, int /* klen */, uint8_t ** /* obuf */);
int encdecutils_decode(uint8_t * /* buf */, int /* len */, uint8_t * /* key */, int /* klen */, uint8_t ** /* obuf */);

#ifdef __cplusplus
}
#endif

#endif /* __encdecutils_h__ */
