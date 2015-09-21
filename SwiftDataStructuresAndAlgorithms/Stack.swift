//
//  Stack.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

/// A Swift array backed stack.
public class Stack<ItemT>: CustomStringConvertible {
	
	// array's tail as top
	private var array = [ItemT]()
	
	public var isEmpty: Bool {
		return array.isEmpty
	}
	
	public func pop() -> ItemT? {
		
		if array.isEmpty {
			return nil
		}
		let item = array.last
		array.removeLast()
		return item
	}
	
	public func push(item: ItemT) {
		
		array.append(item)
	}
	
	public func top() -> ItemT? {
		
		if array.isEmpty {
			return nil
		}
		return array.last
	}
	
	// init an empty stack
	public init() {
		
	}
	
	// init stack with an array
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