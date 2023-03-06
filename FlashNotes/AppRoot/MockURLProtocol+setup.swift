//
//  MockURLProtocol+Mock.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/03/06.
//

import Foundation

extension MockURLProtocol {
  static func setup() {
    setupGetNote()
    setupAddNote()
    setupGetPage()
    setupAddPage()
  }
}

// MARK: - Private

private extension MockURLProtocol {
  static func setupGetNote() {
    let response: [String: Any] = [
      "data": [
        [
          "id": "a62916bebffc46feb731905631c96236",
          "title": "컬처핏 면접"
        ],
        [
          "id": "b62a239dnfc46feb731905631c123932",
          "title": "기술 면접"
        ],
        [
          "id": "coa10dk298dj420jfa20fjsofj2029",
          "title": "네트워크"
        ],
        [
          "id": "d2401dkf02onnvud383ehbbn18301sf",
          "title": "컴퓨터 구조"
        ]
      ]
    ]
    setupSuccessMock("/api/v1/note", "GET", response)
  }

  static func setupAddNote() {
    let response: [String: Any] = [
      "data": [
        [
          "id": "a62916bebffc46feb731905631c96236"
        ],
      ]
    ]
    setupSuccessMock("/api/v1/note", "POST", response)
  }

  static func setupGetPage() {
    let response: [String: Any] = [
      "data": [
        [
          "id": "a62916bebffc46feb731905631c96236",
          "question": "동료와 의견 대립이 있다면 어떻게 해결할 것인가?"
        ],
        [
          "id": "b62a239dnfc46feb731905631c123932",
          "question": "같이 일하고 싶은 사람은 어떤 사람이고, 일하고 싶지 않은 사람은 어떤 사람인가요?"
        ],
        [
          "id": "coa10dk298dj420jfa20fjsofj2029",
          "question": "우리 회사에 지원했다가 떨어진 이력이 있는데, 그 때는 왜 떨어진 것 같으며, 다시 지원한 이유는 무엇입니까?"
        ],
        [
          "id": "d2401dkf02onnvud383ehbbn18301sf",
          "question": "회사에 궁금한 점이나 마지막으로 하고싶은 말이 있다면 자유롭게 해주세요."
        ]
      ]
    ]
    setupSuccessMock("/api/v1/page", "GET", response)
  }

  static func setupAddPage() {
    let response: [String: Any] = [
      "data": [
        [
          "id": "a62916bebffc46feb731905631c96236"
        ],
      ]
    ]
    setupSuccessMock("/api/v1/page", "POST", response)
  }

  static func setupSuccessMock(_ path: String, _ method: String, _ response: [String: Any]) {
    let request = MockRequest(path: path, method: method)
    let responseData = try! JSONSerialization.data(withJSONObject: response)
    successMock[request] = (200, responseData)
  }
}
