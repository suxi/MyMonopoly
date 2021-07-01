//
//  ContentView.swift
//  MyMonopoly
//
//  Created by 苏曦 on 2021/6/28.
//

import SwiftUI

struct GameKyes {
    static let keyPlayers = "playersKey"
    static let keyNum = "numKey"
    static let keyTrans = "transKey"
    static let keyDeposit = "depositKey"
    static let keyWithdrawal = "withdrawalKey"
}

let Chances = [
    Text("前进到【浮桥】方格"),
    Text("走一趟到【雷丁铁路】方格。如果途径【起点】，领取$200。"),
    Text("你的房屋贷款到期了，领取$150。"),
    Text("前进到【伊利诺伊州大道】。如果途径【起点】，领取$200。"),
    Text("前进到就近的公共事业。如果是自有物业，你可以选择向银行购入它；如果是其他参加者拥有它，必须支付租金给该参加者，而租金是骰子的点数乘十倍。"),
    Text("关进监狱。立即入狱，不须途径【起点】，不可以领取$200。"),
    Text("前进【起点】。（领取$200）"),
    Text("获银行分派股息$50"),
    Text("你的所有物业进行一般性维修的费用：每一栋房子支付25，每一栋旅馆$100。"),
    Text("获取一张监狱通行证。"),
    Text("前进到【圣查尔斯广场】方格。如果途径【起点】，领取$200。"),
    Text("你已被选举为董事会主席。支付每个参加者$50。"),
    Text("倒退三个方格。"),
    Text("超速行驶罚款$15"),
    Text("前进到就近的铁路。如果是自由物业，你可以选择向银行购入它；如果是其他参加者拥有它，必须支付该参加者所赋予或可能给予两倍的租金。"),
    Text("前进到就近的铁路。如果是自由物业，你可以选择向银行购入它；如果是其他参加者拥有它，必须支付该参加者所赋予或可能给予两倍的租金。")
]

let Funds = [
    Text("获取一张监狱通行证"),
    Text("医生费用，支付$50。"),
    Text("假期基金到期了，领取$100。"),
    Text("人寿保险到期了，领取$100。"),
    Text("学费，支付$50。"),
    Text("所得税退税，收取$20。"),
    Text("医院费用，支付$100。"),
    Text("关进监狱。立即入狱，不须途径【起点】，不可以领取$200。"),
    Text("领取咨询费$25。"),
    Text("这是你的生日。向每个人参加者收取$10。"),
    Text("你继承$100。"),
    Text("你出售股票获取$50。"),
    Text("你在选美比赛获得第二名奖项，领取$10。"),
    Text("你已评估街道维修费用：自己拥有的每一栋房子支付$40及每一栋旅馆$115。"),
    Text("前进【起点】。（领取$200）"),
    Text("银行错误，你是受益人，领取$200。")
]


struct ContentView: View {
    @State private var players : [Int] = [20580,10000,0,0,0] // 0:banker, >1: player
    @State private var num = 4
    @State private var trans = 0
    @State private var deposit = 0 //存钱
    @State private var withdrawal = 0 //取钱
    @State private var chance = Array<Int>()
    @State private var fund = Array<Int>()
    @State private var logs : [String] = ["","","","",""]
    
