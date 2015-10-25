//
//  SelectionTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/25/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class SelectionTests: XCTestCase {

	var emptyArray = [Int]()
	var constantArray = [Int]()
	var inOrderArray = [Int]()
	var reverseArray = [Int]()
	var randomArray = [Int]()
	var largeRandomArray = [Int]()
	var doubleArray = [Double]()
	var stringArray = [String]()
	
	override func setUp() {
		super.setUp()
		
		emptyArray = [Int]()
		constantArray = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
		inOrderArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
		reverseArray = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
		randomArray = [3, 7, 1, 4, 8, 9, 0, 6, 2, 5]
		largeRandomArray = [993, 919, 942, 783, 935, 423, 178, 265, 644, 356, 313, 672, 673, 665, 403, 900, 662, 309, 771, 880, 613, 190, 498, 717, 330, 180, 688, 812, 512, 98, 547, 309, 777, 703, 611, 955, 26, 215, 366, 474, 240, 23, 497, 865, 920, 367, 474, 676, 771, 545, 896, 186, 149, 667, 335, 992, 680, 957, 137, 471, 656, 139, 358, 558, 939, 439, 718, 43, 178, 418, 368, 898, 244, 944, 948, 461, 185, 472, 958, 217, 901, 398, 229, 157, 19, 793, 271, 334, 876, 866, 629, 800, 765, 56, 961, 15, 852, 91, 0, 812]
		doubleArray = [0.899117565, 0.866922874, 0.319602986, 0.845051139, 0.953605696, 0.935600889, 0.854063404, 0.665763079, 0.122595366, 0.37686135, 0.279104127, 0.377624554, 0.660458037, 0.850192551, 0.452366566, 0.061786321, 0.689975451, 0.62726638, 0.7776788, 0.839706988, 0.337302959, 0.612019686, 0.973551169, 0.30363874, 0.824884116, 0.954380845, 0.37672205, 0.427171755, 0.301403013, 0.491170399, 0.885761404, 0.871826238, 0.305972041, 0.262109799, 0.66197136, 0.491389614, 0.315855243, 0.116670408, 0.245614466, 0.896411612, 0.22087872, 0.195778034, 0.964428055, 0.494119573, 0.939329763, 0.823003819, 0.196063457, 0.397913015, 0.034866514, 0.726124761, 0.492514, 0.89586558, 0.369979095, 0.651580107, 0.332031265, 0.747171172, 0.822867687, 0.906252875, 0.86475887, 0.929189172, 0.355566495, 0.392705987, 0.027131081, 0.649206287, 0.590794439, 0.239460627, 0.581349385, 0.401565917, 0.908752416, 0.15804305, 0.45427078, 0.425344088, 0.39324286, 0.10037434, 0.152404581, 0.782562921, 0.425886986, 0.508685169, 0.801464539, 0.085609506, 0.793599303, 0.525766794, 0.053407875, 0.230773469, 0.796721277, 0.1546829, 0.574023712, 0.279868727, 0.423105741, 0.040405183, 0.942317112, 0.042483665, 0.626688467, 0.298170368, 0.797361332, 0.959519986, 0.243210402, 0.152456386, 0.560795918, 0.548969483]
		
		stringArray = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m"]
	}
	
	func testLargest() {
		
		XCTAssert(Selection.largestItem(&emptyArray) == nil)
		XCTAssert(Selection.largestItem(&constantArray) == 5)
		XCTAssert(Selection.largestItem(&inOrderArray) == 9)
		XCTAssert(Selection.largestItem(&reverseArray) == 9)
		XCTAssert(Selection.largestItem(&randomArray) == 9)
		XCTAssert(Selection.largestItem(&largeRandomArray) == 993)
		XCTAssert(Selection.largestItem(&doubleArray) > 0.97)
		XCTAssert(Selection.largestItem(&stringArray) == "z")
	}
	
	func testSmallest() {
		
		XCTAssert(Selection.smallestItem(&emptyArray) == nil)
		XCTAssert(Selection.smallestItem(&constantArray) == 5)
		XCTAssert(Selection.smallestItem(&inOrderArray) == 0)
		XCTAssert(Selection.smallestItem(&reverseArray) == 0)
		XCTAssert(Selection.smallestItem(&randomArray) == 0)
		XCTAssert(Selection.smallestItem(&largeRandomArray) == 0)
		XCTAssert(Selection.smallestItem(&doubleArray) < 0.03)
		XCTAssert(Selection.smallestItem(&stringArray) == "a")
	}
	
	func testMedian() {
		
		XCTAssert(Selection.medianItem(&emptyArray) == nil)
		XCTAssert(Selection.medianItem(&constantArray) == 5)
		XCTAssert(Selection.medianItem(&inOrderArray) == 4)
		XCTAssert(Selection.medianItem(&reverseArray) == 4)
		XCTAssert(Selection.medianItem(&randomArray) == 4)
		XCTAssert(Selection.medianItem(&largeRandomArray) == 512)
		XCTAssert(Selection.medianItem(&doubleArray) < 0.5)
		XCTAssert(Selection.medianItem(&doubleArray) > 0.49)
		XCTAssert(Selection.medianItem(&stringArray) == "m")
	}
	
	func testQuickSelect() {
		
		XCTAssert(Selection.quickSelect(&emptyArray, order: 3) == nil)
		XCTAssert(Selection.quickSelect(&constantArray, order: 3) == 5)
		XCTAssert(Selection.quickSelect(&inOrderArray, order: 3) == 2)
		XCTAssert(Selection.quickSelect(&reverseArray, order: 3) == 2)
		XCTAssert(Selection.quickSelect(&randomArray, order: 3) == 2)
		XCTAssert(Selection.quickSelect(&largeRandomArray, order: 3) == 19)
		XCTAssert(Selection.quickSelect(&doubleArray, order: 3) < 0.041)
		XCTAssert(Selection.quickSelect(&doubleArray, order: 3) > 0.04)
		XCTAssert(Selection.quickSelect(&stringArray, order: 3) == "c")
		
		XCTAssert(Selection.quickSelect(&emptyArray, order: 10) == nil)
		XCTAssert(Selection.quickSelect(&constantArray, order: 10) == 5)
		XCTAssert(Selection.quickSelect(&inOrderArray, order: 10) == 9)
		XCTAssert(Selection.quickSelect(&reverseArray, order: 10) == 9)
		XCTAssert(Selection.quickSelect(&randomArray, order: 10) == 9)
		XCTAssert(Selection.quickSelect(&largeRandomArray, order: 10) == 137)
		XCTAssert(Selection.quickSelect(&doubleArray, order: 10) < 0.123)
		XCTAssert(Selection.quickSelect(&doubleArray, order: 10) > 0.122)
		XCTAssert(Selection.quickSelect(&stringArray, order: 10) == "j")
		
		XCTAssert(Selection.quickSelect(&largeRandomArray, order: 97) == 958)
		XCTAssert(Selection.quickSelect(&doubleArray, order: 97) < 0.955)
		XCTAssert(Selection.quickSelect(&doubleArray, order: 97) > 0.954)
		XCTAssert(Selection.quickSelect(&stringArray, order: 24) == "x")
	}

}
