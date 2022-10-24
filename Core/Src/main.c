/**
 ******************************************************************************
 * @file           : main.c
 * @author         : Ni Qingqing & Henry Tan, ECE, NUS
 * @brief          : Main program template for CG2028 Assignment
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2022 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */

#include "stdio.h"

#define M 6	 // No. of numbers in array

// Essential function to enable printf() using semihosting:
extern void initialise_monitor_handles(void);

// Function to be written in ARMv7E-M asm
extern int bubble_sort(int* arg1, int arg2);

int main(void)
{
	// Enabling printf() using semihosting
	initialise_monitor_handles();

	int arr[M] = {18, 34, 32, 75, 11, 97};
	int swap,i;  // no. of total swaps

	// Bubble sort with bubble_sort.s
	swap = bubble_sort((int*)arr, (int)M);
	printf("After %d rounds of swap, the array is sorted as: \n{ ", swap);

	for (i=0; i<M; i++)
	{
		printf("%d ", arr[i]);
	}
	printf("}\n");

	// Infinite loop
	while(1){}

}
