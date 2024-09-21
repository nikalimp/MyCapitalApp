//
//  PieChartView.swift
//  MyCapitalApp
//
//  Created by Никита Алимпиев on 21.09.2024.
//

import SwiftUI

struct PieChartView: View {
    let data: [Double]
    let totalAssets: Double // Передаем сумму всех активов в компонент

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<data.count, id: \.self) { index in
                    let startAngle = angleForIndex(index: index)
                    let endAngle = angleForIndex(index: index + 1)
                    
                    let category = CategoryData.categories[index % CategoryData.categories.count]
                    
                    PieSlice(startAngle: .degrees(startAngle), endAngle: .degrees(endAngle))
                        .fill(category.color) // Цвет для категории
                        .frame(width: geometry.size.width, height: geometry.size.height)

                    // Позиционируем иконку по центру каждого сегмента
                    let midAngle = (startAngle + endAngle) / 2
                    let radius = geometry.size.width / 2 * 0.75
                    let xOffset = radius * cos(midAngle * .pi / 180)
                    let yOffset = radius * sin(midAngle * .pi / 180)
                    
                    Image(systemName: category.icon)
                        .foregroundColor(.white)
                        .position(x: geometry.size.width / 2 + xOffset, y: geometry.size.height / 2 + yOffset)
                }
                
                // Окружность для создания эффекта "пончика"
                Circle()
                    .fill(Color(UIColor.systemGroupedBackground))
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.6)
                
                // Текст по центру (сумма всех активов)
                Text("$\(Int(totalAssets))")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    func angleForIndex(index: Int) -> Double {
        let total = data.reduce(0, +)
        let sum = data.prefix(index).reduce(0, +)
        return 360 * sum / total
    }
}

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * 0.6 // Внутренний радиус для создания эффекта пончика
        
        var path = Path()
        
        // Наружная дуга
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        // Внутренняя дуга
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        
        path.closeSubpath()
        return path
    }
}
