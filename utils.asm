; int   my_strcmp(char *, char *)
; (edi, esi) -> eax
; Compares 2 strings strcmp-style.
my_strcmp PROC NEAR

    push    edi
    push    esi
    push    ebx                         ; Saving registers that we will use

loop_beg:
    cmp     byte ptr [edi], 0
    jz      loop_end                    ; if (str1[i] == '\0') then exit loop
    mov     bl, byte ptr [edi]
    cmp     byte ptr [esi], bl
    jnz     loop_end                    ; if (str1[i] != str2[i]) then exit loop
    inc     edi
    inc     esi
    jmp     loop_beg

loop_end:
    movzx   eax, byte ptr [edi]
    movzx   ebx, byte ptr [esi]
    sub     eax, ebx

    pop     ebx
    pop     esi
    pop     edi                         ; restore borrowed registers

    ret
my_strcmp ENDP


; void* memcpy(void *dest, void *src, size_t n)
; (edi, esi, edx) -> eax	
my_memcpy PROC NEAR

    push    edi
    push    esi
    push    ebx                         ; Saving registers that we will use

    test    edi, edi                    ; Test if dest is NULL	
    je      lbl_result
    test    esi, esi                    ; Test if src is NULL	
    je      lbl_result
    test    edx, edx                    ; Test if n is zero	
    je      lbl_result
    xor     ecx, ecx
    xor     ebx, ebx

lbl_loop:
    mov     bl, BYTE ptr [esi + ecx]
    mov     BYTE ptr [edi + ecx], bl
    inc     ecx
    cmp     ecx, edx
    jb      lbl_loop

lbl_result:
    mov     eax, edi

    pop     ebx
    pop     esi
    pop     edi                         ; restore borrowed registers

    ret
my_memcpy ENDP


; void *memset(void *s, int c, size_t n)
; (edi, esi, edx) -> eax
my_memset PROC NEAR

    push    ebx
    push    edx

    mov     eax, edi
    mov     ecx, edi
    lea     ebx, [edi + edx]
    test    edi, edi                    ; Test if s is NULL
    je      lbl_end

lbl_loop:
    mov     edx, esi
    mov     BYTE ptr [ecx], dl
    inc     ecx
    cmp     ecx, ebx
    jb      lbl_loop

lbl_end:
    pop     edx
    pop     ebx

    ret
my_memset ENDP