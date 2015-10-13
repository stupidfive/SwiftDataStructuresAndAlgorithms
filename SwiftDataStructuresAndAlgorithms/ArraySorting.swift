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
	
	// MARK: - merge sort
	
	// top-down split/merge approach
	
	///	Merge sort
	///
	///	- parameter array:	array to be sorted
	public class func mergeSort(inout array: [ItemT]) {
		
		var tempArray = [ItemT?](count: array.count, repeatedValue: nil)
		splitMerge(&array, iBegin: 0, iEnd: array.count, tempArray: &tempArray)
	}
	
	///	Split and merge a subarray of `array`.
	///
	///	- parameter array:				the array
	///	- parameter iBegin:				begin index(included)
	///	- parameter iEnd:				end index(not included)
	///	- parameter tempArray:			work array
	private class func splitMerge(inout array: [ItemT], iBegin: Int, iEnd: Int, inout tempArray: [ItemT?]) {
		
		if iEnd - iBegin < 2 {
			return;
		}
		
		let iMid = (iBegin + iEnd) / 2
		splitMerge(&array, iBegin: iBegin, iEnd: iMid, tempArray: &tempArray)
		splitMerge(&array, iBegin: iMid, iEnd: iEnd, tempArray: &tempArray)
		
		merge(&array, iBegin: iBegin, iMid: iMid, iEnd: iEnd, merged: &tempArray)
		copyArray(&array, fromArray: &tempArray, iBegin: iBegin, iEnd: iEnd)
	}
	
	private class func merge(inout array: [ItemT], iBegin: Int, iMid: Int, iEnd: Int, inout merged: [ItemT?]) {
		
		var idx = iBegin
		
		var leftIdx = iBegin
		var rightIdx = iMid
		
		// pick the smallest head from left and right half
		while leftIdx < iMid && rightIdx < iEnd {
			
			if array[leftIdx] < array[rightIdx] {
				
				merged[idx] = array[leftIdx]
				leftIdx++;
			} else {
				
				merged[idx] = array[rightIdx]
				rightIdx++;
			}
			idx++;
		}
		
		// fill the merged array with the rest of what's remaining
		if leftIdx < iMid {
			
			while leftIdx < iMid {
				merged[idx] = array[leftIdx]
				idx++
				leftIdx++
			}
		} else {
			
			while rightIdx < iEnd {
				merged[idx] = array[rightIdx]
				idx++
				rightIdx++
			}
		}
	}
	
	// copy a part of an array to another
	private class func copyArray(inout array: [ItemT], inout fromArray: [ItemT?], iBegin: Int, iEnd: Int) {
		
		for i in iBegin..<iEnd {
			
			array[i] = fromArray[i]!
		}
	}
	
	// MARK: - quick sort
	
	public class func quickSort(inout array: [ItemT]) {
		
		quickSort(&array, iBegin: 0, iEnd: array.count)
	}
	
	private class func quickSort(inout array: [ItemT], iBegin: Int, iEnd: Int) {
		
		let length = iEnd - iBegin
		
		switch length {
		case 0, 1:
			return
		case 2:
			if iBegin > iEnd {
				swap(&array[iBegin], &array[iEnd])
			}
		default:
			break
		}
		
		// divide array into smaller part and larger part base on pivot
		
		var iPivot = quickSortPivot(&array, iBegin: iBegin, iEnd: iEnd)
		
		// swap pivot to front
		if iPivot != iBegin {
			swap(&array[iPivot], &array[iBegin])
			iPivot = iBegin
		}
		
		var iForeward = iBegin + 1
		var iBackward = iEnd - 1
		
		while iForeward < iBackward {
			
			while array[iForeward] <= array[iPivot] && iForeward < iBackward {
				iForeward++
			}
			
			while array[iBackward] >= array[iPivot] && iForeward < iBackward {
				iBackward--
			}
			
			if iForeward != iBackward {
				swap(&array[iForeward], &array[iBackward])
			}
		}
		
		if array[iPivot] < array[iForeward] {
			if iPivot != iForeward - 1 {
				swap(&array[iPivot], &array[iForeward - 1])
				iPivot = iForeward - 1
			}
		} else {
			if iPivot != iForeward {
				swap(&array[iPivot], &array[iForeward])
				iPivot = iForeward
			}
		}
		
		// recursively sort the smaller part and larger part
		quickSort(&array, iBegin: iBegin, iEnd: iPivot)
		quickSort(&array, iBegin: iPivot + 1, iEnd: iEnd)
	}

	// simplest approach is adopted
	private class func quickSortPivot(inout array: [ItemT], iBegin: Int, iEnd: Int) -> Int{
		return iBegin
	}
}