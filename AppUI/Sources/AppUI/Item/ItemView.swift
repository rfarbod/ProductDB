//
//  ItemView.swift
//  AppUI
//
//  Created by Farbod on 4/9/25.
//

import SwiftUI

public struct ItemView: View {
    private var model: ItemViewModel
    
    public init(model: ItemViewModel) {
        self.model = model
    }
    
    public var body: some View {
        VStack {
            Text(model.title)
                .font(.headline)
            
            HStack{
                Image(systemName: "")
            }
            .frame(width: 100, height: 150)
            
            Spacer()
            
            Text(model.description)
                .font(.caption)
            
            Spacer()
            
            VStack {
                Text("\(model.rate)")
                    .font(.caption)
                
                Text("\(model.price) $")
                    .font(.caption)
            }
        }
    }
}
