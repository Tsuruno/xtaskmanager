//
//  ContentView.swift
//  XTaskManager
//
//  Created by Administrator on 2020/08/06.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import SwiftUI

//TodoTaskを４つにまとめて表示(メインビュー)
struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                TodoTaskView(priority: .high)
                TodoTaskView(priority: .medium)
            }
            HStack{
                TodoTaskView(priority: .low)
                MemoView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
