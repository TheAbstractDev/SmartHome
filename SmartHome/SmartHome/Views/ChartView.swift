//
//  ChartView.swift
//  SmartHome
//
//  Created by Sofiane Beors on 02/06/2023.
//

import SwiftUI
import Charts

struct ChartView: View {
    @EnvironmentObject var detailVM: DetailVM
    @State var selectedRecord: Record?
    
    var body: some View {
        VStack {
            Chart {
                ForEach(detailVM.records, id: \.id) { record in
                    LineMark(x: .value("Date", record.date), y: .value("Temperature", record.animate ? record.temperature : 0))
                        .foregroundStyle(Color("prp", bundle: .main))
                        .interpolationMethod(.catmullRom)
                    AreaMark(x: .value("Date", record.date), y: .value("Temperature", record.animate ? record.temperature : 0))
                        .foregroundStyle(LinearGradient(colors: [Color("prp", bundle: .main).opacity(0.4), .clear], startPoint: .top, endPoint: .bottom))
                        .interpolationMethod(.catmullRom)
                    
                    if let selectedRecord, record.id == selectedRecord.id {
                        RuleMark(x: .value("Day", record.date))
                            .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                        .foregroundStyle(Color("prp", bundle: .main).opacity(0.4))
                        .annotation {
                            VStack(alignment: .leading) {
                                Text(String(format: "%.1f", selectedRecord.temperature))
                                    .font(.caption.bold())
                                +
                                Text("°C")
                                    .font(.caption.bold())
                            }
                            .padding(.horizontal)
                            .offset(x: 30, y: 30)
                        }
                    }
                }
            }
        }
        .task {
            await detailVM.getRecords()
            animateChart()
        }
        .chartXAxis(.hidden)
        .chartOverlay { proxy in
            Rectangle()
                .fill(.clear).contentShape(Rectangle())
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let location = value.location
                            
                            if let date: Date = proxy.value(atX: location.x) {
                                let day = Calendar.current.component(.day, from: date)
                                if let currentRecord = detailVM.records.first(where: { Calendar.current.component(.day, from: $0.date) == day
                                }) {
                                    print(currentRecord.date)
                                    selectedRecord = currentRecord
                                }
                            }
                        }
                        .onEnded({ _ in
                            selectedRecord = nil
                        })
                )
        }
        .frame(height: 50)
    }
    
    func animateChart() {
        for (i, _) in detailVM.records.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.01, execute: {
                withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                    detailVM.records[i].animate = true
                }
            })
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(DetailVM())
    }
}
