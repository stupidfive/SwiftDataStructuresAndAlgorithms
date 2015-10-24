//
//  SHA1Tests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class SHA1Tests: XCTestCase {

	func testSHA1() {
		print(sha1String(string: "message digest"))
		
		XCTAssertEqual(sha1String(string: ""), "da39a3ee5e6b4b0d3255bfef95601890afd80709")
		XCTAssertEqual(sha1String(string: "a"), "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8")
		XCTAssertEqual(sha1String(string: "abc"), "a9993e364706816aba3e25717850c26c9cd0d89d")
		XCTAssertEqual(sha1String(string: "message digest"), "c12252ceda8be8994d5fa0290a47231c1d16aae3")
		XCTAssertEqual(sha1String(string: "abcdefghijklmnopqrstuvwxyz"), "32d10c7b8cf96570ca04ce37f2a19d84240d3a89")
		XCTAssertEqual(sha1String(string: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"), "761c457bf73b14d27e9e9265c46f4b4dda11f940")
		XCTAssertEqual(sha1String(string: "12345678901234567890123456789012345678901234567890123456789012345678901234567890"), "50abf5706a150990a08b2c5ea40fa0e585554732")
		XCTAssertEqual(sha1String(string: "SHA-1 is a member of the Secure Hash Algorithm family. The four SHA algorithms are structured differently and are named SHA-0, SHA-1, SHA-2, and SHA-3. SHA-0 is the original version of the 160-bit hash function published in 1993 under the name SHA: it was not adopted by many applications. Published in 1995, SHA-1 is very similar to SHA-0, but alters the original SHA hash specification to correct weaknesses that were unknown to the public at that time. SHA-2, published in 2001, is significantly different from the SHA-1 hash function."), "8ea059cbebc9a733c6a9e9c939296a98810d9ffc")
	}

}
