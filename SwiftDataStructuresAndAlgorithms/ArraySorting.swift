//
//  ArraySorting.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/5/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

public class ArraySorting<ItemT: Comparable> {
	
	public class func bubbleSort(inout array: [ItemT]) {
		
		var n = array.count		// last sorting index
		while n > 0 {
			var newN = 0		// new last sorting index
			for i in 1..<n {
				if array[i-1] > array[i] {
					swap(&array[i-1], &array[i])
					newN = i	// update last index when swap happens
				}
			}
			n = newN
		}
	}
	
	public class func insertionSort(inout array: [ItemT]) {
		
		let n = array.count
		if n <= 1 {
			return
		}
		for i in 1..<n {
			
			let current = array[i]		// i's
			var j: Int
			
			// shift when j's is greater than i's
			for j = i; j > 0 && array[j-1] > current; j-- {
				array[j] = array[j-1]
			}
			
			// insert i's at j
			array[j] = current
		}
	}
	
	public class func selectionSort(inout array: [ItemT]) {
		
		let n = array.count
		
		if n <= 1 {
			return
		}
		
		for j in 0..<n-1 {
			
			var iMin = j		// minimum for the rest
			
			for i in j+1..<n {
				if array[i] < array[iMin] {
					iMin = i		// new minimum
				}
			}
			
			if iMin != j {
				swap(&array[j], &array[iMin])
			}
		}
	}
}