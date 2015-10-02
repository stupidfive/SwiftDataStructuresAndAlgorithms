//
//  RedBlackTree.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/28/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation
enum RBTNodeColor: Int {
	case Red = 0
	case Black = 1
}

class RedBlackTree<KeyT: Comparable, ValueT>: BinarySearchTree<KeyT, ValueT> {
	
	override func insert(key: KeyT, value: ValueT) {
		
		let node = RBTNode(key: key, value: value)
		
		insertNodeReplacingDuplicate(node)
		
		insertCase1(node)
	}
	
	private func insertCase1(node: RBTNode<KeyT, ValueT>) {
		
		if node.parent == nil {
			node.color = .Black
		} else {
			insertCase2(node)
		}
	}
	
	private func insertCase2(node: RBTNode<KeyT, ValueT>) {
		
		if (node.parent! as! RBTNode<KeyT, ValueT>).color == .Black {
			return
		} else {
			insertCase3(node)
		}
	}
	
	private func insertCase3(node: RBTNode<KeyT, ValueT>) {
		
		let uncle = node.uncle(node)
		let grandParent: RBTNode<KeyT, ValueT>
		
		if uncle != nil && uncle!.color == .Red {
			(node.parent! as! RBTNode<KeyT, ValueT>).color = .Black
			uncle!.color = .Black
			grandParent = node.grandParent(node)!
			grandParent.color = .Red
			insertCase1(grandParent)
		} else {
			insertCase4(node)
		}
	}
	
	private func insertCase4(node: RBTNode<KeyT, ValueT>) {
		
		let grandParent = node.grandParent(node)!
		
		var case5Node = node
		if node === node.parent!.rightChild && node.parent === grandParent.leftChild {
			rotateLeft(node, parent: node.parent as! RBTNode<KeyT, ValueT>)
			case5Node = node.leftChild as! RBTNode<KeyT, ValueT>
		} else if node === node.parent!.leftChild && node.parent === grandParent.rightChild {
			
			rotateRight(node, parent: node.parent as! RBTNode<KeyT, ValueT>)
			case5Node = node.rightChild as! RBTNode<KeyT, ValueT>
		}
		insertCase5(case5Node)
	}
	
	private func insertCase5(node: RBTNode<KeyT, ValueT>) {
		
		let grandParent = node.grandParent(node)
		
		(node.parent! as! RBTNode<KeyT, ValueT>).color = .Black
		grandParent!.color = .Red
		if (node === node.parent!.leftChild) {
			rotateRight(node.parent! as! RBTNode<KeyT, ValueT>, parent: grandParent!)
			
		} else {
			rotateLeft(node.parent! as! RBTNode<KeyT, ValueT>, parent: grandParent!)
		}
	}
	
	private func rotateRight(node: RBTNode<KeyT, ValueT>, parent: RBTNode<KeyT, ValueT>) {
		
		let grandParent = parent.parent
		
		// link up with grandParent
		if grandParent == nil {
			root = node
			node.parent = nil
		} else {
			
			if parent === grandParent!.leftChild {
				grandParent!.leftChild = node
			} else {
				grandParent!.rightChild = node
			}
			node.parent = grandParent
		}
		
		parent.leftChild = node.rightChild
		parent.leftChild?.parent = parent
		
		node.rightChild = parent
		parent.parent = node
	}
	
	private func rotateLeft(node: RBTNode<KeyT, ValueT>, parent: RBTNode<KeyT, ValueT>) {
		
		let grandParent = parent.parent
		
		// link up with grandParent
		if grandParent == nil {
			root = node
			node.parent = nil
		} else {
			
			if parent === grandParent!.leftChild {
				grandParent!.leftChild = node
			} else {
				grandParent!.rightChild = node
			}
			node.parent = grandParent
		}
		
		parent.rightChild = node.leftChild
		parent.rightChild?.parent = parent
		
		node.leftChild = parent
		parent.parent = node
	}
}

private class RBTNode<KeyT: Comparable, ValueT>: BSTNode<KeyT, ValueT> {
	
	var color: RBTNodeColor = .Red
	
	private func grandParent(node: RBTNode<KeyT, ValueT>) -> RBTNode<KeyT, ValueT>? {
		
		if node.parent != nil {
			return node.parent!.parent as? RBTNode<KeyT, ValueT>
		} else {
			return nil
		}
	}
	
	private func uncle(node: RBTNode<KeyT, ValueT>) -> RBTNode<KeyT, ValueT>? {
		
		guard let grandParent = grandParent(node) else {
			return nil
		}
		
		if node.parent === grandParent.leftChild {
			return grandParent.rightChild as? RBTNode<KeyT, ValueT>
		} else {
			return grandParent.leftChild as? RBTNode<KeyT, ValueT>
		}
	}
	
	override init(key: KeyT, value: ValueT) {
		
		super.init(key: key, value: value)
	}
}
