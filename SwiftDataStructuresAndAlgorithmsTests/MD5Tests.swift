//
//  MD5Tests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/18/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class MD5Tests: XCTestCase {

	func testMD5() {
		XCTAssertEqual(md5String(string: ""), "d41d8cd98f00b204e9800998ecf8427e")
		XCTAssertEqual(md5String(string: "a"), "0cc175b9c0f1b6a831c399e269772661")
		XCTAssertEqual(md5String(string: "abc"), "900150983cd24fb0d6963f7d28e17f72")
		XCTAssertEqual(md5String(string: "message digest"), "f96b697d7cb7938d525a2f31aaf161d0")
		XCTAssertEqual(md5String(string: "abcdefghijklmnopqrstuvwxyz"), "c3fcd3d76192e4007dfb496cca67e13b")
		XCTAssertEqual(md5String(string: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"), "d174ab98d277d9f5a5611c2c9f419d9f")
		XCTAssertEqual(md5String(string: "12345678901234567890123456789012345678901234567890123456789012345678901234567890"), "57edf4a22be3c955ac49da2e2107b67a")
		XCTAssertEqual(md5String(string: "The MD5 message-digest algorithm is a widely used cryptographic hash function producing a 128-bit (16-byte) hash value, typically expressed in text format as a 32 digit hexadecimal number. MD5 has been utilized in a wide variety of cryptographic applications, and is also commonly used to verify data integrity."), "f63872ef7bc97a8a8eadba6f0881de53")
	}

}
