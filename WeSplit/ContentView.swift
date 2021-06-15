//
//  ContentView.swift
//  WeSplit
//
//  Created by iresh sharma on 15/06/21.
//

import SwiftUI



struct ContentView: View {
    
    @State private var checkAmount: String = ""
    @State private var nPeople: Int = 0
    @State private var tipPercentage: Int = 2
    
    var tipPercentages: [Int] = [0, 10, 20, 50, 80]
    
    var split: Double {
        let nPeople = Double(self.nPeople + 2)
        let amount = Double(self.checkAmount) ?? -1
        let tipPercentage = Double(self.tipPercentages[self.tipPercentage])
        if amount == -1 {
            return 0
        }
        return (amount*(tipPercentage)/100 + amount)/nPeople
    }
    
    var amountWithTip: Double {
        let amount = Double(self.checkAmount) ?? -1
        let tipPercentage = Double(self.tipPercentages[self.tipPercentage])
        if amount == -1 {
            return 0
        }
        return amount*(tipPercentage)/100 + amount
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Enter info")) {
                        TextField("Check amount", text: $checkAmount)
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                        
                        Picker("Number Of People", selection: $nPeople) {
                            ForEach(2..<20) {
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section(header: Text("Tip percentage")) {
                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(0..<tipPercentages.count) {
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    HStack {
                        Text("Check Amount")
                        Spacer()
                        Text(ruppeeFormatter(amount: checkAmount)).bold()
                    }
                    HStack {
                        Text("Amount with tip")
                        Spacer()
                        Text(ruppeeFormatter(amount: String(format: "%.2f", amountWithTip)))
                            .bold()
                    }
                }
                Text("Amount Per head")
                Text(ruppeeFormatter(amount: String(format: "%.2f", split)))
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.green)
            }.navigationTitle(Text("WeSplit"))
        }
    }
    
    func ruppeeFormatter(amount: String) -> String {
        if amount.count == 0 {
            return "₹"
        } else {
            var i = 0
            var ret = ""
            for digit in amount.split(separator: ".")[0].reversed() {
                ret += String(digit)
                if (i+1)%3 == 0 && i+1 < amount.split(separator: ".")[0].count {
                    ret += ","
                }
                i += 1
            }
            return "₹ " +  String(ret.reversed()) + "." + (amount.split(separator: ".").count > 1 ? amount.split(separator: ".")[1] : "00")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
