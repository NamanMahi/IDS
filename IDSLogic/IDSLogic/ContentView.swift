//
//  ContentView.swift
//  IDSLogic
//
//  Created by Rajshree Jaiswal on 09/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CategoryViewModel()
    @State private var selectedTab = "ABC"
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(hex: "770000"))
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 22, weight: .bold)
        ]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(["ABC", "XYZ", "Lorem", "Ipsum", "Lorem1", "Ipsum1"], id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                            }) {
                                Text(tab)
                                    .font(.subheadline)
                                    .padding(.horizontal, 10)
                                    .padding(.top, 10)
                                    .foregroundColor(Color(hex: "56584B"))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 20) {
                    Text("Sponsored by: Logo image")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.white)
                    
                    ProgressCircleView(progress: 0.25)
                        .frame(width: 95, height: 95)
                    
                    HStack {
                        CapsuleButton(title: "Items I have", color: Color(hex: "88EAC8"))
                        CapsuleButton(title: "Items I need", color: .white)
                            .overlay(
                                Capsule()
                                    .stroke(Color(hex: "02467C"), lineWidth: 1))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                }
                
                VStack {
                    ForEach(viewModel.categories) { category in
                        CategoryView(
                            title: category.artifact?.contentPage?.title ?? "Unknown",
                            products: category.artifact?.slideShow?.slides.map { $0.headline } ?? [],
                            checkedIndex: 0,
                            headingColor: Color(hex: "770000")
                        )
                        
                        AdPlaceholderView(size: CGSize(width: 320, height: 50))
                            .padding(.vertical)
                    }
                    
                    
                    RelatedArticlesView()
                    
                    AdPlaceholderView(size: CGSize(width: 300, height: 250))
                        .padding(.vertical)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.systemGray6))
            .navigationTitle("Checklist")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
