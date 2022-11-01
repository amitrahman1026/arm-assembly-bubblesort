/*
 * bubble_sort.s
 *
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb
	.global bubble_sort

@ Start of executable code
.section .text

@ Bubble sort any given array in ascending order

@ Enter registers look-up table here:
@ R0 ... arr*, return swapCounter
@ R1 ... size of array
@ R2 ... swapCounter
@ R3 ... isSwapped
@ R4 ... Outerloop iterator
@ R5 ... Innerloop iterator
@ R6 ... index of left element
@ R7 ... index of right element

/*

 *	Pseudo code
 *	do{
 *		isSwapped = false
 *		for i = 1 to indexOfLastUnsortedElement-1
 *		if leftElement > rightElement
 *      	swap(leftElement, rightElement)
 *      	isSwapped = true; ++swapCounter
 *	}
 *	while isSwapped
 */

bubble_sort:
	PUSH {R2-R7, R14}
	MOV	R2, #0			 		@	0x03A22000 counter for number of swaps
	MOV	R3, #1  				@	0x03A33001 isSwapped = true

Outerloop:
	CMP R3, #1					@	0x03433001 isSwapped?
	BNE FINISH					@	if !isSwapped, Exit
	MOV R3, #0					@	0x03A33000 set swapped register as false
	MOV R4, #1					@	0x03A44001 initialize for loop to start at i = 1
	B	Innerloop				@	0xE8800040 jump to inner loop

Innerloop:
	CMP R4, R1					@	check index out of bound
	BNE Compare
	B	Outerloop				@	Go back to Outerloop once InnerLoop finished

Compare:
	SUB R5, R4, #1				@	0x02445001 r5 = i -1
	LDR R6, [R0,R5,LSL #2]		@	r6 = A[r5]
	LDR R7,[R0,R4,LSL #2]		@	r7 = A[r4]
	CMP	R6, R7					@	0x1476000 compare A[i-1]>A[i]
	BGT	Swap					@	swap if A[i-1]>A[i]
	B	Increment           	@	increment i
Swap:
	STR	R6,[R0, R4, LSL #2]		@	*(A + i * 4)
	STR	R7,[R0, R5, LSL #2]		@	*(A + (i -1) * 4)
	MOV	R3,#1					@	0x03A03001 isSwapped = true
	ADD R2, R2, #1				@	0x02822001 increment swap counter
	B	Increment				@	increment i

Increment:
	ADD	R4, R4,#1           	@	0x02844001 Next element number
	B	Innerloop				@	Next iterations of innerloop

FINISH:
	MOV R0, R2					@	0x01A20002 pass retrun value of number of swaps done
	POP	{R3-R7, R14}        	@	restore context
	BX	LR						@	return to main.c
