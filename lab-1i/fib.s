	.syntax unified
	.arch armv7-a
	.text
	.align 2
	.thumb
	.thumb_func

	.global fibonacci
	.type fibonacci, function

fibonacci:
	@ ADD/MODIFY CODE BELOW
	@ PROLOG
	push {r3, r4, r5, lr}

	@ R4 = R0 - 0 (update flags)
	@ if(R0 <= 0) goto .L3 (which returns 0)
	subs r4, r0, #1
	ble .L3

	@ Compare R4 wtih 1
	@ If R4 == 1 goto .L4 (which returns 1)
	cmp r4, #1
	beq .L4

	@ R3: index
	@ R4: f(n)
	@ R5: f(n-1)
	mov r3, #2
	mov r4, #1
	mov r5, #0

loop:
	@ f(n) = f(n-1) + f(n-2)
	add r4, r4, r5

	@ Make f(n-1) = f(n-2)
	sub r5, r4, r5

	add r3, r3, #1
	cmp r3, r0
	ble loop

	mov r0, r4
	pop {r3, r4, r5, pc}		@EPILOG

	@ END CODE MODIFICATION
.L3:
	mov r0, #0			@ R0 = 0
	pop {r3, r4, r5, pc}		@ EPILOG

.L4:
	mov r0, #1			@ R0 = 1
	pop {r3, r4, r5, pc}		@ EPILOG

	.size fibonacci, .-fibonacci
	.end
