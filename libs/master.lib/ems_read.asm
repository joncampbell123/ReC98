; master library - PC98 - MSDOS - EMS
;
; Description:
;	EMSメモリからデータを読み込む (Level 2)
;
; Function/Procedures:
;	int ems_read( unsigned handle, long offs, void far * mem, long len ) ;
;
; Parameters:
;	unsigned handle	EMSハンドル
;	long offs	EMSメモリ内のオフセットアドレス
;	void far * mem	格納先の先頭アドレス
;	long len	読み込むデータの長さ(バイト数)
;
; Returns:
;	0 ........... success
;	80h〜 ....... failure(EMS エラーコード)
;
; Binding Target:
;	Microsoft-C / Turbo-C / Turbo Pascal
;
; Running Target:
;	PC-9801
;
; Requiring Resources:
;	CPU: 8086
;	EMS: LIM EMS 4.0
;
; Notes:
;	
;
; Compiler/Assembler:
;	TASM 3.0
;	OPTASM 1.6
;
; Author:
;	恋塚昭彦
;
; Revision History:
;	92/11/16 Initial
;	93/ 2/24 bugfix (large data model)

func EMS_READ
	push	BP
	mov	BP,SP
	sub	SP,18

	; 引数
	@@handle	= (RETSIZE+7)*2
	@@offs	= (RETSIZE+5)*2
	@@mem	= (RETSIZE+3)*2
	@@len	= (RETSIZE+1)*2

	@@block	= -18

	mov	AX,[BP+@@len]
	mov	DX,[BP+@@len+2]
	mov	[BP+@@block],AX	;block
	mov	[BP+@@block+2],DX

	mov	BYTE PTR [BP+@@block+4],1	; EMS

	mov	AX,[BP+@@handle]
	mov	[BP+@@block+5],AX

	mov	AX,[BP+@@offs]
	mov	DX,AX
	and	DH,3Fh
	mov	[BP+@@block+7],DX
	mov	DX,[BP+@@offs+2]
	shl	AX,1
	rcl	DX,1
	shl	AX,1
	rcl	DX,1
	mov	[BP+@@block+9],DX


	mov	BYTE PTR [BP+@@block+11],0		; Main Memory
	mov	WORD PTR [BP+@@block+12],0

	mov	AX,[BP+@@mem]
	mov	[BP+@@block+14],AX

	mov	AX,[BP+@@mem+2]
	mov	[BP+@@block+16],AX

	_push	SS
	lea	AX,WORD PTR [BP+@@block]
	push	AX
	_call	EMS_MOVEMEMORYREGION
	push	AX			; push result

	sub	AX,AX
	push	AX
	_call	EMS_ENABLEPAGEFRAME

	pop	AX			; pop result
	mov	SP,BP
	pop	BP
	ret	14
endfunc
