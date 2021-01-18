//
//  SampleView.swift
//  XTaskManager
//
//  Created by Administrator on 2020/08/10.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import SwiftUI


import SwiftUI

struct ListView : View {
    @State var array = [String]()

    var body: some View {
        List{
            ForEach(0..<array.count, id: \.self) { item in
                Text(self.array[item])
            }

            Button(action: {
                self.array = createArray()
            }) {
                Text("add")
            }
        }
    }
}

func createArray()->[String] {
    return ["item1", "item2", "item3", "item4", "item5","item6"]
}


struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
      ListView()
    }
}
