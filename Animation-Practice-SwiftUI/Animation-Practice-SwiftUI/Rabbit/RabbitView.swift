//
//  RabbitView.swift
//  Animation-Practice-SwiftUI
//
//  Created by 이주희 on 2023/01/24.
//

import SwiftUI

fileprivate let W = UIScreen.main.bounds.width
fileprivate let H = UIScreen.main.bounds.height

fileprivate let p1 = CGPoint(x: 0 , y: H / 2 )
fileprivate let p2 = CGPoint(x: (W)/2  , y: H / 2)
fileprivate let p3 = CGPoint(x: W  , y: H / 2)

//path
fileprivate var samplePath : Path {
    let c1 = CGPoint(x: (p1.x + p2.x) / 2, y: p1.y)
    let c2 = CGPoint(x: (p1.x + p2.x) / 2, y: 0)
    let c3 = CGPoint(x: (p2.x + p3.x) / 2, y: 0)
    let c4 = CGPoint(x: (p2.x + p3.x) / 2, y: p1.y)

    var result = Path()
    result.move(to: p1)
    result.addCurve(to: p2, control1: c1, control2: c2)
    result.addCurve(to: p3, control1: c3, control2: c4)
    return result
}

struct RabbitView: View {
        let path    : Path
        let start   : CGPoint
        let duration: Double = 1

        @State var isMovingForward = false
        // 시간값
        var tMax : CGFloat { isMovingForward ? 1 : 0 }

        var body: some View {
            VStack {
                Image("blackRabbit")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                .modifier(Moving(time: tMax, path: path, start: start))
                .animation(.spring(dampingFraction: 3, blendDuration: duration ), value: tMax)
            }
            .onAppear{
                isMovingForward = true

                // 디스패치 큐를 활용해 두번 점프 구현.
                DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.1) {
                    isMovingForward = false
                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + duration + 1.2) {
//                    isMovingForward = true
//                }

                // Sneak back to p1. This is a code smell.
                DispatchQueue.main.asyncAfter(deadline: .now() + duration + 2.2) {
                    isMovingForward = false
                }
            }
        }
}

struct Moving: ViewModifier, Animatable {
    var time : CGFloat  // Normalized from 0...1.
    let path : Path
    let start: CGPoint  // Could derive from path.

    //변하는 값
    var animatableData: CGFloat {
        get { time }
        set { time = newValue }
    }
    //그 변화로 그려지는 값
    func body(content: Content) -> some View {
        content
        .position(
            path.trimmedPath(from: 0, to: time).currentPoint ?? start
        )
    }
}

struct RabbitView_Previews: PreviewProvider {
    static var previews: some View {
        RabbitView(path: samplePath, start: p1)
    }
}
