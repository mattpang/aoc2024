## -- compile with $clang -arch x86_64 -masm=intel -o a.out day24.s
	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 4
	.intel_syntax noprefix
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	mov	eax, 800112
	call	____chkstk_darwin
	sub	rsp, rax
	mov	rax, qword ptr [rip + ___stack_chk_guard@GOTPCREL]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 8], rax
	mov	dword ptr [rbp - 800036], 0
	mov	dword ptr [rbp - 800040], edi
	mov	qword ptr [rbp - 800048], rsi
	lea	rax, [rip + L_.str]
	mov	qword ptr [rbp - 800056], rax
	mov	qword ptr [rbp - 800064], 0
	mov	dword ptr [rbp - 800068], 1
	mov	rdi, qword ptr [rbp - 800056]
	lea	rsi, [rip + L_.str.1]
	call	_fopen
	mov	qword ptr [rbp - 800096], rax
	lea	rdi, [rbp - 800032]
	mov	esi, 255
	mov	edx, 800000
	call	_memset
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	lea	rdi, [rbp - 32]
	mov	rdx, qword ptr [rbp - 800096]
	mov	esi, 20
	call	_fgets
	cmp	rax, 0
	je	LBB0_5
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movsx	eax, byte ptr [rbp - 32]
	cmp	eax, 10
	jne	LBB0_4
## %bb.3:
	jmp	LBB0_5
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	lea	rdi, [rbp - 32]
	lea	rsi, [rip + L_.str.2]
	call	_strtok
	mov	rdi, rax
	call	_hash
	mov	dword ptr [rbp - 800072], eax
	xor	eax, eax
	mov	edi, eax
	lea	rsi, [rip + L_.str.3]
	call	_strtok
	mov	rdi, rax
	xor	eax, eax
	mov	esi, eax
	mov	edx, 10
	call	_strtol
                                        ## kill: def $eax killed $eax killed $rax
	mov	dword ptr [rbp - 800076], eax
	mov	ecx, dword ptr [rbp - 800076]
	movsxd	rdx, dword ptr [rbp - 800072]
	lea	rax, [rbp - 800032]
	shl	rdx, 4
	add	rax, rdx
	mov	dword ptr [rax + 12], ecx
	jmp	LBB0_1
LBB0_5:
	jmp	LBB0_6
LBB0_6:                                 ## =>This Inner Loop Header: Depth=1
	lea	rdi, [rbp - 32]
	mov	rdx, qword ptr [rbp - 800096]
	mov	esi, 20
	call	_fgets
	cmp	rax, 0
	je	LBB0_10
## %bb.7:                               ##   in Loop: Header=BB0_6 Depth=1
	movsx	eax, byte ptr [rbp - 32]
	cmp	eax, 10
	jne	LBB0_9
## %bb.8:
	jmp	LBB0_10
LBB0_9:                                 ##   in Loop: Header=BB0_6 Depth=1
	lea	rdi, [rbp - 32]
	lea	rsi, [rip + L_.str.4]
	call	_strtok
	mov	rdi, rax
	call	_hash
	mov	dword ptr [rbp - 800072], eax
	xor	eax, eax
	mov	edi, eax
	lea	rsi, [rip + L_.str.4]
	call	_strtok
	movsx	eax, byte ptr [rax]
	mov	dword ptr [rbp - 800084], eax
	xor	eax, eax
	mov	edi, eax
	lea	rsi, [rip + L_.str.4]
	call	_strtok
	mov	rdi, rax
	call	_hash
	mov	dword ptr [rbp - 800076], eax
	xor	eax, eax
	mov	edi, eax
	lea	rsi, [rip + L_.str.3]
	call	_strtok
	mov	rdi, rax
	add	rdi, 3
	call	_hash
	mov	dword ptr [rbp - 800080], eax
	mov	ecx, dword ptr [rbp - 800072]
	movsxd	rdx, dword ptr [rbp - 800080]
	lea	rax, [rbp - 800032]
	shl	rdx, 4
	add	rax, rdx
	mov	dword ptr [rax], ecx
	mov	ecx, dword ptr [rbp - 800076]
	movsxd	rdx, dword ptr [rbp - 800080]
	lea	rax, [rbp - 800032]
	shl	rdx, 4
	add	rax, rdx
	mov	dword ptr [rax + 4], ecx
	mov	ecx, dword ptr [rbp - 800084]
	movsxd	rdx, dword ptr [rbp - 800080]
	lea	rax, [rbp - 800032]
	shl	rdx, 4
	add	rax, rdx
	mov	dword ptr [rax + 8], ecx
	jmp	LBB0_6
