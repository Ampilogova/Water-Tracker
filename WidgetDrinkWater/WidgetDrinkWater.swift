//
//  WidgetDrinkWater.swift
//  WidgetDrinkWater
//
//  Created by Tatiana Ampilogova on 8/16/21.
//  Copyright © 2021 Tatiana Ampilogova. All rights reserved.
//

import WidgetKit
import SwiftUI

struct WaterEntry: TimelineEntry {
    public let date: Date
    let water: WaterData
}

struct Provider: TimelineProvider {
    
    public typealias Entry = WaterEntry
    
    func placeholder(in context: Context) -> WaterEntry {
        WaterEntry(date: Date(), water: WaterData.getWater())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WaterEntry) -> ()) {
        let entry = WaterEntry(date: Date(), water: WaterData.getWater())
        completion(entry)
    }
    
    
    func getTimeline( in context: Context, completion: @escaping (Timeline<WaterEntry>) -> Void) {
        //        let currentDate = Date()
        var entries: [WaterEntry] = []
        
        //        for hourOffset in 0 ..< 60 {
        //            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
        //
        //            let entry = WaterEntry(date: entryDate, water: WaterData.getWater())
        //            entries.append(entry)
        //        }
        let currentDate = Date()
        let startOfDay = Calendar.current.startOfDay(for: currentDate)
        //        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let entry = WaterEntry(date: startOfDay, water: WaterData.getWater())
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetDrinkWaterEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(loc("water.is.life"))
                .font(.headline)
                .foregroundColor(.white)
                .bold()
                .frame(width: 140, height: 50, alignment: .leading)
                
                .background(ContainerRelativeShape().fill(Color("blueColor")))
            Spacer()
            Text("\(WaterData.stringFormatter(from: entry.water.currentAmount))")
                .font(.largeTitle)
                .foregroundColor(Color("blueColor"))
                +
                Text("\(WaterData.volumeFormatter())")
                .font(.body)
                .foregroundColor(Color("blueColor"))
            Spacer()
            
            VStack(alignment: .leading) {
                Text(loc("last.drink") + " " + "\(WaterData.lastDrinkTime())")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
        }
        .padding(.all)
    }
}

@main
struct WidgetDrinkWater: Widget {
    let kind: String = "WidgetDrinkWater"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetDrinkWaterEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WidgetDrinkWater_Previews: PreviewProvider {
    static var previews: some View {
        WidgetDrinkWaterEntryView(entry: WaterEntry(date: Date(), water: WaterData.getWater()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            .environment(\.colorScheme, .dark)
    }
    
}