    @State private var reset = false
    @State private var setNum = false
    @State private var showChance = false
    @State private var pChance = 0
    @State private var showFund = false
    @State private var pFund = 0
    
    
    private func finish() -> Void {
        print("\(deposit) \(withdrawal) \(trans)")
        
        logs = ["","","","",""]
        logs[deposit] = "-\(trans)"
        logs[withdrawal] = "+\(trans)"
        
        deposit = 0
        withdrawal = 0
        trans = 0
    }
    private func next(_ player : Int) -> Int {
        if player >= num {
            return 0
        }else {
            return player + 1
        }
    }
    private func newGame(_ n: Int) -> Void {
        players[0] = 20580
        for i in 1 ... n {
            players[i] = 1500
        }
        num = n
        deposit = 0
        withdrawal = 0
        trans = 0
        chance = Array<Int>()
        fund = Array<Int>()
        logs = ["","","","",""]
        setNum = false
    }
    private func shuffle() -> Array<Int> {
        var cards = Array(arrayLiteral: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
        for _ in 1...Int.random(in:10...20) {
            for i in 0...cards.count - 1 {
                cards.swapAt(Int.random(in: 0...15), i)
            }
        }
        return cards
    }
    
    var body: some View {
        VStack() {
            VStack {
                VStack {
                        if (num > 1){
                            
                            HStack(alignment: .bottom) {
                                Text("🚤")
                                Spacer()
                                Text(logs[1]).font(.title3)
                                Text(String(players[1]))
                                    .frame(minWidth: 100, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 100, minHeight: 0, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .trailing)
                                Text("M")
                                    .font(.callout)
                            }
                            .frame(height: 40.0)
                            .foregroundColor(.red)
                            .font(.largeTitle)
                        }
                        if (num >= 2) {
                            
                            HStack(alignment: .bottom) {
                                Text("🛻")
                                Spacer()
                                Text(logs[2]).font(.title3)
                                Text(String(players[2]))
                                    .frame(minWidth: 100, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 100, minHeight: 0, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .trailing)
                                Text("M").font(.callout)
                            }
                            .frame(height: 40.0).foregroundColor(.yellow).font(.largeTitle)
                        }
                        if (num >= 3) {
                            
                            HStack(alignment: .bottom) {
                                Text("🐎")
                                Spacer()
                                Text(logs[3]).font(.title3)
                                Text(String(players[3]))
                                    .frame(minWidth: 100, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 100, minHeight: 0, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .trailing)
                                Text("M").font(.callout)
                            }
                            .frame(height: 40.0).foregroundColor(.blue).font(.largeTitle)
                        }
                        if (num >= 4) {
                            
                            HStack(alignment: .bottom) {
                                Text("🐈‍⬛")
                                Spacer()
                                Text(logs[4]).font(.title3)
                                Text(String(players[4]))
                                    .frame(minWidth: 100, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 100, minHeight: 0, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .trailing)
                                Text("M").font(.callout)
                            }
                            .frame(height: 40.0).foregroundColor(.green).font(.largeTitle)
                        }
                    Spacer()
                    HStack(alignment: .center) {
                        Button(action: {
                            withdrawal = next(withdrawal)
                            if withdrawal == deposit && withdrawal != 0 {
                                withdrawal = next(withdrawal)
                                
                            }
                        }, label: {
                            switch withdrawal {
                            case 1: Text("🚤")
                            case 2: Text("🛻")
                            case 3: Text("🐎")
                            case 4: Text("🐈‍⬛")
                            default:
                                Text("🏦")
                            }
                        }).frame(width:60).font(.largeTitle)
                        Spacer()
                        Text(String(trans))
                            .lineLimit(1).foregroundColor(.black)
                            .font(.custom("DBLCDTempBlack", size: 36))
                            .lineSpacing(-20)
                        Spacer()
                        Button(action: {
                            deposit = next(deposit)
                            if deposit == withdrawal && deposit != 0 {
                                deposit = next(deposit)
                            }
                        }, label: {
                            switch deposit {
                            case 1: Text("🚤")
                            case 2: Text("🛻")
                            case 3: Text("🐎")
                            case 4: Text("🐈‍⬛")
                            default:
                                Text("🏦")
                            }
                        }).frame(width: 60.0).font(.largeTitle)
                       
                    }
                }.padding().background(Color(red: 161/255, green: 153/255, blue: 138/255))
            }
            .padding(.all, 24.0)

            
            VStack {
                HStack(alignment: .center) {
                    Button(action: {
                        if deposit != 0 || withdrawal != 0 {
                            players[deposit] -= trans
                            players[withdrawal] += trans
                            finish()
                        }
                    }, label: {
                        Text("🤝").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {
                            if withdrawal > 0 {
                                trans = 200
                                players[withdrawal] += trans
                                finish()
                            }
                    },label: {
                        Text("⟵").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.orange).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {trans = trans / 10}, label: {
                        Text("C").font(.largeTitle).fontWeight(.black).foregroundColor(Color.white).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                    .alert(isPresented: $reset, content: {
                        Alert(
                            title: Text("要重置游戏吗?当前游戏数据会丢失!"),
                            primaryButton: .default(Text("要"), action: {
                                players = [20580,0,0,0,0]
                                num = 4
                                trans = -1
                                setNum = true
                            }),
                            secondaryButton: .default(Text("不要")))
                    })
                    .simultaneousGesture(LongPressGesture().onEnded({ _ in
                        reset = true
                    }))
                }
                .padding(.all, 3.0)
                
                HStack() {
                    Button(action: {if trans > 2058 || setNum {return};trans = trans * 10 + 7}, label: {
                            Text("7").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {if trans > 2058 || setNum {return};trans = trans * 10 + 8}, label: {
                        Text("8").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                            
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {if trans > 2058 || setNum {return};trans = trans * 10 + 9}, label: {
                        Text("9").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                }
                .padding(.all, 3.0)
                HStack() {
                    Button(action: {
                        if setNum {
                            newGame(4)
                            return
                        }
                        if trans > 2058 {
                            return
                            
                        }
                        if trans > 2058 {
                            return
                        }
                        trans = trans * 10 + 4
                        
                    }, label: {
                            Text("4").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {if trans > 2058 || setNum {return};trans = trans * 10 + 5},label: {
                        Text("5").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                            
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {if trans > 2058 || setNum {return};trans = trans * 10 + 6}, label: {
                        Text("6").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                }
                .padding(.all, 3.0)
                HStack() {
                    Button(action: {
                        if trans > 2058 || setNum {
                            return
                        }
                        trans = trans * 10 + 1
                        
                    }, label: {
                            Text("1").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {
                        if setNum {
                            newGame(2)
                            return
                        }
                        if trans > 2058 {
                            return
                        }
                        trans = trans * 10 + 2
                        
                    }, label: {
                        Text("2").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                            
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {
                        if setNum {
                            newGame(3)
                            return
                        }
                        if trans > 2058 {
                            return
                        }
                        trans = trans * 10 + 3
                        
                    }, label: {
                        Text("3").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                }
                .padding(.all, 3.0)
                HStack() {
                    Button(action: {}, label: {
                        Text("❓").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    }).background(Color.gray)
                    .alert(isPresented: $showChance, content: {
                        Alert(title: Chances[pChance].bold())
                    })
                    .simultaneousGesture(LongPressGesture().onEnded({ _ in
                        if chance.isEmpty {
                            chance = shuffle()
                        }
                        pChance = chance.popLast()!
                        showChance = true
                    }))
                    Spacer()
                    Button(action: {if trans > 2058 || setNum {return};trans = trans * 10 + 0}, label: {
                        Text("0").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                            
                    }).background(Color.gray)
                    Spacer()
                    Button(action: {}, label: {
                        Text("💲").font(.largeTitle).fontWeight(.black).frame(width: 80, height: 80, alignment: .center)
                    })
                    .background(Color.gray)
                    .alert(isPresented: $showFund, content: {
                        Alert(title: Funds[pFund].bold())
                    })
                    .simultaneousGesture(LongPressGesture().onEnded({ _ in
                        if fund.isEmpty {
                            fund = shuffle()
                        }
                        pFund = fund.popLast()!
                        showFund = true
                    }))
                }
                .padding(.all, 3.0)
            }
            .padding()
        }.preferredColorScheme(.dark)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
