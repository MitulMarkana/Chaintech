//
//  CryptoHelper.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import Foundation
import CommonCrypto

class CryptoManager {
    private let key: Data

    init() {
        let keyString = "ghbbAsjjsjkjkjW234"
        guard let keyData = keyString.data(using: .utf8) else {
            fatalError("Failed to convert key string to data.")
        }
        self.key = keyData
    }

    func encrypt(_ plaintext: String) -> String? {
        guard let data = plaintext.data(using: .utf8) else { return nil }
        let encryptedData = NSMutableData(length: Int(data.count) + kCCBlockSizeAES128)!
        let keyLength = size_t(kCCKeySizeAES256)

        let options: CCOptions = CCOptions(kCCOptionPKCS7Padding)
        var numBytesEncrypted: size_t = 0

        let cryptStatus = key.withUnsafeBytes { keyBytes in
            CCCrypt(
                CCOperation(kCCEncrypt),
                CCAlgorithm(kCCAlgorithmAES),
                options,
                keyBytes.baseAddress,
                keyLength,
                nil,
                (data as NSData).bytes,
                data.count,
                encryptedData.mutableBytes,
                encryptedData.length,
                &numBytesEncrypted
            )
        }

        guard cryptStatus == CCCryptorStatus(kCCSuccess) else {
            print("Encryption error: \(cryptStatus)")
            return nil
        }

        encryptedData.length = Int(numBytesEncrypted)
        return encryptedData.base64EncodedString(options: .lineLength64Characters)
    }

    func decrypt(_ encryptedText: String) -> String? {
        guard let data = Data(base64Encoded: encryptedText) else {
            print("Base64 decoding failed.")
            return nil
        }

        let decryptedData = NSMutableData(length: data.count + kCCBlockSizeAES128)!
        let keyLength = size_t(kCCKeySizeAES256)

        let options: CCOptions = CCOptions(kCCOptionPKCS7Padding)
        var numBytesDecrypted: size_t = 0

        let cryptStatus = key.withUnsafeBytes { keyBytes in
            CCCrypt(
                CCOperation(kCCDecrypt),
                CCAlgorithm(kCCAlgorithmAES),
                options,
                keyBytes.baseAddress,
                keyLength,
                nil,
                (data as NSData).bytes,
                data.count,
                decryptedData.mutableBytes,
                decryptedData.length,
                &numBytesDecrypted
            )
        }

        guard cryptStatus == CCCryptorStatus(kCCSuccess) else {
            print("Decryption failed with status: \(cryptStatus)")
            return nil
        }

        decryptedData.length = Int(numBytesDecrypted)

        if let decryptedString = String(data: decryptedData as Data, encoding: .utf8) {
            return decryptedString
        } else {
            return nil
        }
    }
}
