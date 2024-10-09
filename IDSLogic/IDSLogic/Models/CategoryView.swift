//
//  CategoryView.swift
//  IDSLogic
//
//  Created by Rajshree Jaiswal on 09/10/24.
//

import SwiftUI

struct CategoryView: View {
    var title: String
    var products: [String]
    var checkedIndex: Int?
    var headingColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            CategoryHeaderView(categoryTitle: title, color: headingColor)
            
            ForEach(products.indices, id: \.self) { index in
                ProductRow(title: products[index], isChecked: checkedIndex == index)
                    .padding(.horizontal)
            }
        }
        .padding(.bottom, 8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.2), radius: 5)
    }
}

struct ProgressCircleView: View {
    var progress: CGFloat
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 8, dash: [20, 5]))
                .foregroundColor(Color(hex: "5DA5D9"))
                .background(Circle().fill(Color(hex: "4BC8C8")).padding(3))
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 8, dash: [20, 5]))
                .foregroundColor(ColorConstant.primaryColor)
                .rotationEffect(Angle(degrees: 270))
            VStack(alignment: .center)  {
                Text("\(Int(progress * 100))%")
                    .bold()
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorConstant.primaryColor)
                Text("Complete")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorConstant.primaryColor)
            }
        }
    }
}

struct CapsuleButton: View {
    var title: String
    var color: Color
    var body: some View {
        Button(action: {
            // Button action
        }) {
            Text(title)
                .font(.footnote)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .foregroundColor(ColorConstant.primaryColor)
                .background(Capsule().fill(color))
        }
    }
}

struct CategoryHeaderView: View {
    var categoryTitle: String
    var color: Color
    
    var body: some View {
        Text(categoryTitle)
            .font(Font.system(size: 22, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
            .padding()
            .background(color)
            .cornerRadius(10, corners: [.topLeft, .topRight])
    }
}

struct ProductRow: View {
    var title: String
    @State var isChecked: Bool
    var body: some View {
        HStack {
            Button(action: {
                isChecked.toggle()
            }) {
                Checkbox(isChecked: $isChecked)
            }
            Text(title)
                .font(.subheadline)
            Spacer()
            Button(action: {
                // Action for "Shop Now"
            }) {
                Text("Shop Now")
                    .font(.footnote)
                    .foregroundColor(.black)
                    .font(Font.system(size: 16, weight: .bold))
            }
        }
        .padding(.vertical, 5)
    }
}

struct AdPlaceholderView: View {
    var size: CGSize
    var body: some View {
        Rectangle()
            .fill(Color(hex: "C2C2BC"))
            .frame(width: size.width, height: size.height)
            .overlay(
                Text("\(Int(size.width))x\(Int(size.height)) Ad placeholder")
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            )
    }
}

struct RelatedArticlesView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 83, height: 62)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text("Related articles")
                    .font(Font.system(size: 9))
                    .foregroundColor(.gray)
                HStack {
                    Text("Insert Article Title Here")
                        .font(Font.system(size: 16, weight: .bold))
                        .foregroundColor(ColorConstant.primaryColor)
                    
                    Text("→")
                        .foregroundColor(ColorConstant.primaryColor)
                }
                .lineLimit(1)
                .padding(.top, 2)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color(hex: "DFFFF6"))
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(hex: "17A27B"), lineWidth: 2)
        )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Checkbox: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(isChecked ? ColorConstant.primaryColor : .clear)
                    .frame(width: 16, height: 16)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .fill(isChecked ? ColorConstant.secondaryColor : .clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(ColorConstant.primaryColor, lineWidth: 2)
                            )
                    )
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

