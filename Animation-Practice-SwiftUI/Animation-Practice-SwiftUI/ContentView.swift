//
//  ContentView.swift
//  Animation-Practice-SwiftUI
//
//  Created by 이주희 on 2023/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                RabbitView(path: Path(), start: .zero)
            } label: {
                Text("Rabbit🐰")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
