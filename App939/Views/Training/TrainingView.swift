import SwiftUI
import Combine
import AVKit

struct TrainingView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @ObservedObject var viewModel: TrainingViewModel
    
    @State var showTrainingSetting = false
    @State var showTraining = false
    
    @State var swipeWidth: CGFloat = .zero
    @State var offset: CGFloat = .zero
    
    @State var opacity: CGFloat = 1
    @State var lockOpacity: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 20) {
                Button {
                    showTrainingSetting = true
                } label: {
                    Image(systemName: "timer")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primaryYellow)
                        .frame(width: 26, height: 22)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                
                Text("Training schedule")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                WeekTrainingView(viewModel: ViewModelFactory.shared.makeWeekTrainingViewModel())
                
                Text("My training")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if viewModel.trainings.isEmpty {
                    emptyTraining
                } else {
                    trainings
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 16)
            
            if showTraining {
                if !viewModel.trainingFullEnd {
                    training
                } else {
                    trainingEnd
                }
                
            }
        }
        .sheet(isPresented: $showTrainingSetting) {
            trainingSetting
        }
    }
    
    private var swipeField: some View {
        ZStack {
            HStack(spacing: 5) {
                Text("Swipe to unlock")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(height: 12)
            }
            .opacity(opacity)
            Image(systemName: "lock.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.c2242127)
                .overlay(
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.c362550)
                        .opacity(lockOpacity)
                )
                .padding(7)
                .frame(width: 54, height: 54)
                .background(Color.c144144144.opacity(lockOpacity))
                .clipShape(.circle)
                .offset(x: -swipeWidth/2 + 32 + offset)
        }
        .frame(maxWidth: .infinity)
        .padding(5)
        .background(Color.white.opacity(0.1))
        .clipShape(.rect(cornerRadius: 40))
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width >= swipeWidth - 54 {
                        withAnimation(.linear(duration: 0.1)) {
                            viewModel.isTrainingActive = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            offset = 0
                            lockOpacity = 0
                            opacity = 1
                        }
                    } else {
                        if value.translation.width >= 0 {
                            offset = value.translation.width
                        } else {
                            offset = 0
                        }
                    }
                    
                    opacity = 1 - value.translation.width / swipeWidth
                    lockOpacity = value.translation.width / swipeWidth
                }
                .onEnded { value in
                    if value.translation.width >= swipeWidth - 54 - 32 {
                        withAnimation(.linear(duration: 0.1))  {
                            viewModel.isTrainingActive = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            offset = 0
                            lockOpacity = 0
                            opacity = 1
                        }
                    } else {
                        withAnimation {
                            offset = 0
                            lockOpacity = 0
                            opacity = 1
                        }
                    }
                }
        )
        .background(
            GeometryReader { geo in
                Color.clear.onAppear(perform: {
                    DispatchQueue.main.async {
                        swipeWidth = geo.size.width
                        offset = 0
                    }
                })
            }
        )
    }
    
    private var trainingSetting: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            RoundedRectangle(cornerRadius: 19)
                .fill(Color.c60606703)
                .frame(width: 36, height: 5)
                .padding(.vertical, 10)
                .frame(maxHeight: .infinity, alignment: .top)
            VStack(spacing: 8) {
                Text("Create a training")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 24)
                    .padding(.top, 10)
                
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        VStack(spacing: 12) {
                            Text("SPEED (KM/H)")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
                            TextField("", text: $viewModel.speed)
                                .font(.system(size: 50, weight: .regular))
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .onChange(of: viewModel.speed, perform: { newValue in
                                    speedValidation(newValue)
                                })
                                .keyboardType(.numberPad)
                        }
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
                        .frame(width: 170, height: 147)
                        .background(Color.white.opacity(0.05))
                        .clipShape(.rect(cornerRadius: 24))
                        VStack(spacing: 12) {
                            Text("DISTANCE (KM)")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
                            TextField("", text: $viewModel.distance)
                                .font(.system(size: 50, weight: .regular))
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .onChange(of: viewModel.distance, perform: { newValue in
                                    distanceValidation(newValue)
                                })
                                .keyboardType(.numberPad)
                        }
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
                        .frame(width: 170, height: 147)
                        .background(Color.white.opacity(0.05))
                        .clipShape(.rect(cornerRadius: 24))
                    }
                    VStack(spacing: 12) {
                        Text("TIME (MIN)")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                        TextField("", text: $viewModel.time)
                            .font(.system(size: 50, weight: .regular))
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .onChange(of: viewModel.time, perform: { newValue in
                                timeValidation(newValue)
                            })
                            .keyboardType(.numberPad)
                    }
                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
                    .frame(width: 170, height: 147)
                    .background(Color.white.opacity(0.05))
                    .clipShape(.rect(cornerRadius: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        viewModel.setupTimer()
                        showTraining = true
                        showTrainingSetting = false
                    } label: {
                        Text("GO")
                            .font(.body)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .frame(height: 50)
                            .background(viewModel.goButtonDisabled ? Color.c2442482551.opacity(0.12) : Color.primaryYellow)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    .disabled(viewModel.goButtonDisabled)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 16)
        }
    }
    
    func speedValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            viewModel.speed = filtered
        } else {
            viewModel.speed = ""
        }
    }
    func distanceValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            viewModel.distance = filtered
        } else {
            viewModel.distance = ""
        }
    }
    func timeValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            viewModel.time = filtered
        } else {
            viewModel.time = ""
        }
    }
    
    private var emptyTraining: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.c166166166.opacity(0.04))
                .frame(height: 113)
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.c166166166.opacity(0.04))
                .frame(height: 113)
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.c166166166.opacity(0.04))
                .frame(height: 113)
        }
        .overlay(
            (
            Text("Start your first\nworkout by clicking\non the “")
            +
            Text(Image(systemName: "timer"))
            +
            Text("” button. ")
            )
            .font(.title.bold())
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
        )
    }
    
    private var trainings: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.trainings, id: \.self) { training in
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 1)
                            .stroke(Color.white.opacity(0.2), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        Circle()
                            .trim(from: 0, to: min(Double(training.time) / Double(viewModel.dailyTrainingTime), 1) )
                            .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                        VStack(spacing: 5) {
                            Image(systemName: "hourglass.tophalf.filled")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 15)
                            Text("\(training.time) min")
                        }
                    }
                    .frame(width: 78, height: 78)
                    
                    VStack(spacing: 10) {
                        HStack {
                            Text("Training \(training.id)")
                                .font(.title3)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Button {
                                viewModel.remove(training)
                            } label: {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.c208208208.opacity(0.55))
                            }
                        }
                        
                        HStack(spacing: 7) {
                            HStack(spacing: 7) {
                                VStack(spacing: 10) {
                                    Text("Distance")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text(training.distance + " km")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 1, height: 42)
                            }
                            HStack(spacing: 7) {
                                VStack(spacing: 10) {
                                    Text("Speed")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text(training.distance + " km/h")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 1, height: 42)
                            }
                            HStack(spacing: 7) {
                                VStack(spacing: 10) {
                                    Text("Date")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text(dateToStr(training.date))
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 15)
                .frame(height: 113)
                .background(Color.white.opacity(0.1))
                .clipShape(.rect(cornerRadius: 14))
            }
            .padding(.bottom, 142)
        }
    }
    
    private func dateToStr(_ str: String) -> String {
        var line = ""
        let arr = str.components(separatedBy: "/")
        line += arr[2]
        line += " "
        var month = ""
        switch arr[1] {
        case "01": month = "Jan"
        case "02": month = "Feb"
        case "03": month = "Mar"
        case "04": month = "Apr"
        case "05": month = "May"
        case "06": month = "Jun"
        case "07": month = "Jul"
        case "08": month = "Aug"
        case "09": month = "Sep"
        case "10": month = "Oct"
        case "11": month = "Nov"
        case "12": month = "Dec"
        default: {}()
        }
        line += month
        return line
    }
    private var training: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.white.opacity(0.2), style: StrokeStyle(lineWidth: 18, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: viewModel.trimValue)
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 18, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    Image("ponyIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                    
                    Image(systemName: viewModel.isTrainingActive ? "pause.fill" : "play.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .onTapGesture {
                            if !viewModel.isTrainingActive {
                                withAnimation {
                                    viewModel.isTrainingActive = true
                                }
                            }
                        }
                }
                .frame(width: 183, height: 183)
                
                (
                    Text(viewModel.hoursLeft) +
                    Text(":" + viewModel.minutesLeft) +
                    Text(":" + viewModel.secondsLeft)
                )
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.top, 16)
                
                if viewModel.isTrainingActive {
                    swipeField
                } else {
                    swipeField.hidden()
                }
                
                trainingDetails
                    .padding(.top, 32)
                Button {
                    viewModel.stopButtonPressed()
                } label: {
                    Text("STOP")
                        .font(.body)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .frame(height: 50)
                        .background(viewModel.isTrainingActive ? Color.c2442482551.opacity(0.12) : Color.primaryYellow)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .disabled(viewModel.isTrainingActive)
                .padding(.top, 16)
            }
            .onReceive(viewModel.timer, perform: { _ in
                viewModel.decreaseTimer()
            })
            .padding(EdgeInsets(top: 61, leading: 16, bottom: 0, trailing: 16))
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    private var trainingEnd: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                Text("Training time is up")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                .padding(.top, 80)
                finalTrainingDetails
                    .padding(.top, 36)
                
                HStack(spacing: 10) {
                    Button {
                        viewModel.saveTraining()
                        viewModel.stop()
                        showTraining = false
                    } label: {
                        Text("Save")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.c626262)
                            .clipShape(.rect(cornerRadius: 25))
                    }
                    Button {
                        viewModel.stop()
                        viewModel.reset()
                        showTraining = false
                    } label: {
                        Text("Close")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.primaryYellow)
                        .clipShape(.rect(cornerRadius: 25))
                    }
                }
                .padding(.top, 16)
                
                Image("alarm")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 241, maxHeight: 241)
                    .padding(.top, 65)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    private var trainingDetails: some View {
        HStack(spacing: 11) {
            VStack(spacing: 10) {
                Image("lightning")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 32)
                Text(viewModel.speed + " km/h")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                Text("Speed")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(height: 118)
            .frame(maxWidth: 112)
            .background(Image("trainingDetailBackground")
                .resizable()
            )
            VStack(spacing: 10) {
                Image(systemName: "map.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 20, height: 32)
                Text(viewModel.distance + " km")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                Text("Distance")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(height: 118)
            .frame(maxWidth: 112)
            .background(Image("trainingDetailBackground")
                .resizable()
            )
            VStack(spacing: 10) {
                Image(systemName: "hourglass.tophalf.filled")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 20, height: 32)
                Text(viewModel.time + " min")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                Text("Time")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(height: 118)
            .frame(maxWidth: 112)
            .background(Image("trainingDetailBackground")
                .resizable()
            )
        }
    }
    private var finalTrainingDetails: some View {
        HStack(spacing: 11) {
            VStack(spacing: 10) {
                Image("lightning")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 32)
                Text(viewModel.speed + " km/h")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                Text("Speed")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(height: 118)
            .frame(maxWidth: 112)
            .background(Image("trainingDetailBackground")
                .resizable()
            )
            VStack(spacing: 10) {
                Image(systemName: "map.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 20, height: 32)
                Text(viewModel.distance + " km")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                Text("Distance")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(height: 118)
            .frame(maxWidth: 112)
            .background(Image("trainingDetailBackground")
                .resizable()
            )
            VStack(spacing: 10) {
                Image(systemName: "hourglass.tophalf.filled")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 20, height: 32)
                Text("\((viewModel.totalTime * 60 - viewModel.timerTime)/60)" + " min")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                Text("Time")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(height: 118)
            .frame(maxWidth: 112)
            .background(Image("trainingDetailBackground")
                .resizable()
            )
        }
    }
}

#Preview {
    TrainingView(viewModel: TrainingViewModel(dm: DataController()))
}

final class TrainingViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let dm: DataController
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var isTrainingActive = true
    @Published var trainingFullEnd = false
    
    @Published var timerTime: Int = 0
    var totalTime: Int = 0
    
    var goButtonDisabled: Bool {
        speed == "" || speed == "0" || distance == "" || distance == "0" || time == "" || time == "0"
    }
    
    var trimValue: Double {
        Double(timerTime) / Double(totalTime * 60)
    }
    
    var hoursLeft: String {
        let hours = timerTime / 3600
        let string = "\(timerTime / 3600)"
        if hours < 10 {
            return "0" + string
        } else {
            return string
        }
    }
    
    var minutesLeft: String {
        let minutes = timerTime / 60
        let string = "\(timerTime / 60)"
        if minutes < 10 {
            return "0" + string
        } else {
            return string
        }
    }
    
    var secondsLeft: String {
        let minutes = timerTime / 60
        let seconds = timerTime - (minutes * 60)
        if seconds < 10 {
            return "0" + "\(seconds)"
        } else {
            return "\(seconds)"
        }
    }
    
    @Published var dailyTrainingTime: Int = 30
    
    @Published var speed: String = "1"
    @Published var distance: String = "1"
    @Published var time: String = "1"
    
    @Published var trainings: Array<Training> = []
    
    private var trainingsCancellable: AnyCancellable?
    private var timeCancellable: AnyCancellable?
    
    init(dm: DataController) {
        self.dm = dm
        
        trainings = dm.trainings
        dailyTrainingTime = dm.dailyTrainingTime
        
        super.init()
        
        trainingsCancellable = dm.$trainings.sink { [weak self] value in
            self?.trainings = value
        }
        timeCancellable = dm.$dailyTrainingTime.sink { [weak self] value in
            self?.dailyTrainingTime = value
        }
    }
    
    func saveTraining() {
        let training = Training(id: dm.trainingId, speed: speed, distance: distance, time: (totalTime * 60 - timerTime)/60, date: dateToString(Date()), uuid: UUID())
        dm.saveTraining(training)
        reset()
    }
    
    private func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    func reset() {
        speed = "0"
        distance = "0"
        time = "0"
        trainingFullEnd = false
        isTrainingActive = true
    }
    
    func remove(_ training: Training) {
        dm.deleteTraining(training)
    }
    
    func setupTimer() {
        guard let time = Int(time) else { return }
        totalTime = time
        timerTime = time * 60
    }
    
    func decreaseTimer() {
        if timerTime > 0 && isTrainingActive {
            timerTime -= 1
        } else {
            if timerTime <= 0 && isTrainingActive {
                isTrainingActive = false
                trainingFullEnd = true
                setPlaying()
            }
        }
    }
    
    var player: AVAudioPlayer?
    func setPlaying() {
        guard let path = Bundle.main.path(forResource: "alarmSound", ofType: "mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.currentTime = 0
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stop() {
        player?.stop()
    }
    
    func stopButtonPressed() {
        trainingFullEnd = true
    }
}