LBB0_10:
	lea	rdi, [rip + L_.str.5]
	call	_hash
	mov	dword ptr [rbp - 800072], eax
	mov	dword ptr [rbp - 800100], 0
LBB0_11:                                ## =>This Inner Loop Header: Depth=1
	movsxd	rcx, dword ptr [rbp - 800072]
	lea	rax, [rbp - 800032]
	shl	rcx, 4
	add	rax, rcx
	cmp	dword ptr [rax], -1
	jle	LBB0_14
## %bb.12:                              ##   in Loop: Header=BB0_11 Depth=1
	mov	edi, dword ptr [rbp - 800072]
	lea	rsi, [rbp - 800032]
	call	_calculate
	mov	ecx, dword ptr [rbp - 800100]
                                        ## kill: def $rcx killed $ecx
                                        ## kill: def $cl killed $rcx
	shl	rax, cl
	add	rax, qword ptr [rbp - 800064]
	mov	qword ptr [rbp - 800064], rax
	lea	rdi, [rbp - 800088]
	mov	r9d, dword ptr [rbp - 800100]
	add	r9d, 1
	mov	ecx, 4
	xor	edx, edx
	lea	r8, [rip + L_.str.6]
	mov	rsi, rcx
	mov	al, 0
	call	___snprintf_chk
	lea	rdi, [rbp - 800088]
	call	_hash
	mov	dword ptr [rbp - 800072], eax
## %bb.13:                              ##   in Loop: Header=BB0_11 Depth=1
	mov	eax, dword ptr [rbp - 800100]
	add	eax, 1
	mov	dword ptr [rbp - 800100], eax
	jmp	LBB0_11
LBB0_14:
	mov	rsi, qword ptr [rbp - 800064]
	lea	rdi, [rip + L_.str.7]
	mov	al, 0
	call	_printf
	mov	rax, qword ptr [rip + ___stack_chk_guard@GOTPCREL]
	mov	rax, qword ptr [rax]
	mov	rcx, qword ptr [rbp - 8]
	cmp	rax, rcx
	jne	LBB0_16
## %bb.15:
	xor	eax, eax
	add	rsp, 800112
	pop	rbp
	ret
LBB0_16:
	call	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function
	.globl	_hash                           ## -- Begin function hash
	.p2align	4, 0x90
_hash:                                  ## @hash
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	mov	qword ptr [rbp - 8], rdi
	mov	dword ptr [rbp - 16], 0
	mov	dword ptr [rbp - 20], 0
LBB1_1:                                 ## =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 8]
	movsxd	rcx, dword ptr [rbp - 20]
	cmp	byte ptr [rax + rcx], 0
	je	LBB1_6
## %bb.2:                               ##   in Loop: Header=BB1_1 Depth=1
	imul	eax, dword ptr [rbp - 16], 36
	mov	dword ptr [rbp - 16], eax
	mov	rax, qword ptr [rbp - 8]
	movsxd	rcx, dword ptr [rbp - 20]
	movsx	eax, byte ptr [rax + rcx]
	sub	eax, 48
	mov	dword ptr [rbp - 12], eax
	cmp	dword ptr [rbp - 12], 11
	jle	LBB1_4
## %bb.3:                               ##   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [rbp - 12]
	sub	eax, 39
	mov	dword ptr [rbp - 12], eax
LBB1_4:                                 ##   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [rbp - 12]
	add	eax, dword ptr [rbp - 16]
	mov	dword ptr [rbp - 16], eax
## %bb.5:                               ##   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [rbp - 20]
	add	eax, 1
	mov	dword ptr [rbp - 20], eax
	jmp	LBB1_1
LBB1_6:
	mov	eax, dword ptr [rbp - 16]
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.globl	_calculate                      ## -- Begin function calculate
	.p2align	4, 0x90
_calculate:                             ## @calculate
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 48
	mov	dword ptr [rbp - 12], edi
	mov	qword ptr [rbp - 24], rsi
	mov	rax, qword ptr [rbp - 24]
	movsxd	rcx, dword ptr [rbp - 12]
	shl	rcx, 4
	add	rax, rcx
	cmp	dword ptr [rax + 12], -1
	jle	LBB2_2
