//
//  CreateXView.swift
//  X
//
//  Created by Manuel Crovetto on 17/09/2023.
//

import SwiftUI

struct CreateXView: View {
    
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    CircularProfileImageView()
                    VStack(alignment: .leading, spacing: 4) {
                        Text("dersarco")
                        TextField("Start X...", text: $caption, axis: .vertical)
                    }
                    .font(.footnote)
                    Spacer()
                    
                    if !caption.isEmpty {
                        Button {
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                }
                Spacer()
            }
            .padding()
            .navigationTitle("New X")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.black)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Post") {
                        
                    }
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                    
                }
            }
        }
    }
}

#Preview {
    CreateXView()
}
