//
//  BinaryHeap.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/26/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

public class BinaryHeap<KeyT: Comparable, ValueT>: CustomStringConvertible {
	
	private var array: [HeapNode<KeyT, ValueT>?] = [nil]
	
	public func min() -> (key: KeyT, value: ValueT)? {
		
		if array.count < 2 {
			return nil
		}
		return (array[1]!.key, array[1]!.value)
	}
	
	public func insert(key: KeyT, value: ValueT) {
		
		var index = array.count
		let node = HeapNode(key: key, value: value)
		array.append(node)
		
		// bubble up the new node
		// repeat when current node is not root and less than is parent
		while (array[index / 2] != nil
			&& array[index]!.key < array[parentIndex(index)]!.key) {
				
				swap(&array[index], &array[parentIndex(index)])
				index = parentIndex(index)
		}
	}
	
	public func deleteMin() {
		
		if array.count == 0 {
			return
		}
		
		// remove the root and fill it with the last node
		if array.count > 2 {
			swap(&array[1], &array[array.count - 1])
		}
		array.removeLast()
		
		// bubble down the root node
		bubbleDown(1)
	}
	
	public var size: Int {
		return array.count - 1
	}
	
	private func bubbleDown(var index: Int) {
		
		// while less than its left child or right child
		while (index * 2 < array.count && array[index]!.key > array[index * 2]!.key)
			|| (index * 2 + 1 < array.count && array[index]!.key > array[index * 2 + 1]!.key) {
				
				// exchange node with its smaller child
				if index * 2 + 1 >= array.count {		// has only left child
					swap(&array[index], &array[index * 2])
					return
				} else if array[index * 2]!.key < array[index * 2 + 1]!.key {		// has right child
					swap(&array[index], &array[index * 2])
					index = index * 2
				} else {
					swap(&array[index], &array[index * 2 + 1])
					index = index * 2 + 1
				}
		}
	}
	
	private func bottomUpHeap() {
		
		for var index = array.count - 1; index > 0 ; index-- {
			bubbleDown(index)
		}
	}
	
	private func parentIndex(index: Int) -> Int {
		return (index / 2)
	}
	
	private func leftChildIndex(index: Int) -> Int {
		return (index * 2)
	}
	
	private func rightChildIndex(index: Int) -> Int {
		return (index * 2) + 1
	}
	
	private func siblingIndex(index: Int) -> Int {
		if ((index % 2) == 0) {
			return index / 2 * 2 + 1
		} else {
			return index / 2 * 2
		}
	}
	
	public init() {
		
	}
	
	// init with array of key-value tuples
	public init(array: [(key: KeyT, value: ValueT)]) {
		for (itemKey, itemValue) in array {
			self.array.append(HeapNode(key: itemKey, value: itemValue))
		}
		bottomUpHeap()
	}
	
	public var description: String {
		
		var desc = "["
		
		for (idx, item) in array.enumerate() {
			
			if idx == 0 {
				desc += "\(item)"
			} else {
				desc += "\(item!)"
			}
			
			if idx != (array.count - 1) {
				desc += ", "
			}
		}
		
		desc += "]"
		
		return desc
	}
}

private class HeapNode<KeyT: Comparable, ValueT>: CustomStringConvertible {
	
	var key: KeyT
	var value: ValueT
	
	init(key: KeyT, value: ValueT) {
		self.key = key
		self.value = value
	}
	
	private var description: String {
		return "\(key)"
	}
}