## %bb.1:
	mov	rax, qword ptr [rbp - 24]
	movsxd	rcx, dword ptr [rbp - 12]
	shl	rcx, 4
	add	rax, rcx
	movsxd	rax, dword ptr [rax + 12]
	mov	qword ptr [rbp - 8], rax
	jmp	LBB2_7
LBB2_2:
	mov	rsi, qword ptr [rbp - 24]
	movsxd	rax, dword ptr [rbp - 12]
	shl	rax, 4
	mov	edi, dword ptr [rsi + rax]
	call	_calculate
                                        ## kill: def $eax killed $eax killed $rax
	mov	dword ptr [rbp - 28], eax
	mov	rsi, qword ptr [rbp - 24]
	movsxd	rax, dword ptr [rbp - 12]
	shl	rax, 4
	mov	edi, dword ptr [rsi + rax + 4]
	call	_calculate
                                        ## kill: def $eax killed $eax killed $rax
	mov	dword ptr [rbp - 32], eax
	mov	rax, qword ptr [rbp - 24]
	movsxd	rcx, dword ptr [rbp - 12]
	shl	rcx, 4
	mov	eax, dword ptr [rax + rcx + 8]
	mov	dword ptr [rbp - 36], eax       ## 4-byte Spill
	sub	eax, 65
	je	LBB2_3
	jmp	LBB2_8
LBB2_8:
	mov	eax, dword ptr [rbp - 36]       ## 4-byte Reload
	sub	eax, 79
	je	LBB2_4
	jmp	LBB2_9
LBB2_9:
	mov	eax, dword ptr [rbp - 36]       ## 4-byte Reload
	sub	eax, 88
	je	LBB2_5
	jmp	LBB2_6
LBB2_3:
	mov	ecx, dword ptr [rbp - 28]
	and	ecx, dword ptr [rbp - 32]
	mov	rax, qword ptr [rbp - 24]
	movsxd	rdx, dword ptr [rbp - 12]
	shl	rdx, 4
	add	rax, rdx
	mov	dword ptr [rax + 12], ecx
	mov	rax, qword ptr [rbp - 24]
	movsxd	rcx, dword ptr [rbp - 12]
	shl	rcx, 4
	add	rax, rcx
	movsxd	rax, dword ptr [rax + 12]
	mov	qword ptr [rbp - 8], rax
	jmp	LBB2_7
LBB2_4:
	mov	ecx, dword ptr [rbp - 28]
	or	ecx, dword ptr [rbp - 32]
	mov	rax, qword ptr [rbp - 24]
	movsxd	rdx, dword ptr [rbp - 12]
	shl	rdx, 4
	add	rax, rdx
	mov	dword ptr [rax + 12], ecx
	mov	rax, qword ptr [rbp - 24]
	movsxd	rcx, dword ptr [rbp - 12]
	shl	rcx, 4
	add	rax, rcx
	movsxd	rax, dword ptr [rax + 12]
	mov	qword ptr [rbp - 8], rax
	jmp	LBB2_7
LBB2_5:
	mov	ecx, dword ptr [rbp - 28]
	xor	ecx, dword ptr [rbp - 32]
	mov	rax, qword ptr [rbp - 24]
	movsxd	rdx, dword ptr [rbp - 12]
	shl	rdx, 4
	add	rax, rdx
	mov	dword ptr [rax + 12], ecx
	mov	rax, qword ptr [rbp - 24]
	movsxd	rcx, dword ptr [rbp - 12]
	shl	rcx, 4
	add	rax, rcx
	movsxd	rax, dword ptr [rax + 12]
	mov	qword ptr [rbp - 8], rax
	jmp	LBB2_7
LBB2_6:
	mov	qword ptr [rbp - 8], -1
LBB2_7:
	mov	rax, qword ptr [rbp - 8]
	add	rsp, 48
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"./inputs/input-24.txt"

L_.str.1:                               ## @.str.1
	.asciz	"r"

L_.str.2:                               ## @.str.2
	.asciz	":"

L_.str.3:                               ## @.str.3
	.asciz	"\n"

L_.str.4:                               ## @.str.4
	.asciz	" "

L_.str.5:                               ## @.str.5
	.asciz	"z00"

L_.str.6:                               ## @.str.6
	.asciz	"z%02d"

L_.str.7:                               ## @.str.7
	.asciz	"%ld\n"

.subsections_via_symbols
