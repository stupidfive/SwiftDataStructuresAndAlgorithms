//
//  DoublyLinkedList.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/19/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

public class DoublyLinkedList<ItemT>: CustomStringConvertible {
	
	private var head: DLLNode<ItemT>
	private var size = 0
	
	init() {
		
		head = DLLNode<ItemT>()
	}
	
	deinit {
		
		// free the pointer to avoid self-to-self retain cycle
		head.next = nil
		head.prev = nil
	}
	
	public func insertFront(item: ItemT) {
		
		let node = DLLNode<ItemT>(item: item)
		
		if size == 0 {
			
			head.next = node
			head.prev = node
			node.next = head
			node.prev = head
			
			size++
			
			return
		}
		
		head.next!.prev = node
		node.next = head.next
		head.next = node
		node.prev = head
		
		size++
		
	}
	
	public func insertBack(item: ItemT) {
		
		let node = DLLNode<ItemT>(item: item)
		
		if size == 0 {
			
			head.next = node
			head.prev = node
			node.next = head
			node.prev = head
			
			size++
			
			return
		}
		
		head.prev!.next = node
		node.prev = head.prev
		head.prev = node
		node.next = head
	}
	
	public func front() -> DLLNode<ItemT>? {
		
		if size == 0 {
			return nil
		}
		
		return head.next
	}
	
	public func back() -> DLLNode<ItemT>? {
		
		if size == 0 {
			return nil
		}
		
		return head.prev
	}
	
	public func insert(item item: ItemT, afterNode node: DLLNode<ItemT>) {
		
		// !!!: suppose node is in this list
		
		if size == 0 {
			return
		}
		
		let newNode = DLLNode<ItemT>(item: item)
		newNode.prev = node
		newNode.next = node.next
		node.next!.prev = newNode
		node.next = newNode
	}
	
	public func insert(item item: ItemT, beforeNode node: DLLNode<ItemT>) {
		
		// !!!: suppose node is in this list
		
		if size == 0 {
			return
		}
		
		let newNode = DLLNode<ItemT>(item: item)
		newNode.next = node
		newNode.prev = node.prev
		node.prev!.next = newNode
		node.prev = newNode
	}
	
	public func remove(node: DLLNode<ItemT>) {
		
		if size == 0 {
			
		} else if size == 1 && head.next === node {
			
			node.prev = nil
			node.next = nil
			head.next = head
			head.prev = head
			
		} else {
			
			// !!!: suppose node is in this list
			
			node.next!.prev = node.prev
			node.prev!.next = node.next
			node.next = nil
			node.prev = nil
		}
	}
	
	public var description: String {
		
		var desc = ""
		desc += "\(head) <-> "
		var node = head.next
		while node?.item != nil {
			desc +=  "\(node!.item!) <-> "
			node = node!.next
		}
		
		return desc
	}
}

public class DLLNode<ItemT>: NSObject {
	
	private var item: ItemT?
	private var next: DLLNode<ItemT>?
	private var prev: DLLNode<ItemT>?
	
	// init a sentinel
	override public init() {
		
		super.init()
		next = self
		prev = self
	}
	
	private init(item: ItemT) {
		
		self.item = item
	}
	
	private init(item: ItemT, next: DLLNode, prev: DLLNode) {
		
		self.item = item
		self.next = next
		self.prev = prev
	}
	
	override public var description: String {
		
		let desc = (item == nil) ? "#sentinel#" : "\(item)"
		return desc
	}
}