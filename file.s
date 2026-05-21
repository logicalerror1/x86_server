.intel_syntax noprefix
.global _start

.section .text

_start:
mov rax, 41
mov rdi, 2
mov rsi, 1
xor rdx, rdx
syscall

mov r12, rax

sub rsp, 16
mov word ptr [rsp], 2
mov word ptr [rsp+2], 0x5000
mov qword ptr [rsp+4], 0
mov qword ptr [rsp+8], 0

mov rax, 49
mov rdi, r12
mov rsi, rsp
mov rdx, 16
syscall

mov rax, 50
mov rdi, r12
mov rsi, 0
syscall


main_loop:

mov rax, 43
mov rdi, r12
xor rsi, rsi 
xor rdx, rdx
syscall

mov r13, rax

mov rax, 57
syscall


cmp rax, 0
je child

parent:

mov rax, 3
mov rdi, r13
syscall
jmp main_loop


child:

mov rax, 3
mov rdi, r12
syscall


sub rsp, 4096

mov rax, 0
mov rdi, r13
mov rsi, rsp
mov rdx, 4096
syscall

mov r15, rax

mov rcx, 5

find_space:

cmp byte ptr [rsp+rcx], ' '
je found

inc rcx
jmp find_space

found:
mov byte ptr [rsp+rcx], 0




xor rbx, rbx


find_body:

cmp byte ptr [rsp+rbx], 13
jne next

cmp byte ptr [rsp+rbx+1], 10
jne next

cmp byte ptr [rsp+rbx+2], 13
jne next

cmp byte ptr [rsp+rbx+3], 10
jne next


add rbx, 4
jmp find_body


next:
inc rbx
jmp find_body

body_found:


mov rax, 2
lea rdi, [rsp+5]
mov rsi, 65
mov rdx, 0777
syscall

mov r14, rax

mov r10, r15
sub r10, rbx



mov rax, 1
mov rdi, r14
lea rsi, [rsp+rbx]
mov rdx, r10
syscall

mov rax, 3
mov rdi, r14
syscall


sub rsp, 19

mov byte ptr [rsp+0],72
mov byte ptr [rsp+1],84
mov byte ptr [rsp+2],84
mov byte ptr [rsp+3],80
mov byte ptr [rsp+4],47
mov byte ptr [rsp+5],49
mov byte ptr [rsp+6],46
mov byte ptr [rsp+7],48
mov byte ptr [rsp+8],32
mov byte ptr [rsp+9],50
mov byte ptr [rsp+10],48
mov byte ptr [rsp+11],48
mov byte ptr [rsp+12],32
mov byte ptr [rsp+13],79
mov byte ptr [rsp+14],75
mov byte ptr [rsp+15],13
mov byte ptr [rsp+16],10
mov byte ptr [rsp+17],13
mov byte ptr [rsp+18],10

mov rax, 1
mov rdi, r13
mov rsi, rsp
mov rdx, 19
syscall


mov rax, 3
mov rdi, r13
syscall

mov rax, 60
xor rdi, rdi
syscall