//
//  GRPCDateTime + Ext.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

extension GrpcDateTime {
    func toDate() -> Date? {
        let calendar = Calendar.current
        let components = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: Int(date.year),
            month: Int(date.month),
            day: Int(date.day),
            hour: Int(hour),
            minute: Int(minute),
            second: Int(second))
        return calendar.date(from: components)
    }
}
