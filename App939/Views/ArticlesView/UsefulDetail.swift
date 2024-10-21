import SwiftUI

struct UsefulDetail: View {
    
    let article: UsefulArticle
    let back: () -> Void
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 22) {
                Image(article.imageName)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: UIScreen.main.bounds.width, height: 252)
                    .clipped()
                    .overlay(LinearGradient(colors: [.basicGradient1, .basicGradient2], startPoint: .top, endPoint: .bottom))
                    .overlay(
                        Text(article.name)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .padding(.top, 100)
                    )
                    .overlay(nav, alignment: .top)
                    .ignoresSafeArea()
                
                ScrollView(.vertical) {
                    Text(article.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.leading)
                        .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 16))
                        .background(Color.white.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 6))
                        .padding(.horizontal, 30)
                        .padding(.bottom, 50)
                }
                .ignoresSafeArea()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
        }
    }
    private var nav: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 19)
                .fill(Color.c60606703)
                .frame(width: 36, height: 5)
                .padding(.vertical, 10)
            ZStack {
                Button {
                    back()
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primaryYellow)
                        
                        Text("Back")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.primaryYellow)
                    }
                    .padding(.horizontal, 8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(
                    Text("Useful")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                )
                
            }
        }
    }
}

#Preview {
    UsefulDetail(article: UsefulArticle(imageName: "a1", name: "Pony Stunt Training: Basic principles and training methods", description: 
          """
          Training a pony can be a rewarding experience, forging a strong bond between you
          and your equine friend. But it’s crucial to approach training with care and respect for
          the pony’s well-being. This guide outlines the essential steps to get started with pony
          training, ensuring a positive experience for both of you.
          1. Building a Foundation of Trust:
          • Respectful Handling: Always treat your pony with kindness and patience.
          Avoid harsh words or physical punishment. Use gentle voice commands and
          positive reinforcement.
          • Groundwork: Before mounting, establish a strong foundation of groundwork.
          Teach basic commands like “come,” “stand,” “back up,” and “walk on.” Use
          treats and praise for positive responses.
          • Desensitization: Gradually introduce your pony to various stimuli, like loud
          noises, different objects, and new environments. This helps build confidence
          and prevent fear-based reactions.
          2. Mastering the Basics:
          • Leading: Ensure your pony is comfortable being led with a halter and lead
          rope. Teach them to walk calmly alongside you.
          • Mounting: Choose a safe and comfortable mounting spot. Practice mounting
          and dismounting without the saddle first to ensure your pony is comfortable.
          • Basic Riding Skills: Start with short, relaxed rides in a safe, enclosed area.
          Focus on maintaining a steady pace and guiding the pony with gentle leg cues
          and rein pressure.
          • Stopping: Teach your pony to stop on command using a gentle pull on the
          reins and a light voice cue.
          3. Progressing with Patience:
          • Progressive Training: Gradually introduce new exercises and increase the
          difficulty level as your pony progresses.
          • Varied Activities: Engage in activities beyond basic riding, such as
          groundwork games, obstacle courses, or trail riding.
          • Regular Training Sessions: Short, frequent sessions are more effective than
          long, infrequent ones. Keep your pony engaged and maintain consistency in
          your training.
          4. Safety First:
          • Proper Equipment: Use a well-fitting saddle, bridle, and halter specifically
          designed for ponies.
          • Safe Environment: Choose a safe and suitable riding area. Avoid obstacles
          and potentially dangerous areas.
          • First Aid Kit: Be prepared with a basic first aid kit for minor injuries.
          • Professional Help: If you encounter any difficulties or concerns, consult a
          qualified horse trainer or veterinarian.
          5. Enjoy the Journey:
          • Bonding: Training is an excellent opportunity to strengthen your bond with
          your pony.
          • Communication: Learn to understand your pony’s body language and
          communicate effectively.
          • Celebrate Success: Acknowledge and reward your pony’s progress, no matter
          how small.
          Remember: Every pony is unique, and the pace of training will vary. Be patient,
          understanding, and consistent in your approach. By building a solid foundation of
          trust and applying these guidelines, you’ll ensure a safe and rewarding journey for
          you and your pony.
          """
                                       ), back: {}
    )
}
