//
//  RabbitView.swift
//  AnimationPractice
//
//  Created by 이주희 on 2023/01/23.
//

import SwiftUI

struct RabbitView: View {
    
    private var samplePath : Path {
        let width: CGFloat = 200
        let height: CGFloat = 100
        
        let startPoint = CGPoint(x: 0, y: height)
        let middlePoint = CGPoint(x: width / 2 , y: 0)
        let controlPoint1 = CGPoint(x: (startPoint.x + middlePoint.x) / 2, y: height)
        let controlPoint2 = CGPoint(x: (startPoint.x + middlePoint.x) / 2, y: 0)
        
        let endPoint = CGPoint(x: width , y: height)
        let controlPoint3 = CGPoint(x: (middlePoint.x + endPoint.x) / 2, y: 0)
        let controlPoint4 = CGPoint(x: (middlePoint.x + endPoint.x) / 2, y: height)
        
        var result = Path()
        result.move(to: startPoint)
        result.addCurve(to: middlePoint, control1: controlPoint1, control2: controlPoint2)
        result.addCurve(to: endPoint, control1: controlPoint3, control2: controlPoint4)
        return result
    }
    
    @State private var animating = false
    @State var alongTrackDistancePercent = CGFloat.zero
    var body: some View {
        VStack {
            ZStack {
//                samplePath.stroke(style: StrokeStyle(lineWidth: 3))
                
                Image("blackRabbit")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(x: 100, y: 100)
                    .position(samplePath
                        .trimmedPath(from: 0, to: alongTrackDistancePercent)
                        .currentPoint ?? CGPoint(x: 0, y: 0))
//                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) 
            }
            
            HStack(spacing: 300) {
                Text("A")
                Text("B")
            }
            
            Slider(value: $alongTrackDistancePercent)
        }
    }
}


struct RabbitView_Previews: PreviewProvider {
    static var previews: some View {
        RabbitView()
    }
}
