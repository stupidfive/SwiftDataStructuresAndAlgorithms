//
//  BSTNode.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

// This class is intended to use only in the implementation of BST and its subclasses.
class BSTNode<KeyT: Comparable, ValueT>: CustomStringConvertible {
	
	weak var parent: BSTNode<KeyT, ValueT>?
	var leftChild: BSTNode<KeyT, ValueT>?
	var rightChild: BSTNode<KeyT, ValueT>?
	
	let key: KeyT
	var value: ValueT
	
	func rightMostChild() -> BSTNode<KeyT, ValueT> {
		var tempNode: BSTNode<KeyT, ValueT> = self
		while tempNode.rightChild != nil {
			tempNode = tempNode.rightChild!
		}
		return tempNode
	}
	
	func leftMostChild() -> BSTNode<KeyT, ValueT> {
		var tempNode: BSTNode<KeyT, ValueT> = self
		while tempNode.leftChild != nil {
			tempNode = tempNode.leftChild!
		}
		return tempNode
	}
	
	init(key: KeyT, value: ValueT) {
		
		self.key = key
		self.value = value
	}
	
	var description: String {
		
		return shortStraightDescription()
	}
	
}

extension BSTNode {
	
	func shortStraightDescription() -> String {
		
		var desc = ""
		
		if leftChild != nil {
			desc += "(\(leftChild!))/ "
		}
		
		desc += "\(key)"
		
		if rightChild != nil {
			desc += " \\(\(rightChild!))"
		}
		
		return desc
	}
	
	func shortJSONDescription() -> String {
		
		var desc = "{"
		
		// !!!: doesn't support numerics, all strings
		desc += "\"\(key)\" : "
		
		if leftChild == nil {
			desc += "[null, "
		} else {
			desc += "[\(leftChild!), "
		}
		
		if rightChild == nil {
			desc += "null]"
		} else {
			desc += "\(rightChild!)]"
		}
		desc += "}"
		return desc
	}
	
	func JSONDescription() -> String {
		
		var desc = "{\n"
		
		// !!!: doesn't support numerics, all strings
		desc += "\"key\": \"\(key)\",\n"
		desc += "\"value\": \"\(value)\",\n"
		
		if leftChild == nil {
			desc += "\"leftChild\": null,\n"
		} else {
			desc += "\"leftChild\": \(leftChild!),\n"
		}
		
		if rightChild == nil {
			desc += "\"rightChild\": null\n"
		} else {
			desc += "\"rightChild\": \(rightChild!)\n"
		}
		desc += "}\n"
		return desc
	}
}