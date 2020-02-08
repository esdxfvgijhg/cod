
#include "LSC_Encrypt.h"
#include <Base64.h>
uint8_t LSC_Nonce[16] = {0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6, 0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C};
#define WMIC
#ifdef WMIC
#define MICv2
#define HEADER 4
#define MIC 4
#else
#define HEADER 0
#define MIC 0
#endif
uint8_t fcount;
void setup() {
  Serial.begin(38400);
  delay(2000);
  LSC_session_init();
  fcount = 0;
}
void loop() {
  int size_mesg = 0;
  uint8_t plain[256];
  uint8_t *cipher;
  uint8_t *check;
  uint32_t my_seed = 678;
  while (1) {
#ifdef LSC_ITERATE
    if (size_mesg < 240)
      size_mesg += 16;
    else
      size_mesg = 16;
    for (int i = 0; i < size_mesg; i++) {
      my_seed = xorshift32(my_seed);
      plain[i] = my_seed & 0xFF;
    }
#else
    char plain_txt[] = "HELLO WORLD!!!!!!!!!";
    size_mesg = sizeof(plain_txt) - 1;
    memcpy((uint8_t *)plain, (uint8_t *)plain_txt, size_mesg);
#endif
    Serial.print("message size: ");
    Serial.println(size_mesg);
    uint8_t lenH = LSC_get_block_size(size_mesg);
    Serial.print("buffer size: ");
    Serial.println(lenH);
    Serial.print("fcount: ");
    Serial.println(fcount);
    Serial.println("[PLAIN]:");
    for (int i = 0; i < size_mesg; i++) {
      Serial.print(plain[i]);
      Serial.print(" ");
    }
    Serial.println();
    cipher = (uint8_t *)calloc(lenH, sizeof(uint8_t));
    if (cipher == NULL) {
      Serial.println("cannot allocate memory for cipher buffer");
    } else {
      LSC_encrypt(plain, cipher + HEADER, size_mesg, fcount, LSC_ENCRYPT);
      Serial.print("Encryption took: ");
      Serial.println(LSC_encodeTimeMicros);
      Serial.println("[CIPHER]:");
      for (int i = 0; i < size_mesg; i++) {
        Serial.print(cipher[HEADER + i]);
        Serial.print(" ");
      }
      Serial.println();
#ifdef WMIC
      cipher[0] = 1;
      cipher[1] = 0x10 | 0x04 | 0x02;
      cipher[2] = 6;
      cipher[3] = fcount;
      LSC_setMIC(cipher, plain, size_mesg + HEADER, fcount + 1);
      Serial.println("[encrypted HEADER+CIPHER]:");
      for (int i = 0; i < size_mesg + HEADER; i++) {
        Serial.print(plain[i]);
        Serial.print(" ");
      }
      Serial.println();
      Serial.println("[MIC]:");
      for (int i = 0; i < 4; i++) {
        Serial.print(cipher[size_mesg + HEADER + i]);
        Serial.print(" ");
      }
      Serial.println();
      Serial.println("[ CIPHER | MIC[4] ]:");
      for (int i = 0; i < size_mesg + MIC; i++) {
        Serial.print(cipher[HEADER + i]);
        if (i == size_mesg - 1)
          Serial.print("|");
        else
          Serial.print(" ");
      }
      Serial.println();
      memcpy((uint8_t *)plain, (uint8_t *)plain_txt, size_mesg);
#endif
      check = (uint8_t *)calloc(lenH, sizeof(uint8_t));
      if (check == NULL) {
        Serial.println("cannot allocate memory for check buffer");
        free(cipher);
      } else {
        LSC_encrypt(cipher + HEADER, check, size_mesg, fcount, LSC_DECRYPT);
        Serial.print("Decryption took: ");
        Serial.println(LSC_encodeTimeMicros);
#ifndef LSC_ITERATE
        int b64_encodedLen = base64_enc_len(size_mesg + MIC) + 1;
        char b64_encoded[b64_encodedLen];
        base64_encode(b64_encoded, (char *)(cipher + HEADER), size_mesg + MIC);
#ifdef WMIC
        Serial.println("[base64 CIPHER+MIC]:");
#else
        Serial.println("[base64 CIPHER]:");
#endif
        Serial.println(b64_encoded);
#endif
        Serial.println("[CHECK]:");
        for (int i = 0; i < size_mesg; i++) {
          Serial.print(check[i]);
          Serial.print(" ");
        }
        Serial.println();
        bool equal = true;
        for (int i = 0; i < size_mesg; i++) {
          if (check[i] != plain[i])
            equal = false;
        }
        Serial.print("CHECK ");
        Serial.println(equal);
        free(cipher);
        free(check);
      }
    }
#ifdef LSC_ITERATE
    delay(200);
#else
    delay(30000);
#endif
    fcount++;
  }
}
