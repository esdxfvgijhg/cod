#include "cooja-string.h"

void *cooja_memchr(const void *s, int c, size_t n)
{
    unsigned char *p = (unsigned char*)s;
    while(n--)
        if(*p != (unsigned char)c)
            p++;
        else
            return p;
    return 0;
}

int cooja_memcmp(const void* s1, const void* s2,size_t n)
{
    const unsigned char *p1 = s1, *p2 = s2;
    while(n--)
        if( *p1 != *p2 )
            return *p1 - *p2;
        else
            *p1++,*p2++;
    return 0;
}

void *cooja_memcpy(void *dest, const void *src, size_t n)
{
    char *dp = dest;
    const char *sp = src;
    while (n--)
        *dp++ = *sp++;
    return dest;
}

/*void *cooja_memmove(void *dest, const void *src, size_t n)
{
    unsigned char *pd = dest;
    const unsigned char *ps = src;
    if (__np_anyptrlt(ps, pd))
        for (pd += n, ps += n; n--;)
            *--pd = *--ps;
    else
        while(n--)
            *pd++ = *ps++;
    return dest;
}*/

void *cooja_memset(void *s, int c, size_t n)
{
    unsigned char* p=s;
    while(n--)
        *p++ = (unsigned char)c;
    return s;
}

char *cooja_strcat(char *dest, const char *src)
{
    char *ret = dest;
    while (*dest)
        dest++;
    while ((*dest++ = *src++))
        ;
    return ret;
}

char *cooja_strchr(const char *s, int c)
{
    while (*s != (char)c)
        if (!*s++)
            return 0;
    return (char *)s;
}

int cooja_strcmp(const char* s1, const char* s2)
{
    while(*s1 && (*s1==*s2))
    {
      s1++;
      s2++;
    }
    return *(const unsigned char*)s1-*(const unsigned char*)s2;
}

size_t cooja_strlen(const char *s) {
    const char *p = s;
    while (*s) ++s;
    return s - p;
}

char *cooja_strcpy(char *dest, const char* src)
{
    char *ret = dest;
    while ((*dest++ = *src++));
    return ret;
}

size_t cooja_strxfrm(char *dest, const char *src, size_t n)
{
    /* This implementation does not know about any locale but "C"... */
    size_t n2=cooja_strlen(src);
    if(n>n2)
        cooja_strcpy(dest,src);
    return n2;
}

int cooja_strcoll(const char *s1, const char *s2)
{
    char t1[1 + cooja_strxfrm(0, s1, 0)];
    cooja_strxfrm(t1, s1, sizeof(t1));
    char t2[1 + cooja_strxfrm(0, s2, 0)];
    cooja_strxfrm(t2, s2, sizeof(t2));
    return cooja_strcmp(t1, t2);
}

size_t cooja_strcspn(const char *s1, const char *s2)
{
    size_t ret=0;
    while(*s1)
        if(cooja_strchr(s2,*s1))
            return ret;
        else
            s1++,ret++;
    return ret;
}

char *cooja_strncat(char *dest, const char *src, size_t n)
{
    char *ret = dest;
    while (*dest)
        dest++;
    while (n--)
        if (!(*dest++ = *src++))
            return ret;
    *dest = 0;
    return ret;
}

int cooja_strncmp(const char* s1, const char* s2, size_t n)
{
    while(n--)
        if(*s1++!=*s2++)
            return *(unsigned char*)(s1 - 1) - *(unsigned char*)(s2 - 1);
    return 0;
}

char *cooja_strncpy(char *dest, const char *src, size_t n)
{
    char *ret = dest;
    do {
        if (!n--)
            return ret;
    } while ((*dest++ = *src++));
    while (n--)
        *dest++ = 0;
    return ret;
}

char *cooja_strpbrk(const char *s1, const char *s2)
{
    while(*s1)
        if(cooja_strchr(s2, *s1++))
            return (char*)--s1;
    return 0;
}

char *cooja_strrchr(const char *s, int c)
{
    char* ret=0;
    do {
        if( *s == (char)c )
            ret=s;
    } while(*s++);
    return ret;
}

size_t cooja_strspn(const char *s1, const char *s2)
{
    size_t ret=0;
    while(*s1 && cooja_strchr(s2,*s1++))
        ret++;
    return ret;    
}

char *cooja_strstr(const char *s1, const char *s2)
{
    size_t n = cooja_strlen(s2);
    while(*s1)
        if(!cooja_memcmp(s1++,s2,n))
            return s1-1;
    return 0;
}

char *cooja_strtok(char * str, const char * delim)
{
    static char* p=0;
    if(str)
        p=str;
    else if(!p)
        return 0;
    str=p+cooja_strspn(p,delim);
    p=str+cooja_strcspn(str,delim);
    if(p==str)
        return p=0;
    p = *p ? *p=0,p+1 : 0;
    return str;
}
