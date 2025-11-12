import SwiftUI

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

let bgColor = Color(red: 0.988, green: 0.988, blue: 0.996)
let linGradient = Gradient(colors: [Color(red: 0.271, green: 0.337, blue: 0.863), Color(red: 0.455, green: 0.580, blue: 1.00)])


// add


struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedFilters: [String] = []
    @State private var showAddSheet = false
    @State private var people: [Person] = [
        Person(name: "John Doe",
               locationMet : "iOS Club",
               major: "CS",
               dateMet: "11/01/2025",
               insta: "john_doe",
               tags: ["📚 Class", "🧩 Club"],
               description: "-cool\n-smart\n-funny")
    ]
    
    let categories = [
        ("📚", "Class", 4),
        ("👟", "Gym", 1),
        ("🧩", "Club", 6),
        ("🛏️", "Dorm", 2),
        ("🏫", "Week of Welcome", 2)
    ]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            bgColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("App name")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 16)
                
                // search
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    TextField("Search people...", text: $searchText)
                        .font(.system(size: 16))
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.white)
                .cornerRadius(67)
                .overlay(
                    RoundedRectangle(cornerRadius: 67)
                        .stroke(.black, lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                
                // filter by category
                VStack(alignment: .leading, spacing: 12) {
                    Text("Filter by category")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories, id: \.1) { emoji, name, count in
                                Button(action: {
                                    if selectedFilters.contains(name) {
                                        selectedFilters.removeAll { $0 == name }
                                    } else {
                                        selectedFilters.append(name)
                                    }
                                }) {
                                    HStack(spacing: 6) {
                                        Text(emoji)
                                            .font(.system(size: 16))
                                        Text("\(name) (\(count))")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(selectedFilters.contains(name) ? .white : .black)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 10)
                                    .background(
                                        selectedFilters.contains(name) ? Color(red: 0.353, green: 0.463, blue: 0.933) : .white
                                    )
                                    .cornerRadius(67)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 67)
                                            .stroke(selectedFilters.contains(name) ? Color(red: 0.271, green: 0.337, blue: 0.863) : .black, lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .padding(.bottom, 24)
                
                // people list
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(people) { person in
                            PersonCard(person: person)
                            
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 100)
                }
            }
            
            // floating '+' button
            Button(action: {
                showAddSheet = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64)
                
                    .background(
                        LinearGradient(
                            gradient: linGradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(67)
            }
            .padding(.trailing, 24)
            .padding(.bottom, 24)
            .sheet(isPresented: $showAddSheet) {
                AddPersonView { newPerson in
                    people.append(newPerson)
                }
            }
        }
    }
}


struct InfoRow: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.black.opacity(0.6))
            Text(text)
                .font(.system(size: 16))
                .foregroundColor(.black.opacity(0.8))
        }
    }
}
