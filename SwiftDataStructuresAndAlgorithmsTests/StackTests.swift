//
//  StackTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class StackTests: XCTestCase {

	func testPopEmpty() {
		let stack = Stack<Int>()
		XCTAssert(stack.pop() == nil)
	}
	
	func testRandom() {
		let stack = Stack<Int>()
		stack.push(0)
		stack.push(1)
		stack.push(2)
		stack.pop()
		stack.pop()
		stack.push(3)
		stack.push(4)
		stack.pop()
		stack.push(5)
		
		print(stack)
		XCTAssertEqual(stack.description, "[0, 3, 5]")
	}

}
