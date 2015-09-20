//
//  DoublyLinkedListTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/19/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class DoublyLinkedListTests: XCTestCase {

	func testInsertBack() {
		let dll = DoublyLinkedList<Int>()
		dll.insertBack(0)
		dll.insertBack(1)
		dll.insertBack(2)
		dll.insertBack(3)
		dll.insertBack(4)
		
		XCTAssertEqual(dll.description, "#sentinel# <-> 0 <-> 1 <-> 2 <-> 3 <-> 4 <-> ")
	}
	
	func testInsertFront() {
		let dll = DoublyLinkedList<Int>()
		dll.insertFront(0)
		dll.insertFront(1)
		dll.insertFront(2)
		dll.insertFront(3)
		dll.insertFront(4)
		
		XCTAssertEqual(dll.description, "#sentinel# <-> 4 <-> 3 <-> 2 <-> 1 <-> 0 <-> ")
	}

}
