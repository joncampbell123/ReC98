; *Not* the original file, but an edit to turn it into an includable slice.
; Changes include:
; * removal of RULES.ASI to eliminate redundancy
; * removal of the 'CODE' segment declaration (for obvious reasons)

;[]-----------------------------------------------------------------[]
;|      H_PADD.ASM -- long pointer routines                          |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 5.0
; 
;       Copyright (c) 1987, 1992 by Borland International
;       All Rights Reserved.
; 
; calls to these routines are generated by the compiler to perform
; arithmetic operations on huge pointers.

                public  PADD@
                public  F_PADD@
                public  N_PADD@

N_PADD@:
                pop     es                      ;fix up far return
                push    cs
                push    es
PADD@:
F_PADD@:
                or      cx,cx
                jge     add1
                not     bx
                not     cx
                add     bx,1
                adc     cx,0
                jmp     sub1
add1:
                add     ax,bx
                jnc     addok
                add     dx,1000h
addok:
                mov     ch,cl
                mov     cl,4
                shl     ch,cl
                add     dh,ch
                mov     ch,al
                shr     ax,cl
                add     dx,ax
                mov     al,ch
                and     ax,0fh
                retf

                public  PSUB@
                public  F_PSUB@
                public  N_PSUB@

N_PSUB@:
                pop     es                      ;fix up far return
                push    cs
                push    es
PSUB@:
F_PSUB@:
                or      cx,cx
                jge     sub1
                not     bx
                not     cx
                add     bx,1
                adc     cx,0
                jmp     add1
sub1:
                sub     ax,bx
                jnc     subok
                sub     dx,1000h
subok:
                mov     bh,cl
                mov     cl,4
                shl     bh,cl
                xor     bl,bl
                sub     dx,bx
                mov     ch,al
                shr     ax,cl
                add     dx,ax
                mov     al,ch
                and     ax,0fh
                retf
