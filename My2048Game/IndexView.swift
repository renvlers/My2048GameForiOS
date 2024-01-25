//
//  IndexView.swift
//  My2048Game
//
//  Created by Renvle RS on 1/24/24.
//

import SwiftUI

struct IndexView: View {
    @State var showRuleAlert: Bool = false
    @State var ruleMessage: String = """
    玩家在4x4的网格上滑动方块，每次滑动时所有方块向滑动方向移动，\
    相同数字的方块在碰撞时合并成它们数值之和的新方块，\
    目标是在尽可能短的时间内创建一个数值为2048的方块，\
    游戏在获得2048或没有空间生成新方块时结束。
    """
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(height: 80)
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .frame(width: 256, height: 256)
                        .foregroundStyle(Color(red: 0xed/0xff, green: 0xc2/0xff, blue: 0x2e/0xff))
                    Text("2048")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .font(.system(size: 80))
                }
                Spacer()
                    .frame(height: 80)
                VStack(alignment: .center, spacing: 0) {
                    NavigationLink(value: "GamePage") {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                Image("play")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(12)
                                    .frame(width: 64,height: 64)
                                Spacer()
                                Text("开始游戏")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.black)
                                    .padding(16)
                            }
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .background(Color(red: 0x99/0xff, green: 0xcc/0xff, blue: 0xff/0xff))
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    Spacer().frame(height: 16)
                    
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                        Button(action: { self.showRuleAlert.toggle() }) {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Image("rule")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(12)
                                        .frame(width: 64,height: 64)
                                    Spacer()
                                    Text("游戏规则")
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color.black)
                                        .padding(16)
                                }
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                        .background(Color(red: 0x99/0xff, green: 0xff/0xff, blue: 0xcc/0xff))
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .alert(isPresented: $showRuleAlert) {
                            Alert(
                                title: Text("2048游戏规则"),
                                message: Text(ruleMessage),
                                dismissButton: .cancel(Text("确定"))
                            )
                        }
                        
                        Spacer().frame(width: 16)
                        
                        Button(action: {}) {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Image("settings")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(12)
                                        .frame(width: 64,height: 64)
                                    Spacer()
                                    Text("游戏设置")
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color.black)
                                        .padding(16)
                                }
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                        .background(Color(red: 0xff/0xff, green: 0x99/0xff, blue: 0xcc/0xff))
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 46)
            .background(Color(red: 0xec/0xff, green: 0xec/0xff, blue: 0xec/0xff))
            
            .navigationDestination(for: String.self) {dest in
                if dest == "GamePage" {
                    GamePageView()
                }
            }
            .foregroundStyle(Color.black)
        }
        
    }
}

#Preview {
    IndexView()
}
