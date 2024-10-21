import Foundation
import Combine

final class ArticlesViewModel: ObservableObject {
    
    let dm: DataController
    
    let usefulArticles: Array<UsefulArticle> = [
        UsefulArticle(imageName: "a1", name: "Pony Training Basics: How to Get Started Safely and Effectively", description: 
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
        ),
        UsefulArticle(imageName: "a2", name: "Building Endurance in Your Pony: A Training Guide", description: 
        """
        Training your pony for endurance requires a thoughtful approach that prioritizes
        both their physical and mental well-being. Building stamina gradually is essential for
        preventing injury and promoting a long, healthy partnership. Here’s a comprehensive
        guide to developing your pony’s endurance:
        1. Assess Your Pony’s Current Fitness:
        • Veterinary Check-Up: Consult with your veterinarian to ensure your pony is
        healthy enough for endurance training. They can identify any underlying
        conditions that may need to be addressed before starting.
        • Basic Fitness: Observe your pony’s current fitness level. Can they walk, trot,
        and canter comfortably? Are they able to maintain a steady pace for short
        periods?
        • Age and Breed: Consider your pony’s age and breed. Younger ponies and
        certain breeds may require a slower progression than others.
        2. Gradual Progression is Key:
        • Start Slow: Begin with short, relaxed sessions focusing on walk and trot.
        Gradually increase the duration and intensity as your pony builds stamina.
        • Increase Distance: Incrementally increase the distance covered during rides.
        Aim for small increases (e.g., an extra quarter mile per session) to avoid
        overexertion.
        • Vary Terrain: Introduce gentle hills and varied terrain to challenge your
        pony’s muscles and cardiovascular system.
        3. Incorporate Different Training Methods:
        • Interval Training: Alternate between periods of high-intensity work (e.g.,
        cantering) and periods of recovery (e.g., walking).
        • Hill Work: Include short hill climbs to strengthen your pony’s hindquarters
        and improve cardiovascular fitness.
        • Long Slow Distance (LSD): Engage in extended rides at a slower pace to
        build endurance and stamina.
        4. Proper Nutrition and Rest:
        • High-Quality Feed: Provide your pony with a balanced diet that includes
        adequate forage and a quality grain supplement.
        • Hydration: Ensure your pony has access to fresh water throughout the day
        and during rides.
        • Rest and Recovery: Allow your pony sufficient rest between training sessions.
        A well-rested pony is less prone to injury.
        5. Mindful Training:
        • Pay Attention to Your Pony: Be aware of their body language and behavior.
        Observe any signs of fatigue, such as reluctance to move, heavy breathing, or
        stumbling.
        • Listen to Their Body: Adjust the intensity or duration of training if your pony
        shows signs of strain.
        • Professional Guidance: Consider seeking guidance from an experienced
        horse trainer or equine veterinarian if you’re unsure about your pony’s fitness
        or training program.
        6. Enjoy the Journey:
        • Positive Reinforcement: Reward your pony for their effort and progress with
        praise, treats, and gentle stroking.
        • Bonding: Endurance training strengthens the bond between you and your
        pony as you work together towards a common goal.
        Remember, building endurance in your pony is a gradual process. Be patient,
        consistent, and attentive to your pony’s needs. By following these guidelines, you can
        help your pony achieve peak fitness, enhancing both their well-being and your
        enjoyment of riding together.
        """),
        UsefulArticle(imageName: "a3", name: "Teaching Tricks to Your Pony: Principles and Training Methods", description: 
        """
        Training your pony to perform tricks can be a fun and rewarding experience,
        strengthening your bond and creating unique moments together. While it may seem
        daunting at first, applying the right principles and techniques can make the process
        enjoyable for both of you.
        1. Laying a Solid Foundation:
        • Respectful Relationship: Build a strong foundation of trust and respect with
        your pony. Positive reinforcement, patience, and consistent training are key.
        • Basic Obedience: Ensure your pony responds to basic commands like “come,”
        “stand,” “back up,” and “walk on.” This forms the basis for learning more
        complex tricks.
        • Body Language Awareness: Understand your pony’s body language and
        learn to read their cues. This helps you recognize when they’re comfortable
        and avoid pushing them beyond their limits.
        2. Start with Simple Tricks:
        • Target Training: Use a target (e.g., a small stick or a light) to guide your
        pony’s movements. This helps them understand the desired action.
        • Positive Reinforcement: Reward your pony’s attempts, even if they’re not
        perfect, with treats, praise, and gentle stroking.
        • Keep It Short and Sweet: Short, frequent training sessions are more effective
        than long, infrequent ones. Avoid overwhelming your pony.
        3. Trick Training Techniques:
        • Shaping: Break down complex tricks into smaller, achievable steps. Reward
        each successful step, gradually building towards the final trick.
        • Clicker Training: Using a clicker as a marker for a desired behavior can be
        effective. Click at the exact moment the pony performs the action correctly,
        followed by a treat.
        • Luring: Use a treat or a toy to guide your pony into performing the desired
        action. Gradually reduce the lure’s influence as they learn.
        4. Important Considerations:
        • Pony’s Comfort: Never force your pony into performing a trick. If they show
        resistance or discomfort, stop and try again later.
        • Safety First: Ensure the trick is safe for both you and your pony. Avoid tricks
        that could cause injury.
        • Variety: Introduce different tricks to keep your pony engaged and challenged.
        • Patience and Persistence: Be patient and persistent. Learning new tricks
        takes time, so stay consistent and celebrate even small successes.
        5. Trick Ideas:
        • Basic Tricks: Bowing, pawing, shaking their head, picking up a toy.
        • Intermediate Tricks: Standing on a pedestal, walking in circles, backing up in
        a straight line.
        • Advanced Tricks: Jumping through hoops, balancing objects, playing “dead.”
        Remember: Training a pony to perform tricks is a journey of discovery and bonding.
        Enjoy the process, celebrate your pony’s achievements, and most importantly, have
        fun along the way!
        """),
        UsefulArticle(imageName: "a4", name: "Fueling Your Pony’s Performance: The Role of Nutrition in Training", description: 
        """
        Just like athletes, ponies require a balanced diet to fuel their performance and
        support their training regimen. Proper nutrition is essential for building and
        maintaining muscle, ensuring adequate energy levels, and promoting overall health.
        Here’s a breakdown of how nutrition plays a crucial role in your pony’s training
        journey:
        1. The Foundation of Fitness:
        • Forage First: High-quality forage, such as hay or pasture grass, should form
        the foundation of your pony’s diet. It provides essential fiber, which aids
        digestion, promotes gut health, and keeps their digestive system functioning
        optimally.
        • Balanced Grains: Grains, such as oats, corn, and barley, offer additional
        energy and can be included in moderation to supplement forage. The amount
        should be tailored to your pony’s activity level.
        • Nutritional Supplements: In some cases, your veterinarian may recommend
        supplemental vitamins and minerals to ensure your pony is receiving all the
        nutrients they need, especially during periods of intense training.
        2. Meeting Energy Demands:
        • Training Intensity: The amount of energy your pony needs will vary
        depending on their training intensity and duration. More strenuous workouts
        require a higher calorie intake to fuel their muscles and recover effectively.
        • Performance Enhancement: A well-nourished pony will have the energy
        reserves to perform at their best during training sessions. Adequate
        carbohydrates provide the quick energy needed for intense work, while fats
        provide sustained energy for longer rides.
        3. Muscle Building and Recovery:
        • Protein Power: Protein is essential for muscle growth and repair. Ensure your
        pony gets enough protein through their diet to support muscle development
        and recovery after exercise.
        • Essential Nutrients: Vitamins and minerals, particularly those like B vitamins,
        vitamin E, and selenium, play vital roles in muscle function and recovery.
        4. Hydration is Key:
        • Water is Vital: Access to fresh water throughout the day and during rides is
        crucial for hydration. Dehydration can negatively impact performance and
        even lead to health issues.
        • Electrolytes: During periods of intense exercise, your pony may lose
        electrolytes through sweat. Consider offering an electrolyte supplement to
        replenish these essential minerals.
        5. Important Considerations:
        • Individual Needs: Each pony’s nutritional needs may vary slightly. Consult
        with your veterinarian to create a personalized feeding plan based on your
        pony’s age, breed, activity level, and any specific health conditions.
        • Gradual Changes: Avoid making sudden changes to your pony’s diet, as this
        can upset their digestive system. Introduce new feeds or supplements
        gradually to allow their digestive system to adapt.
        • Monitoring: Observe your pony’s weight, coat condition, and energy levels to
        ensure their diet is meeting their needs. If you notice any changes, consult
        with your veterinarian.
        Remember: Proper nutrition is an integral part of training your pony. By providing a
        balanced and tailored diet, you can support their physical performance, promote
        their overall health, and ensure a long and enjoyable partnership.
        """),
        UsefulArticle(imageName: "a5", name: "Focusing on essential equipment and organizing your riding sessions", description:
                        """
                        Pony riding can be a fantastic hobby, offering a unique connection with these
                        adorable equine companions. Whether you’re a seasoned rider or a complete
                        beginner, starting a pony riding hobby can be both enjoyable and rewarding. Here’s
                        a guide to help you get started, focusing on essential equipment and organizing
                        your riding sessions:
                        1. Choosing the Right Pony:
                        • Size and Temperament: Opt for a pony that’s appropriately sized for you. A
                        pony that’s too small or too large can make riding uncomfortable and
                        potentially dangerous. Consider the pony’s temperament as well, ensuring a
                        gentle and safe nature.
                        • Experience Level: If you’re a beginner, a well-trained, experienced pony is a
                        good choice. They can provide guidance and confidence as you develop your
                        riding skills.
                        • Personality Match: Spend time with different ponies to find one that you
                        connect with. A compatible personality and a comfortable bond are essential
                        for a positive riding experience.
                        2. Essential Riding Equipment:
                        • Saddle and Bridle: Choose a saddle and bridle that are specifically designed
                        for ponies, ensuring a comfortable fit and safe use. Opt for a saddle with
                        appropriate stirrups and a bridle with a well-fitting bit.
                        • Helmet: A properly fitting helmet is crucial for safety. Choose a helmet that
                        meets safety standards and fits snugly on your head.
                        • Boots or Shoes: Wear sturdy boots or shoes that offer ankle support. Avoid
                        loose footwear that can become caught in the stirrups.
                        • Riding Gloves: Gloves provide a better grip on the reins and protect your
                        hands from blisters.
                        • Protective Gear: Consider adding additional protective gear, such as a body
                        protector, especially when learning new skills or riding in challenging terrain.
                        3. Organizing Your Riding Sessions:
                        • Safe Environment: Choose a safe and suitable riding area, preferably with a
                        fenced-in area or an arena. Avoid obstacles and potentially dangerous areas.
                        • Supervision: If you’re a beginner, seek guidance from a qualified riding
                        instructor or experienced rider. They can provide valuable lessons and ensure
                        your safety.
                        • Consistency: Regular riding sessions, even if they’re short, are important for
                        maintaining fitness and building your confidence.
                        • Gradual Progression: Start with basic riding skills, such as walking, trotting,
                        and stopping. Gradually introduce new skills and challenges as you become
                        more comfortable.
                        4. Enjoy the Journey:
                        • Bonding: Pony riding is a wonderful way to build a strong bond with your
                        equine friend. Spend time grooming, caring for, and simply being with your
                        pony.
                        • Relax and Have Fun: Don’t forget to relax and enjoy the experience. Pony
                        riding should be a fun and rewarding hobby.
                        5. Additional Tips:
                        • Respect: Always treat your pony with kindness and respect. Use gentle voice
                        commands and positive reinforcement.
                        • Safety First: Safety is paramount. Always prioritize safe practices and wear
                        appropriate protective gear.
                        • Professional Guidance: If you have any questions or concerns, consult a
                        qualified riding instructor or veterinarian.
                        Pony riding offers a unique and fulfilling hobby. By choosing the right pony,
                        acquiring appropriate equipment, and organizing your sessions effectively, you can
                        embark on a rewarding journey of exploration and connection with these amazing
                        creatures.
                        """
                     )
    ]
    
    @Published var articles: Array<Article> = []
    var usefulArticleForShow: UsefulArticle?
    var articleForShow: Article?
    
    var articlesCancellable: AnyCancellable?
    
    init(dm: DataController) {
        self.dm = dm
        
        articlesCancellable = dm.$articles.sink { [weak self] value in
            self?.articles = value
        }
    }
}

struct UsefulArticle: Hashable {
    let imageName: String
    let name: String
    let description: String
}
