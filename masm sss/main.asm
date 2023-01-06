includelib kernel32.lib
includelib msvcrt.lib
ExitProcess  proto	
.data 
string db	 "123", 0
.code 
	main proc
	mov rbp, rsp; start creating stack frame -



	;moving the address of string onto stack
	lea rax , string;	mov qword ptr[rbp+8], 100
	mov qword ptr[rbp+4],rax;loading string addrss into rsp +4
	xor rax,rax
	mov rax,qword ptr[rbp+4]
	mov rax, qword ptr[rax]
	mov qword ptr[rbp+4], rax

	mov qword ptr[rbp+8],3; strlength
	mov qword ptr[rbp + 12],0;increment this 

	xor rax,rax; clearing rax 
	mov rax, qword ptr[rbp+8]; copying length
	dec rax
	mov qword ptr[rbp+16], rax;copy the value at rax (length -1) to tmp length

	xor rax,rax
	xor rdx,rdx

	;this ^^^^ works 
		;rcx is return val
	m_loop:

	
	mov rdx, qword ptr[rbp+4]
	sub rdx, '0';offset 
	;nested loop
	;x is = rbp +12
	;length-1 = rbp+16

	mov r9, qword ptr[rbp+16]
	
	xor rax,rax
	nst_loop:
		
		;rdx = temp
		;	mul rdx, 10
		mov rax,10
		mul rdx
		
		cmp r9, 0
		jz en_nst_loop
		dec r9
		add r8, rdx

		dec r9
		jmp nst_loop
	en_nst_loop:
	inc qword ptr[rbp+12]
	mov rax, qword ptr[rbp + 8]
	cmp qword ptr[rbp+12],rax
	jz en_m_loop
	jmp m_loop
	en_m_loop:




	pop rbp

	call ExitProcess
	main endp
end	