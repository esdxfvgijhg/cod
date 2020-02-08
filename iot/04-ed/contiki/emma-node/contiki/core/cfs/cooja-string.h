#ifndef __COOJA_STRING_H_INCLUDED__
#define __COOJA_STRING_H_INCLUDED__

// -------------------------------------------------------------
// The following function implementations have been copied from
// 'http://clc-wiki.net/wiki/C_standard_library:string.h:strtok'
// -------------------------------------------------------------

#include "stddef.h"



void *cooja_memchr(const void *s, int c, size_t n);
int cooja_memcmp(const void* s1, const void* s2,size_t n);
void *cooja_memcpy(void *dest, const void *src, size_t n);
//void *cooja_memmove(void *dest, const void *src, size_t n);
void *cooja_memset(void *s, int c, size_t n);
char *cooja_strcat(char *dest, const char *src);
char *cooja_strchr(const char *s, int c);
int cooja_strcmp(const char* s1, const char* s2);
size_t cooja_strlen(const char *s);
char *cooja_strcpy(char *dest, const char* src);
size_t cooja_strxfrm(char *dest, const char *src, size_t n);
int cooja_strcoll(const char *s1, const char *s2);
size_t cooja_strcspn(const char *s1, const char *s2);
char *cooja_strncat(char *dest, const char *src, size_t n);
int cooja_strncmp(const char* s1, const char* s2, size_t n);
char *cooja_strncpy(char *dest, const char *src, size_t n);
char *cooja_strpbrk(const char *s1, const char *s2);
char *cooja_strrchr(const char *s, int c);
size_t cooja_strspn(const char *s1, const char *s2);
char *cooja_strstr(const char *s1, const char *s2);
char *cooja_strtok(char * str, const char * delim);



#define MEMCHR(s,t,u) 		cooja_memchr((s),(t),(u))
#define MEMCMP(s,t,u) 		cooja_memcmp((s),(t),(u))
#define MEMCPY(s,t,u) 		cooja_memcpy((s),(t),(u))
//#define MEMMOVE(s,t,u) 		cooja_memmove((s),(t),(u))
#define MEMSET(s,t,u) 		cooja_memset((s),(t),(u))
#define STRCAT(s,t) 			cooja_strcat((s),(t))
#define STRCHR(s,t) 			cooja_strchr((s),(t))
#define STRCMP(s,t) 			cooja_strcmp((s),(t))
#define STRLEN(s) 				cooja_strlen((s))
#define STRCPY(s,t) 			cooja_strcpy((s),(t))
#define STRXFRM(s,t,u) 		cooja_strxfrm((s),(t),(u))
#define STRCOLL(s,t) 			cooja_strcoll((s),(t))
#define STRCSPN(s,t) 			cooja_strcspn((s),(t))
#define STRNCAT(s,t,u) 		cooja_strncat((s),(t),(u))
#define STRNCMP(s,t,u) 		cooja_strncmp((s),(t),(u))
#define STRNCPY(s,t,u) 		cooja_strncpy((s),(t),(u))
#define STRPBRK(s,t) 			cooja_strpbrk((s),(t))
#define STRRCHR(s,t) 			cooja_strrchr((s),(t))
#define STRSPN(s,t) 			cooja_strspn((s),(t))
#define STRSTR(s,t) 			cooja_strstr((s),(t))
#define STRTOK(s,t) 			cooja_strtok((s),(t))

#define memchr(s,t,u) 		cooja_memchr((s),(t),(u))
#define memcmp(s,t,u) 		cooja_memcmp((s),(t),(u))
#define memcpy(s,t,u) 		cooja_memcpy((s),(t),(u))
//#define memmove(s,t,u) 		cooja_memmove((s),(t),(u))
#define memset(s,t,u) 		cooja_memset((s),(t),(u))
#define strcat(s,t) 			cooja_strcat((s),(t))
#define strchr(s,t) 			cooja_strchr((s),(t))
#define strcmp(s,t) 			cooja_strcmp((s),(t))
#define strlen(s) 				cooja_strlen((s))
#define strcpy(s,t) 			cooja_strcpy((s),(t))
#define strxfrm(s,t,u) 		cooja_strxfrm((s),(t),(u))
#define strcoll(s,t) 			cooja_strcoll((s),(t))
#define strcspn(s,t) 			cooja_strcspn((s),(t))
#define strncat(s,t,u) 		cooja_strncat((s),(t),(u))
#define strncmp(s,t,u) 		cooja_strncmp((s),(t),(u))
#define strncpy(s,t,u) 		cooja_strncpy((s),(t),(u))
#define strpbrk(s,t) 			cooja_strpbrk((s),(t))
#define strrchr(s,t) 			cooja_strrchr((s),(t))
#define strspn(s,t) 			cooja_strspn((s),(t))
#define strstr(s,t) 			cooja_strstr((s),(t))
#define strtok(s,t) 			cooja_strtok((s),(t))


#endif // __COOJA_STRING_H_INCLUDED__
