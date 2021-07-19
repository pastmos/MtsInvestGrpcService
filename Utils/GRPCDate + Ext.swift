//
//  GRPCDate + Ext.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

extension GrpcDate {
    func toDate() -> Date? {
        let calendar = Calendar.current
        let components = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: Int(year),
            month: Int(month),
            day: Int(day))
        return calendar.date(from: components)
    }
}
