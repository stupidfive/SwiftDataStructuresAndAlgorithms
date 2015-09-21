//
//  Queue.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

/// Swift array based queue.
public class Queue<ItemT>: CustomStringConvertible {
	
	// array's head as front
	private var array = [ItemT]()
	
	public var isEmpty: Bool {
		return array.isEmpty
	}
	
	public func enqueue(item: ItemT) {
		
		array.append(item)
	}
	
	// remove the first item from array and return
	public func dequeue() -> ItemT? {
		
		if array.isEmpty {
			return nil
		}
		let item = array.first
		array.removeFirst()
		return item
	}
	
	public func front() -> ItemT? {
		if array.isEmpty {
			return nil
		}
		return array.first
	}
	
	public var size: Int {
		return array.count
	}
	
	// init an empty queue
	public init() {
		
	}
	
	// init queue with an array
	public init(array: [ItemT]) {
		self.array = array
	}
	
	public var description: String {
		
		var desc = "["
		
		for (idx, item) in array.enumerate() {
			desc += "\(item)"
			
			if idx != (array.count - 1) {
				desc += ", "
			}
		}
		
		desc += "]"
		
		return desc
	}
}