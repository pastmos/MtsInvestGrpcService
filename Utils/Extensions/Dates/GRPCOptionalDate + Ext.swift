//
//  GRPCOptionalDate.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 23.07.2021.
//

extension GrpcOptionalDate {
    func toDate() -> Date? {
        guard hasValue else { return nil }
        let calendar = Calendar.current
        let components = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: Int(value.year),
            month: Int(value.month),
            day: Int(value.day))
        return calendar.date(from: components)
    }
}
