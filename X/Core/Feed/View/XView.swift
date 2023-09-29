//
//  XView.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI

struct XView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView()
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("dersarco (primo luca)")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("· 10m")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        Spacer()
                    
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    Text("Happy birthday to my cat! 🐈🎉")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack() {
                        HStack(spacing: 4) {
                            Button {
                                
                            } label: {
                                Image("comment-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("567")
                                    .font(.footnote)
                                    .fontWeight(.light)
                                    .foregroundStyle(.black)
                            }
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Button {
                                
                            } label: {
                                Image("retweet-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .tint(.black)
                                    
                            }
                            Text("1.1k")
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Button {
                                
                            } label: {
                                Image("liked-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            Text("3.2k")
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundStyle(.black)
                                
                        }
                       
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("analytics")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .colorMultiply(.black)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            Divider()
        }
        .padding()
    }
}

#Preview {
    XView()
}
