//
//  Selection.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/25/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

public class Selection<ItemT: Comparable> {
	
	public class func largestItem(inout array: [ItemT]) -> ItemT? {
		if array.isEmpty {
			return nil
		}
		return quickSelect(&array, order: array.count)
	}
	
	public class func smallestItem(inout array: [ItemT]) -> ItemT? {
		if array.isEmpty {
			return nil
		}
		return quickSelect(&array, order: 1)
	}
	
	public class func medianItem(inout array: [ItemT]) -> ItemT? {
		if array.isEmpty {
			return nil
		}
		return quickSelect(&array, order: (array.count + 1) / 2)
	}
	
	// return kth smallest item index of `array`, nil if not exist.
	public class func quickSelect(inout array: [ItemT], order k: Int) -> ItemT? {
		
		// return nil if k out of bound
		if k < 1 || k > array.count {
			return nil
		}
		
		return array[quickSelectHelper(&array, order: k, iBegin: 0, iEnd: array.count)]
	}
	
	private class func quickSelectHelper(inout array: [ItemT], order k: Int, iBegin: Int, iEnd: Int) -> Int {
		
		if iBegin == iEnd - 1 {
			return iBegin
		}
		
		// partition
		
		var iPivot = quickSelectPivot(&array, iBegin: iBegin, iEnd: iEnd)
		
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
		
		// swap pivot back
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
		
		if k == iPivot - iBegin + 1 {
			return iBegin + k - 1
		} else if k < iPivot - iBegin + 1 {
			return quickSelectHelper(&array, order: k, iBegin: iBegin, iEnd: iPivot)
		} else {
			return quickSelectHelper(&array, order: k - iPivot + iBegin - 1, iBegin: iPivot + 1, iEnd: iEnd)
		}
	}
	
	private class func quickSelectPivot(inout array: [ItemT], iBegin: Int, iEnd: Int) -> Int{
		return iBegin
	}
}