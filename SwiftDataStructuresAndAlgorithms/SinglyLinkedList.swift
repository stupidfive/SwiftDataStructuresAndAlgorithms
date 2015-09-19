//
//  SinglyLinkedList.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/18/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

public class SinglyLinkedList<ItemT>: CustomStringConvertible {
	
	private var head: SLLNode<ItemT>?
	private var size: Int = 0

	public func insertFront(item: ItemT) {
		
		head = SLLNode(item: item, next: head)
		size++
	}

	public func insertBack(item: ItemT) {

		var node = head
		if node == nil {
			insertFront(item)
			size++
			return
		}
		
		while node!.next != nil {
			node = node!.next
		}
		
		node!.next = SLLNode(item: item)
		size++
	}

	public func removeFront() {
		
		if head == nil {
			return
		}
		
		let newHead = head!.next
		head!.next = nil
		head = newHead!
		
		size--
	}

	public func removeBack() {
		
		var node = head
		if node == nil {
			return
		}
		
		var prevNode: SLLNode<ItemT>? = nil
		while node!.next != nil {
			prevNode = node!
			node = node!.next
		}
		
		prevNode!.next = nil
		
		size--
	}
	
	public var description: String {
		
		if head == nil {
			return "nil"
		} else {
			return "\(head!)"
		}
	}
}

public class SLLNode<ItemT>: CustomStringConvertible {
	
	private let item: ItemT
	private var next: SLLNode<ItemT>?
	
	private init(item: ItemT) {
		
		self.item = item
	}
	
	private init(item: ItemT, next: SLLNode<ItemT>?) {
		
		self.item = item
		self.next = next
	}
	
	public var description: String {

		if next == nil {
			return "\(item) -> nil"
		} else {
			return "\(item) -> \(next!)"
		}
	}
}