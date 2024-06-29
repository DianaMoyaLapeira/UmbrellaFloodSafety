//
//  MapViewSheet.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 28/6/24.
//

import SwiftUI

struct MapViewSheet: View {
    let minHeight: CGFloat = 100
    let snapHeight: CGFloat = 100
    let midHeight: CGFloat = 250
    let maxHeight: CGFloat = 600
    @State private var extraHeight = CGFloat.zero
    @State private var dragHeight = CGFloat.zero

    init() {
        _extraHeight = State(initialValue: snapHeight - minHeight)
    }

    var body: some View {
        VStack {
            Text("First Tab Content")
            Text("More Content in the Sheet")
            
        }
        .frame(maxWidth: .infinity, maxHeight: minHeight + extraHeight)
        .offset(y: -dragHeight / 2)
        .background {
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, topTrailing: 20))
                .padding(.bottom, -300)
                .foregroundStyle(.white)
                .offset(y: -dragHeight)
        }
        .overlay(alignment: .top) {
            Capsule()
                .frame(width: 36, height: 5)
                .foregroundStyle(.secondary)
                .padding(5)
                .offset(y: -dragHeight)
        }
        .animation(.easeInOut, value: extraHeight)
        .animation(.easeInOut, value: dragHeight)
        .gesture(
            DragGesture()
                .onChanged { val in
                    let dy = -val.translation.height
                    let minDragHeight = minHeight - (minHeight + extraHeight)
                    let maxDragHeight = maxHeight - (minHeight + extraHeight)
                    dragHeight = min(max(dy, minDragHeight), maxDragHeight)
                }
                .onEnded { _ in
                    let snapPoints: [CGFloat] = [snapHeight, midHeight, maxHeight]
                    let currentHeight = minHeight + extraHeight + dragHeight
                    let closestSnapPoint = snapPoints.min(by: { abs($0 - currentHeight) < abs($1 - currentHeight) }) ?? snapHeight
                    withAnimation(.easeInOut) {
                        extraHeight = closestSnapPoint - minHeight
                        dragHeight = 0
                    }
                }
        )
    }
}

#Preview {
    MapViewSheet()
}
