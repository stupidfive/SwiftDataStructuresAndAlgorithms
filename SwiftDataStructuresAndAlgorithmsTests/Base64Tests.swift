//
//  Base64Tests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/16/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class Base64Tests: XCTestCase {

	func testBase64Encode() {
		XCTAssert(Base64.base64EncodedString(string: "") == "")
		XCTAssert(Base64.base64EncodedString(string: "a") == "YQ==")
		XCTAssert(Base64.base64EncodedString(string: "abc") == "YWJj")
		XCTAssert(Base64.base64EncodedString(string: "Man") == "TWFu")
		XCTAssert(Base64.base64EncodedString(string: "base64") == "YmFzZTY0")
		XCTAssert(Base64.base64EncodedString(string: "This is a duck.") == "VGhpcyBpcyBhIGR1Y2su")
		XCTAssert(Base64.base64EncodedString(string: "Hello, World!") == "SGVsbG8sIFdvcmxkIQ==")
		XCTAssert(Base64.base64EncodedString(string: "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.") == "TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=")
	}
	
	func testBase64Decode() {
		
		XCTAssert(Base64.base64DecodedString(string: "") == "")
		XCTAssert(Base64.base64DecodedString(string: "YQ==") == "a")
		XCTAssert(Base64.base64DecodedString(string: "YWJj") == "abc")
		XCTAssert(Base64.base64DecodedString(string: "TWFu") == "Man")
		XCTAssert(Base64.base64DecodedString(string: "YmFzZTY0") == "base64")
		XCTAssert(Base64.base64DecodedString(string: "VGhpcyBpcyBhIGR1Y2su") == "This is a duck.")
		XCTAssert(Base64.base64DecodedString(string: "SGVsbG8sIFdvcmxkIQ==") == "Hello, World!")
		XCTAssert(Base64.base64DecodedString(string: "TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=") == "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.")
	}

}
