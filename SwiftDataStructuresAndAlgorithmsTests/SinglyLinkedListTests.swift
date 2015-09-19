//
//  SinglyLinkedListTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/18/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class SinglyLinkedListTests: XCTestCase {
	
	let settedList = SinglyLinkedList<Int>()
	
	override func setUp() {
		super.setUp()
		
		let array = [0, 1, 2, 3, 4]
		for n in array {
			settedList.insertBack(n)
		}
	}
	
	func testSetUp() {
		XCTAssertEqual(settedList.description, "0 -> 1 -> 2 -> 3 -> 4 -> nil")
	}

	func testInsertFront() {
		let sll = SinglyLinkedList<Int>()
		sll.insertFront(0)
		sll.insertFront(1)
		sll.insertFront(2)
		sll.insertFront(3)
		sll.insertFront(4)
		
		print(sll)
		XCTAssertEqual(sll.description, "4 -> 3 -> 2 -> 1 -> 0 -> nil")
	}
	
	func testInsertBack() {
		let sll = SinglyLinkedList<Int>()
		sll.insertBack(0)
		sll.insertBack(1)
		sll.insertBack(2)
		sll.insertBack(3)
		sll.insertBack(4)
		
		print(sll)
		XCTAssertEqual(sll.description, "0 -> 1 -> 2 -> 3 -> 4 -> nil")
	}
	
	func testRemoveFront() {
		
		settedList.removeFront()
		settedList.removeFront()
		XCTAssertEqual(settedList.description, "2 -> 3 -> 4 -> nil")
	}
	
	func testRemoveBack() {
		
		settedList.removeBack()
		settedList.removeBack()
		XCTAssertEqual(settedList.description, "0 -> 1 -> 2 -> nil")
	}
}
