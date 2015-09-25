//
//  BinarySearchTree.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

public class BinarySearchTree<KeyT: Comparable, ValueT>: CustomStringConvertible {
	
	var root: BSTNode<KeyT, ValueT>?
	var size: Int = 0
	
	// MARK: - main operations
	
	public func find(key: KeyT) -> ValueT? {
		
		guard let node = findNode(key) else {
			return nil
		}
		
		return node.value
	}
	
	public func insert(key: KeyT, value: ValueT) {
		
		let node = BSTNode(key: key, value: value)
		
		insertNode(node)
	}
	
	public func delete(key: KeyT) -> Bool {
		
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
	
	// MARK: - private
	
	func findNode(key: KeyT) -> BSTNode<KeyT, ValueT>? {
		
		var node = root
		
		while node != nil && node!.key != key {
			if key < node!.key {
				node = node!.leftChild
			} else {
				node = node!.rightChild
			}
		}
		return node
	}
	
	func insertNode(node: BSTNode<KeyT, ValueT>) {
		
		// set node as root if the tree is empty
		if root == nil {
			root = node
			size++
			return
		}
		
		// iteratively search for insertion location
		var currentNode = root
		var prevNode: BSTNode<KeyT, ValueT>? = nil
		while currentNode != nil {
			prevNode = currentNode
			if node.key < currentNode!.key {
				currentNode = currentNode!.leftChild
			} else {
				currentNode = currentNode!.rightChild
			}
		}
		
		// link node with its parent
		node.parent = prevNode
		if prevNode == nil {
			root = node
		} else if node.key < prevNode!.key {
			prevNode!.leftChild = node
		} else {
			prevNode!.rightChild = node
		}
		
		size++
	}
	
	func insertNodeReplacingDuplicate(node: BSTNode<KeyT, ValueT>) {
		
		// set node as root if the tree is empty
		if root == nil {
			root = node
			size++
			return
		}
		
		// iteratively search for insertion location
		var currentNode = root
		var prevNode: BSTNode<KeyT, ValueT>? = nil
		while currentNode != nil {
			if node.key == currentNode!.key {		// node with same key
				size--		// nice work around
				break;
			} else {
				
				prevNode = currentNode
				if node.key < currentNode!.key {
					currentNode = currentNode!.leftChild
				} else {
					currentNode = currentNode!.rightChild
				}
			}
		}
		
		// establish link with its parent
		node.parent = prevNode
		if prevNode == nil {
			root = node
		} else if node.key < prevNode!.key {
			prevNode!.leftChild = node
		} else {
			prevNode!.rightChild = node
		}
		
		size++
	}
	
	// oldNode can't be nil
	// newNode can be nil
	func transplant(oldNode: BSTNode<KeyT, ValueT>, withNode newNode: BSTNode<KeyT, ValueT>?) {
		
		// oldNode is the root
		if oldNode.parent == nil {		// oldNode is the root
			root = newNode
		}
			// oldNote is the leftChild of its parent
		else if (oldNode === oldNode.parent!.leftChild) {
			oldNode.parent!.leftChild = newNode
		}
			// oldNote is the rightChild of its parent
		else {
			oldNode.parent!.rightChild = newNode
		}
		
		if newNode != nil {
			newNode!.parent = oldNode.parent
		}
		
	}
	
	// MARK: - CustomStringConvertible
	
	public var description: String {
		var desc = "structure = \(structureDescription)"
		desc += "\n"
		desc += "root = \(root?.key) : \(root?.value)"
		desc += "\n"
		desc += "size = \(size)"
		
		return desc
	}
	
	// A simple structural for the BST that only prints keys.
	public var structureDescription: String {
		let desc: String
		if root == nil {
			desc = "nil"
		} else {
			desc = "\(root!)"
		}
		return desc
	}
}

// MARK: - trivial methods
extension BinarySearchTree {
	
	public func max() -> ValueT? {
		if root == nil {
			return nil
		}
		let maxNode = root!.rightMostChild()
		return maxNode.value
	}
	
	public func min() -> ValueT? {
		if root == nil {
			return nil
		}
		let minNode = root!.leftMostChild()
		return minNode.value
	}
}

// MARK: - invariance check
extension BinarySearchTree {
	
	func invarianceParentChildRelation(node: BSTNode<KeyT, ValueT>?) -> Bool {
		
		if node == nil {
			return true
		}
		
		// check invariance of this node
		if node!.leftChild != nil && node!.leftChild!.parent !== node {
			print("Invariance violated: parent-child relationship. On node: \(node)")
			return false
		}
		if node!.rightChild != nil && node!.rightChild!.parent !== node {
			print("Invariance violated: parent-child relationship. On node: \(node)")
			return false
		}
		
		// recursively check invariance of subtree nodes
		return invarianceParentChildRelation(node!.leftChild) && invarianceParentChildRelation(node!.rightChild)
	}
}
