/*
 * bubble_sort.s
 *
 *  Created: Sem 1 Ay2022/2023
 *  Authors: Ni Qingqing & Henry Tan
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb
	.global bubble_sort

@ Start of executable code
.section .text

@ CG2028 Assignment
@ (c) ECE NUS, 2022
@ Bubble sort any given array in ascending order

@ Enter Student 1’s Name here: Amit Rahman
@ Enter Student 2’s Name here: Chen Zi Han

@ Enter registers look-up table here:
@ R0 ...
@ R1 ...

@ Enter your program code here:

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
	MOV	R2, #0			 	@	counter for number of swaps
	MOV	R3, #1  			@	isSwapped = true

Outerloop:
	CMP R3, #1				@	isSwapped?
	BNE FINISH				@	if !isSwapped, Exit
	MOV R3, #0				@	set swapped register as false
	MOV R4, #1				@	initialize for loop to start at i = 1
	B	Innerloop			@	jump to inner loop

Innerloop:
	CMP R4, R1				@	check index out of bound
	BNE Compare
	B	Outerloop			@	Go back to Outerloop once InnerLoop finished

Compare:
	SUB R5, R4, #1			@	r5 = i -1
	LDR R6, [R0,R5,LSL #2]	@	r6 = A[r5]
	LDR R7,[R0,R4,LSL #2]	@	r7 = A[r4]
	CMP	R6, R7				@	compare A[i-1]>A[i]
	BGT	Swap				@	swap if A[i-1]>A[i]
	B	Increment           @	increment i
Swap:
	STR	R6,[R0, R4, LSL #2]	@	*(A + i * 4)
	STR	R7,[R0, R5, LSL #2]	@	*(A + (i -1) * 4)
	MOV	R3,#1				@	isSwapped = true
	ADD R2, R2, #1			@	increment swap counter
	B	Increment			@	increment i

Increment:
	ADD	R4, R4,#1           @	Next element number
	B	Innerloop			@	Next iterations of innerloop

FINISH:
	MOV R0, R2				@	pass retrun value of number of swaps done
	POP	{R3-R7, R14}        @	restore context
	BX	LR
