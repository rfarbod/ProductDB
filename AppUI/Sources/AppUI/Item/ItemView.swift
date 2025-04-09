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
                model.imgeResource?
                    .resizable()
            }
            .frame(width: 50, height: 50)
            
            Spacer()
            
            Text(model.description)
                .font(.caption)
                .padding()
            
            Spacer()
                    
            Text("Rating: \(model.rate)")
                .font(.title3)
            
            if model.isDetailed {
                Text("Discounted Price: \(model.discountedPrice)")
                    .font(.title3)
                
                Text("Stock: \(model.stock)")
                    .font(.title3)
            }
            
            Divider()
        }
    }
}
