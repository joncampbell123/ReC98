; int __cdecl far vector1_at(int angle, int length, int origin)
; (different calling convention than the TH04/TH05 one)
vector1_at	proc far

@@origin	= word ptr  6
@@length	= word ptr  8
@@angle	= word ptr  0Ah

	push	bp
	mov	bp, sp
	movsx	eax, [bp+@@length]
	movsx	edx, [bp+@@angle]
	imul	eax, edx
	sar	eax, 8
	add	ax, [bp+@@origin]
	pop	bp
	retf
vector1_at	endp
