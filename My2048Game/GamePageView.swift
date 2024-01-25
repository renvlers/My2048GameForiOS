//
//  GamePageView.swift
//  My2048Game
//
//  Created by Renvle RS on 1/25/24.
//

import SwiftUI

struct GamePageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var game: Game = Game(gameMode: .classicMode)
    @State var isTriggered: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
                .frame(height: 16)
            
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 0) {
                    Text("目标方块")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    ZStack() {
                        if self.game.getDisplayMessage(value: 2048) == "PRC" {
                            Image("PRC")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        } else {
                            Text(self.game.getDisplayMessage(value: 2048))
                                .font(.system(size: 26))
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .frame(width: 75, height: 75)
                                .background(self.game.getColor(value: 2048))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                .padding(12)
                .frame(width: 156, height: 156)
                .background(Color(red: 0xf1/0xff, green: 0xda/0xff, blue: 0xb0/0xff))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Spacer()
                    .frame(width: 6)
                
                VStack(alignment: .center) {
                    Text("已用时间")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    Text(self.game.time.getString())
                        .font(.system(size: 26))
                        .frame(maxHeight: .infinity)
                }
                .padding(12)
                .frame(width: 156, height: 156)
                .background(Color(red: 0xf1/0xff, green: 0xda/0xff, blue: 0xb0/0xff))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .frame(width: 330, height: 165)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
            Spacer()
                .frame(height: 32)
            
            ZStack() {
                VStack(alignment: .center, spacing: 6) {
                    ForEach(0..<4) {
                        row in
                        HStack(alignment: .center, spacing: 6) {
                            ForEach(0..<4) {
                                column in
                                let index = row * 4 + column
                                let displayMessage = self.game.getDisplayMessage(value: self.game.board[index])
                                
                                if displayMessage == "PRC" || displayMessage == "ROC" {
                                    Image(displayMessage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75)
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                } else {
                                    Text(displayMessage)
                                        .frame(width: 75, height: 75)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 26))
                                        .fontWeight(.bold)
                                        .background(self.game.getColor(value: self.game.board[index]))
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                }
                            }
                        }
                    }
                }
                .gesture(DragGesture(minimumDistance: 37)
                    .onChanged() { gesture in
                        if !self.isTriggered {
                            
                            self.isTriggered.toggle()
                            
                            if gesture.translation.width > -37 && gesture.translation.width < 37 {
                                if gesture.translation.height > 0 {
                                    self.game.slideDown()
                                } else {
                                    self.game.slideUp()
                                }
                            } else if gesture.translation.height > -37 && gesture.translation.height < 37 {
                                if gesture.translation.width > 0 {
                                    self.game.slideRight()
                                } else {
                                    self.game.slideLeft()
                                }
                            }
                            
                        }
                    }
                    .onEnded() { gesture in
                        self.isTriggered.toggle()
                    }
                )
                
                if self.game.gameStatus == .wonStatus || self.game.gameStatus == .lostStatus {
                    VStack(alignment: .center, spacing: 0) {
                        Text(self.game.getOverTitle()!)
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(height: 16)
                        
                        Text(self.game.getOverMessage())
                            .font(.system(size: 16))
                        
                        Spacer()
                            .frame(height: 16)
                        
                        Button(action: {
                            self.game.resetGame()
                        }) {
                            Text("重新开始")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .background(Color(red: 0xee/0xff, green: 0x77/0xff, blue: 0x33/0xff))
                                .clipShape(Capsule(style: .continuous))
                        }
                    }
                    .frame(width: 330, height: 330)
                    .background(Color(red: 1, green: 1, blue: 1, opacity: 0x66/0xff))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
            }
            .frame(width: 330, height: 330)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            Spacer()
                .frame(maxHeight: .infinity)
        }
        .navigationBarBackButtonHidden(true) // 隐藏默认返回按钮
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 0) {
                    ZStack() {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                            
                        }
                    }
                    .frame(width: 44, height: 44)
                    .padding(.leading, -16)
                    
                    Text("我的2048")
                        .bold()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                    
                    ZStack() {
                        
                    }
                    .frame(width: 44, height: 44)
                    .padding(.trailing, -16)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0xec/0xff, green: 0xec/0xff, blue:0xec/0xff))
        .foregroundStyle(Color.black)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

#Preview {
    IndexView()
}
