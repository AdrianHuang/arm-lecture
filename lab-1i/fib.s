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
	push {r4, r5, lr}

	@ R4 = R0 - 0 (update flags)
	@ if(R0 <= 0) goto .L3 (which returns 0)
	subs r4, r0, #1
	ble .L3

	@ R0: index (The starting index is n-1)
	@ R4: f(n)
	@ R5: f(n-1)
	sub r0, r0, #1
	mov r4, #1
	mov r5, #0

loop:
	@ f(n) = f(n-1) + f(n-2)
	add r4, r4, r5

	@ Make f(n-1) = f(n-2)
	sub r5, r4, r5

	subs r0, r0, #1
	bne loop

	mov r0, r4
	pop {r4, r5, pc}		@EPILOG

	@ END CODE MODIFICATION
.L3:
	mov r0, #0			@ R0 = 0
	pop {r4, r5, pc}		@ EPILOG

	.size fibonacci, .-fibonacci
	.end
