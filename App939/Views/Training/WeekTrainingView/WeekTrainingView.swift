import SwiftUI

struct WeekTrainingView: View {
    
    @ObservedObject var viewModel: WeekTrainingViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.c217217217.opacity(0.04), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: min(CGFloat((Double(viewModel.configure(viewModel.getMonday()))/Double(viewModel.dm.dailyTrainingTime))), 1) )
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(min(100,Int(Double(viewModel.configure(viewModel.getMonday()))/Double(viewModel.dm.dailyTrainingTime) * 100))) %")
                        .font(.caption2)
                        .foregroundColor(.primaryYellow)
                }
                .padding(.bottom, 8)
                Text(viewModel.descriptionFor(viewModel.getMonday()).0)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
                Text(viewModel.descriptionFor(viewModel.getMonday()).1)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
            }
            .opacity(viewModel.isToday(viewModel.getMonday()) ? 1 : 0.3)
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.c217217217.opacity(0.04), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: min(CGFloat((Double(viewModel.configure(viewModel.getTuesday()))/Double(viewModel.dm.dailyTrainingTime))), 1) )
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(min(100,Int(Double(viewModel.configure(viewModel.getTuesday()))/Double(viewModel.dm.dailyTrainingTime) * 100))) %")
                        .font(.caption2)
                        .foregroundColor(.primaryYellow)
                }.padding(.bottom, 8)
                Text(viewModel.descriptionFor(viewModel.getTuesday()).0)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
                Text(viewModel.descriptionFor(viewModel.getTuesday()).1)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
            }
            .opacity(viewModel.isToday(viewModel.getTuesday()) ? 1 : 0.3)
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.c217217217.opacity(0.04), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: min(CGFloat((Double(viewModel.configure(viewModel.getWednesday()))/Double(viewModel.dm.dailyTrainingTime))), 1) )
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(min(100,Int(Double(viewModel.configure(viewModel.getWednesday()))/Double(viewModel.dm.dailyTrainingTime) * 100))) %")
                        .font(.caption2)
                        .foregroundColor(.primaryYellow)
                }.padding(.bottom, 8)
                Text(viewModel.descriptionFor(viewModel.getWednesday()).0)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
                Text(viewModel.descriptionFor(viewModel.getWednesday()).1)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
            }
            .opacity(viewModel.isToday(viewModel.getWednesday()) ? 1 : 0.3)
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.c217217217.opacity(0.04), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: min(CGFloat((Double(viewModel.configure(viewModel.getThursday()))/Double(viewModel.dm.dailyTrainingTime))), 1) )
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(min(100,Int(Double(viewModel.configure(viewModel.getThursday()))/Double(viewModel.dm.dailyTrainingTime) * 100))) %")
                        .font(.caption2)
                        .foregroundColor(.primaryYellow)
                }.padding(.bottom, 8)
                Text(viewModel.descriptionFor(viewModel.getThursday()).0)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
                Text(viewModel.descriptionFor(viewModel.getThursday()).1)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
            }
            .opacity(viewModel.isToday(viewModel.getThursday()) ? 1 : 0.3)
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.c217217217.opacity(0.04), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: min(CGFloat((Double(viewModel.configure(viewModel.getFriday()))/Double(viewModel.dm.dailyTrainingTime))), 1) )
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(min(100,Int(Double(viewModel.configure(viewModel.getFriday()))/Double(viewModel.dm.dailyTrainingTime) * 100))) %")
                        .font(.caption2)
                        .foregroundColor(.primaryYellow)
                }.padding(.bottom, 8)
                Text(viewModel.descriptionFor(viewModel.getFriday()).0)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
                Text(viewModel.descriptionFor(viewModel.getFriday()).1)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
            }
            .opacity(viewModel.isToday(viewModel.getFriday()) ? 1 : 0.3)
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.c217217217.opacity(0.04), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: min(CGFloat((Double(viewModel.configure(viewModel.getSaturday()))/Double(viewModel.dm.dailyTrainingTime))), 1) )
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(min(100,Int(Double(viewModel.configure(viewModel.getSaturday()))/Double(viewModel.dm.dailyTrainingTime) * 100))) %")
                        .font(.caption2)
                        .foregroundColor(.primaryYellow)
                }.padding(.bottom, 8)
                Text(viewModel.descriptionFor(viewModel.getSaturday()).0)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
                Text(viewModel.descriptionFor(viewModel.getSaturday()).1)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
            }
            .opacity(viewModel.isToday(viewModel.getSaturday()) ? 1 : 0.3)
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.c217217217.opacity(0.04), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: min(CGFloat((Double(viewModel.configure(viewModel.getSunday()))/Double(viewModel.dm.dailyTrainingTime))), 1) )
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(min(100,Int(Double(viewModel.configure(viewModel.getSunday()))/Double(viewModel.dm.dailyTrainingTime) * 100))) %")
                        .font(.caption2)
                        .foregroundColor(.primaryYellow)
                }.padding(.bottom, 8)
                Text(viewModel.descriptionFor(viewModel.getSunday()).0)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
                Text(viewModel.descriptionFor(viewModel.getSunday()).1)
                    .font(.caption2)
                    .foregroundColor(.primaryYellow)
            }
            .opacity(viewModel.isToday(viewModel.getSunday()) ? 1 : 0.3)
        }
    }
}

#Preview {
    WeekTrainingView(viewModel: WeekTrainingViewModel(dm: DataController()))
        .background(Color.bgMain)
}
