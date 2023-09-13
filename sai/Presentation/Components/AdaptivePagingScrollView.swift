//
//  AdaptivePagingScrollView.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI

struct AdaptivePagingScrollView: View {
    
    private let items: [AnyView]
    private let itemPadding: CGFloat
    private let itemSpacing: CGFloat
    private let itemScrollableSide: CGFloat
    private let itemsAmount: Int
    private let visibleContentLength: CGFloat
    
    private let initialOffset: CGFloat
    private let scrollDampingFactor: CGFloat = 0.66
    private let orientation: Orientation
    
    @Binding var currentPageIndex: Int
    
    @State private var currentScrollOffset: CGFloat = 0
    @State private var gestureDragOffset: CGFloat = 0
    
    @GestureState private var dragGestureActive: Bool = false
    
    private func countOffset(for pageIndex: Int) -> CGFloat {
        
        let activePageOffset = CGFloat(pageIndex) * (itemScrollableSide + itemPadding)
        
        return initialOffset - activePageOffset
    }
    
    private func countPageIndex(for offset: CGFloat) -> Int {
        
        guard itemsAmount > 0 else { return 0 }
        
        let offset = countLogicalOffset(offset)
        let floatIndex = (offset)/(itemScrollableSide + itemPadding)
        
        var index = Int(round(floatIndex))
        if max(index, 0) > itemsAmount {
            index = itemsAmount
        }
        
        return min(max(index, 0), itemsAmount - 1)
    }
    
    private func countCurrentScrollOffset() -> CGFloat {
        return countOffset(for: currentPageIndex) + gestureDragOffset
    }
    
    private func countLogicalOffset(_ trueOffset: CGFloat) -> CGFloat {
        return (trueOffset-initialOffset) * -1.0
    }
    
    private func changeFocus() {
        withAnimation {
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
    }
    
    init<A: View>(currentPageIndex: Binding<Int>,
                  itemsAmount: Int,
                  itemScrollableSide: CGFloat,
                  itemPadding: CGFloat,
                  visibleContentLength: CGFloat,
//                  orientation: Orientation,
                  @ViewBuilder content: () -> A) {
        
        let views = content()
        self.items = [AnyView(views)]
        
        self._currentPageIndex = currentPageIndex
        
        self.itemsAmount = itemsAmount
        self.itemSpacing = itemPadding
        self.itemScrollableSide = itemScrollableSide
        self.itemPadding = itemPadding
        self.visibleContentLength = visibleContentLength
        self.orientation = .horizontal
        
        let itemRemain = (visibleContentLength-itemScrollableSide-2*itemPadding)/2
        self.initialOffset = itemRemain + itemPadding
    }
    
    @ViewBuilder
    func contentView() -> some View {
        switch orientation {
        case .horizontal:
            HStack(alignment: .center, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(width: itemScrollableSide)
                }
            }
        case .vertical:
            VStack(alignment: .leading, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(height: itemScrollableSide)
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            contentView()
        }
        .onAppear {
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
        .background(Color.black.opacity(0.00001)) // hack - this allows gesture recognizing even when background is transparent
        .frameModifier(visibleContentLength, currentScrollOffset, orientation)
        .highPriorityGesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .local)
                .updating($dragGestureActive) { value, state, transaction in
                    state = true
                }
                .onChanged { value in
                    switch orientation {
                    case .horizontal:
                        gestureDragOffset = value.translation.width
                    case .vertical:
                        gestureDragOffset = value.translation.height
                    }
                    currentScrollOffset = countCurrentScrollOffset()
                }
                .onEnded { value in
                    print("OnEnded")
                    let cleanOffset: CGFloat
                    switch orientation {
                    case .horizontal:
                        cleanOffset = (value.predictedEndTranslation.width - gestureDragOffset)
                    case .vertical:
                        cleanOffset = (value.predictedEndTranslation.height - gestureDragOffset)
                    }
                    let velocityDiff = cleanOffset * scrollDampingFactor
                    
                    var newPageIndex = countPageIndex(for: currentScrollOffset + velocityDiff)
                    
                    let currentItemOffset = CGFloat(currentPageIndex) * (itemScrollableSide + itemPadding)
                    
                    if currentScrollOffset < -(currentItemOffset),
                       newPageIndex == currentPageIndex {
                        newPageIndex += 1
                    }
                    
                    gestureDragOffset = 0
                    
                    withAnimation(.interpolatingSpring(mass: 0.1,
                                                       stiffness: 20,
                                                       damping: 1.5,
                                                       initialVelocity: 0)) {
                        self.currentPageIndex = newPageIndex
                    }
                }
        )
        .contentShape(Rectangle())
        .onChange(of: currentPageIndex, perform: { _ in changeFocus() })
        .onChange(of: dragGestureActive) { newValue in
            // This is a hack to prevent animation stuck when ScrollView cancel this DragGesture
            if(newValue == false) {
                gestureDragOffset = 0
                withAnimation(.interpolatingSpring(mass: 0.1,
                                                   stiffness: 20,
                                                   damping: 1.5,
                                                   initialVelocity: 0)) {
                    self.currentScrollOffset = self.countCurrentScrollOffset()
                }
            }
        }
    }
}



fileprivate struct FrameModifier: ViewModifier {
    let contentLength: CGFloat
    let currentScrollOffset: CGFloat
    let orientation: Orientation

    init (contentLength: CGFloat,
          visibleContentLength: CGFloat,
          currentScrollOffset: CGFloat,
          orientation: Orientation) {
        self.contentLength = contentLength
        self.currentScrollOffset = currentScrollOffset
        self.orientation = orientation
    }

    func body(content: Content) -> some View {
        switch orientation {
        case .horizontal:
            let offset = contentLength / 2
            return content
                .frame(width: contentLength)
                .offset(x: self.currentScrollOffset + offset, y: 0)
        case .vertical:
            return content
                .frame(height: contentLength)
                .offset(x: 0, y: self.currentScrollOffset)
        }
    }
}

fileprivate extension View {
    func frameModifier(_ contentLength: CGFloat,
                       _ currentScrollOffset: CGFloat,
                       _ orientation: Orientation) -> some View {
        modifier(
            FrameModifier(
                contentLength: contentLength,
                visibleContentLength: contentLength,
                currentScrollOffset: currentScrollOffset,
                orientation: orientation
            )
        )
    }
}

fileprivate enum Orientation {
    case horizontal, vertical
}
