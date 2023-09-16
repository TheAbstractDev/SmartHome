//
//  DetailView.swift
//  SmartHome
//
//  Created by Sofiane Beors on 26/05/2023.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @StateObject var detailVM = DetailVM()
    @State var angleValue: CGFloat = 0.0
    let config = Config(minimumValue: 0.0,
                        maximumValue: 28.0,
                        totalValue: 28.0,
                        knobRadius: 20.0,
                        radius: 300.0)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: 25) {
                            ForEach(detailVM.devices, id: \.id) { device in
                                VStack {
                                    Image(systemName: device.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding()
                                        .background(device.id == 0 ? Color("org", bundle: .main) : Color(uiColor: .secondarySystemBackground))
                                        .clipShape(Circle())
                                        .foregroundColor(device.id == 0 ? .white : .secondary)
                                    Text(device.name)
                                        .font(.headline)
                                        .foregroundColor(device.id == 0 ? Color("org", bundle: .main) : .secondary)
                                }
                            }
                        }
                    }
                    .padding(.leading)
                    .padding(.top, 10)
                    .scrollIndicators(.hidden)

                    ZStack {
                        Group {
                            Circle()
                                .fill(Color(uiColor: colorScheme == .light ? .systemBackground : .secondarySystemBackground))
                                .shadow(color: colorScheme == .light ? Color("prp", bundle: .main).opacity(0.1) : .gray.opacity(0.25), radius: 50, y: 5)
                            .frame(width: 250)
                        }

                        Group {
                            Circle()
                                .stroke(.secondary, style: StrokeStyle(lineWidth: 1, lineCap: .butt, dash: [3, 23.18]))
                            .frame(width: 300)
                        }

                        Group {
                            Circle()
                                .trim(from: 0.0, to: detailVM.setTemperature/config.totalValue)
                                .stroke(Color("prp", bundle: .main), lineWidth: 3)
                                .frame(width: config.radius, height: config.radius)
                                .rotationEffect(.degrees(-90))
                                .overlay {
                                    Circle()
                                        .strokeBorder(Color("prp", bundle: .main), lineWidth: 2)
                                        .background(Color(uiColor: .systemBackground))
                                        .frame(width: config.knobRadius, height: config.knobRadius)
                                        .offset(y: -300/2)
                                        .rotationEffect(Angle.degrees(Double(angleValue)))
                                        .gesture(DragGesture(minimumDistance: 0.0)
                                        .onChanged({ value in
                                            change(location: value.location)
                                        }))
                            }
                        }

                        Text("\(String.init(format: "%.1f", detailVM.setTemperature))")
                            .fontWeight(.bold)
                            .font(.title)
                        +
                        Text("°C")
                            .fontWeight(.medium)
                            .font(.title)
                            .foregroundColor(Color(uiColor: .tertiaryLabel))
                    }.padding([.top, .bottom], 50)

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Current Temperature")
                                .foregroundColor(Color(uiColor: .tertiaryLabel))
                                .font(.headline)

                            Text(String(describing: detailVM.currentTemperature))
                                .fontWeight(.bold)
                                .font(.title)
                            +
                            Text("°C")
                                .fontWeight(.medium)
                                .font(.title)
                                .foregroundColor(Color(uiColor: .tertiaryLabel))
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Current Humidity")
                                .foregroundColor(Color(uiColor: .tertiaryLabel))
                                .font(.headline)
                            Text(String(describing: detailVM.currentHumidity))
                                .fontWeight(.bold)
                                .font(.title)
                            +
                            Text("%")
                                .fontWeight(.medium)
                                .font(.title)
                                .foregroundColor(Color(uiColor: .tertiaryLabel))
                        }
                    }
                    .padding(.horizontal, 25)
                    
                    VStack(alignment: .leading) {
                        Text("History")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        ChartView()
                        .environmentObject(detailVM)
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)

                }
                .navigationTitle("Living Room")
                .onAppear {
                    angleValue = 240
                    detailVM.getDevices()
                }
            }
        }
    }
    
    private func change(location: CGPoint) {
        // creating vector from location point
        let vector = CGVector(dx: location.x, dy: location.y)
        
        // geting angle in radian need to subtract the knob radius and padding from the dy and dx
        let angle = atan2(vector.dy - (config.knobRadius + 10), vector.dx - (config.knobRadius + 10)) + .pi/2.0
        
        // convert angle range from (-pi to pi) to (0 to 2pi)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // convert angle value to temperature value
        let value = fixedAngle / (2.0 * .pi) * config.totalValue
        
        if value >= config.minimumValue && value <= config.maximumValue {

            let roundedTemperature = roundToNearestHalf(value: Float(value))

            detailVM.setTemperature = CGFloat(roundedTemperature)
            angleValue = fixedAngle * 180 / .pi // converting to degree
        }
    }
    
    func roundToNearestHalf(value: Float) -> Float {
        let remainder = fmod(value, 0.5)
        let roundedValue = remainder < 0.25 ? value - remainder : value - remainder + 0.5
        return roundedValue
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct Config {
    let minimumValue: CGFloat
    let maximumValue: CGFloat
    let totalValue: CGFloat
    let knobRadius: CGFloat
    let radius: CGFloat
}
