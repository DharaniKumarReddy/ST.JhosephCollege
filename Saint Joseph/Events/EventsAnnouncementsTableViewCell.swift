//
//  EventsAnnouncementsTableViewCell.swift
//  Saint Joseph
//
//  Created by Dharani on 7/24/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import EventKit

class EventsAnnouncementsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}

class EventsCell: EventsAnnouncementsTableViewCell {
    
    @IBOutlet private weak var monthLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    
    var event: NewsData!
    
    var eventStore : EKEventStore = EKEventStore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func fillEventsData() {
        titleLabel.text = event.title as String
        descriptLabel.text = event.descript as String
        let date = DateFormatter.defaultFormatter().dateFromString(event.updatedAt as String)
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year], fromDate: date!)
        monthLabel.text = DateFormatter.defaultFormatter().monthSymbols[components.month - 1]
        dayLabel.text = "\(components.day)"
        yearLabel.text = "\(components.year)"
    }
    
    // MARK:- IBActions
    
    @IBAction private func addToCalendar(sender: UIButton) {
        eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) in
            if granted && error == nil {
                
                print("granted \(granted)")
                print("error \(error)")
                
                let ekEvent:EKEvent = EKEvent(eventStore: self.eventStore)
                ekEvent.title = self.event.title as String
                ekEvent.startDate = DateFormatter.defaultFormatter().dateFromString(self.event.updatedAt as String)!.startOfDay
                ekEvent.endDate = DateFormatter.defaultFormatter().dateFromString(self.event.updatedAt as String)!.endOfDay!
                ekEvent.notes = "This is a ST Jhoseph College Note"
                ekEvent.calendar = self.eventStore.defaultCalendarForNewEvents
                do {
                    try self.eventStore.saveEvent(ekEvent, span: .ThisEvent)
                    print("Saved Event")
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        })
    }
}

class AnnouncementsCell: EventsAnnouncementsTableViewCell {
    
}