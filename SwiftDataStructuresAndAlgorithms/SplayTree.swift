//
//  SplayTree.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/25/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

public class SplayTree<KeyT: Comparable, ValueT>: BinarySearchTree<KeyT, ValueT> {
	
	override public func find(key: KeyT) -> ValueT? {
		
		guard let node = findNode(key) else {
			return nil
		}
		
		splay(node)
		
		return node.value
	}
	
	override public func insert(key: KeyT, value: ValueT) {
		
		let node = BSTNode(key: key, value: value)
		
		insertNodeReplacingDuplicate(node)
		
		splay(node)
	}
	
	override public func delete(key: KeyT) -> Bool {
		// TODO: ~
		
		// case 1: node doesn't exist
		guard let node = findNode(key) else {
			return false
		}
		
		// case 2&3: node has zero or one child
		if node.leftChild == nil {
			transplant(node, withNode: node.rightChild)
		} else if node.rightChild == nil {
			transplant(node, withNode: node.leftChild)
		}
			// case 4: node has two children
		else {
			// find the left most child of the right subtree
			let replaceNode = node.rightChild!.leftMostChild()
			
			// replace node with replaceNode
			if (node !== replaceNode.parent) {		// steps can be omitted if node is the direct parent of replaceNode
				transplant(replaceNode, withNode: replaceNode.rightChild)
				replaceNode.rightChild = node.rightChild!
				replaceNode.rightChild!.parent = replaceNode
			}
			transplant(node, withNode: replaceNode)
			replaceNode.leftChild = node.leftChild!
			replaceNode.leftChild!.parent = replaceNode
		}
		
		size--
		
		return false
	}
	
	private func splay(node: BSTNode<KeyT, ValueT>) {
		
		while node !== root {
			
			let parent = node.parent!
			
			if parent === root {
				if node.key < parent.key {
					zigRight(node, parent: parent)
				} else {
					zigLeft(node, parent: parent)
				}
				continue
			}
			
			let grandParent = parent.parent!
			if node.key < parent.key && parent.key < grandParent.key {
				zigZigRight(node, parent: parent, grandParent: grandParent)
			} else if node.key > parent.key && parent.key > grandParent.key {
				zigZigLeft(node, parent: parent, grandParent: grandParent)
			} else if node.key < parent.key && parent.key > grandParent.key {
				zigZagLeft(node, parent: parent, grandParent: grandParent)
			} else if node.key > parent.key && parent.key < grandParent.key {
				zigZagRight(node, parent: parent, grandParent: grandParent)
			}
			continue
		}
		
	}
	
	private func zigLeft(node: BSTNode<KeyT, ValueT>, parent: BSTNode<KeyT, ValueT>) {
		
		root = node
		node.parent = nil
		
		parent.rightChild = node.leftChild
		parent.rightChild?.parent = parent
		
		node.leftChild = parent
		parent.parent = node
	}
	
	private func zigRight(node: BSTNode<KeyT, ValueT>, parent: BSTNode<KeyT, ValueT>) {
		
		root = node
		node.parent = nil
		
		parent.leftChild = node.rightChild
		parent.leftChild?.parent = parent
		
		node.rightChild = parent
		parent.parent = node
	}
	
	// perform before zig-zig or zig-zag
	private func linkUpGreatGrandParent(node: BSTNode<KeyT, ValueT>, parent: BSTNode<KeyT, ValueT>, grandParent: BSTNode<KeyT, ValueT>) {
		
		if grandParent === root {
			root = node
			node.parent = nil
		} else if let greatGrandParent = grandParent.parent {
			
			if node.key < greatGrandParent.key {
				greatGrandParent.leftChild = node
			} else {
				greatGrandParent.rightChild = node
			}
			node.parent = greatGrandParent
		}
	}
	
	private func zigZigLeft(node: BSTNode<KeyT, ValueT>, parent: BSTNode<KeyT, ValueT>, grandParent: BSTNode<KeyT, ValueT>) {
		
		linkUpGreatGrandParent(node, parent: parent, grandParent: grandParent)
		
		grandParent.rightChild = parent.leftChild
		grandParent.rightChild?.parent = grandParent
		
		parent.leftChild = grandParent
		grandParent.parent = parent
		
		parent.rightChild = node.leftChild
		parent.rightChild?.parent = parent
		
		node.leftChild = parent
		parent.parent = node
		
	}
	
	private func zigZigRight(node: BSTNode<KeyT, ValueT>, parent: BSTNode<KeyT, ValueT>, grandParent: BSTNode<KeyT, ValueT>) {
		
		linkUpGreatGrandParent(node, parent: parent, grandParent: grandParent)
		
		grandParent.leftChild = parent.rightChild
		grandParent.leftChild?.parent = grandParent
		
		parent.rightChild = grandParent
		grandParent.parent = parent
		
		parent.leftChild = node.rightChild
		parent.leftChild?.parent = parent
		
		node.rightChild = parent
		parent.parent = node
	}
	
	private func zigZagLeft(node: BSTNode<KeyT, ValueT>, parent: BSTNode<KeyT, ValueT>, grandParent: BSTNode<KeyT, ValueT>) {
		
		linkUpGreatGrandParent(node, parent: parent, grandParent: grandParent)
		
		parent.leftChild = node.rightChild
		parent.leftChild?.parent = parent
		
		node.rightChild = parent
		parent.parent = node
		
		grandParent.rightChild = node.leftChild
		grandParent.rightChild?.parent = grandParent
		
		node.leftChild = grandParent
		grandParent.parent = node
	}
	
	private func zigZagRight(node: BSTNode<KeyT, ValueT>, parent: BSTNode<KeyT, ValueT>, grandParent: BSTNode<KeyT, ValueT>) {
		
		linkUpGreatGrandParent(node, parent: parent, grandParent: grandParent)
		
		parent.rightChild = node.leftChild
		parent.rightChild?.parent = parent
		
		node.leftChild = parent
		parent.parent = node
		
		grandParent.leftChild = node.rightChild
		grandParent.leftChild?.parent = grandParent
		
		node.rightChild = grandParent
		grandParent.parent = node
	}
	
	public override init() {
		super.init()
	}
	
}
