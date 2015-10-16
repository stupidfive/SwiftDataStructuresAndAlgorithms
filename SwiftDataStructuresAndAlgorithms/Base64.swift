//
//  Base64.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/16/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

/*
Example:
+------------------+---------------+---------------+---------------+
|   Text content   |       M       |       a       |       n       |
+------------------+---------------+---------------+---------------+
|      ASCII       |      77       |      97       |      110      |
+------------------+-----------+---+-------+-------+---+-----------+
|   Bit pattern    |0 1 0 0 1 1|0 1|0 1 1 0|0 0 0 1|0 1|1 0 1 1 1 0|
+------------------+-----------+---+-------+-------+---+-----------+
|      Index       |    19     |    22     |     5     |    46     |
+------------------+-----------+-----------+-----------+-----------+
|  Base64-encoded  |     T     |     W     |     F     |     u     |
+------------------+-----------+-----------+-----------+-----------+
*/

let code: [UInt8] = [0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f,0x50,0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5a,0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6a,0x6b,0x6c,0x6d,0x6e,0x6f,0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7a,0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x2b,0x2f,0x3d]	// ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=

public class Base64 {
	
	// MARK: - base64 encode
	
	public class func base64Encode(string string: String) -> NSData {
		
		let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
		
		return base64Encode(data: data)
	}
	
	public class func base64EncodedString(data data: NSData) -> String {
		
		let encodedData = base64Encode(data: data)
		
		return String(data: encodedData, encoding: NSUTF8StringEncoding)!
	}
	
	public class func base64EncodedString(string string: String) -> String {
		
		let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
		let encodedData = base64Encode(data: data)
		
		return String(data: encodedData, encoding: NSUTF8StringEncoding)!
	}
	
	public class func base64Encode(data data: NSData) -> NSData {
		
		var inputBuffer: [UInt8]
		var outputBuffer: [UInt8]
		
		var codeIdxArray = [UInt8]()
		
		let residual = data.length % 3
		
		for var i = 0; i < data.length; i += 3 {
			
			inputBuffer = [UInt8](count: 3, repeatedValue: 0)
			outputBuffer = [UInt8](count: 4, repeatedValue: 0)
			
			if i + 2 < data.length {
				
				// load input buffer
				for offset in 0..<3 {
					data.getBytes(&inputBuffer[offset], range: NSRange(location: i + offset, length: 1))
				}
				
				// encoding
				outputBuffer[0] = (inputBuffer[0] & 0xfc) >> 2
				outputBuffer[1] = ((inputBuffer[0] & 0x3) << 4) | ((inputBuffer[1] & 0xf0) >> 4)
				outputBuffer[2] = ((inputBuffer[1] & 0xf) << 2) | ((inputBuffer[2] & 0xc0) >> 6)
				outputBuffer[3] = (inputBuffer[2] & 0x3f)
			} else {
				
				switch residual {
				case 1:
					
					// load input buffer
					for offset in 0..<1 {
						data.getBytes(&inputBuffer[offset], range: NSRange(location: i + offset, length: 1))
					}
					
					// encoding
					outputBuffer[0] = (inputBuffer[0] & 0xfc) >> 2
					outputBuffer[1] = ((inputBuffer[0] & 0x3) << 4) | ((inputBuffer[1] & 0xf0) >> 4)
					outputBuffer[2] = 64	// '='
					outputBuffer[3] = 64	// '='
				case 2:
					
					// load input buffer
					for offset in 0..<2 {
						data.getBytes(&inputBuffer[offset], range: NSRange(location: i + offset, length: 1))
					}
					
					// encoding
					outputBuffer[0] = (inputBuffer[0] & 0xfc) >> 2
					outputBuffer[1] = ((inputBuffer[0] & 0x3) << 4) | ((inputBuffer[1] & 0xf0) >> 4)
					outputBuffer[2] = ((inputBuffer[1] & 0xf) << 2) | ((inputBuffer[2] & 0xc0) >> 6)
					outputBuffer[3] = 64	// '='
				default:
					break
				}
			}
			
			// unload output buffer to codeIdxArray
			for n in outputBuffer {
				codeIdxArray.append(n)
			}
		}
		
		let encodedData = NSMutableData()
		for idx in codeIdxArray {
			var c = code[Int(idx)]	// reassign to a var s.t. passing its pointer is possible
			encodedData.appendBytes(&c, length: 1)
		}
		
		return encodedData
	}
	
	// MARK: - base64 decode
	
	public class func base64Decode(string string: String) -> NSData {
		
		let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
		
		return base64Decode(data: data)
	}
	
	public class func base64DecodedString(data data: NSData) -> String {
		
		let decodedData = base64Decode(data: data)
		
		return String(data: decodedData, encoding: NSUTF8StringEncoding)!
	}
	
	public class func base64DecodedString(string string: String) -> String {
		
		let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
		let decodedData = base64Decode(data: data)
		
		return String(data: decodedData, encoding: NSUTF8StringEncoding)!
	}
	
	public class func base64Decode(data data: NSData) -> NSData {
		
		if data.length == 0 {
			return NSData()
		}
		
		var inputBuffer: [UInt8]
		var outputBuffer: [UInt8]
		
		var decodeArray = [UInt8]()
		
		let residual = data.length % 4
		assert(residual == 0, "Invalid base64 input - char length must be multipal of 4.")
		
		for var i = 0; i < data.length; i += 4 {
			
			inputBuffer = [UInt8](count: 4, repeatedValue: 0)
			outputBuffer = [UInt8](count: 3, repeatedValue: 0)
			
			// load input buffer
			for offset in 0..<4 {
				var c: UInt8 = 0
				data.getBytes(&c, range: NSRange(location: i + offset, length: 1))
				inputBuffer[offset] = indexOfCode(c)
			}
			
			// encoding
			outputBuffer[0] = (inputBuffer[0] << 2) | ((inputBuffer[1] & 0x30) >> 4)
			outputBuffer[1] = (inputBuffer[1] & 0xf) << 4 | (inputBuffer[2] & 0x3c) >> 2
			outputBuffer[2] = (inputBuffer[2] & 0x3) << 6 | inputBuffer[3]
			
			// unload output buffer into decodedArray
			for n in outputBuffer {
				decodeArray.append(n)
			}
		}
		
		let decodedData = NSMutableData()
		
		// remove trailing nils(i.e. '\0's)
		var trailingNils = 0
		if decodeArray.last == 0 {
			trailingNils++
			if decodeArray[decodeArray.count - 2] == 0 {
				trailingNils++
			}
		}
		
		for i in 0..<decodeArray.count - trailingNils {
			decodedData.appendBytes(&decodeArray[i], length: 1)
		}
		
		return decodedData
	}
	
	private class func indexOfCode(c: UInt8) -> UInt8 {
		
		if c == 0x3d {
			return 0
		}
		for i in 0..<code.count {
			if c == code[i] {
				return UInt8(i)
			}
		}
		fatalError("Illegal base64 string input.")
	}
}
