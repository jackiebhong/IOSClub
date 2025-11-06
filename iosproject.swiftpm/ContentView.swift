import SwiftUI

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

let bgColor = Color(red: 0.988, green: 0.988, blue: 0.996)
let linGradient = Gradient(colors: [Color(red: 0.271, green: 0.337, blue: 0.863), Color(red: 0.455, green: 0.580, blue: 1.00)])

struct Person: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var locationMet: String
    var major: String
    var dateMet: String
    var insta: String
    var tags: [String]
    
    init(name: String = "No Name",
        locationMet: String = "",
        major: String = "",
        dateMet: String = "01/01/2025",
        insta: String = "",
        tags: [String] = [])  {
        self.name = name.isEmpty ? "No Name" : name
        self.locationMet = locationMet
        self.major = major
        self.dateMet = dateMet
        self.insta = insta
        self.tags = tags
    }
    
}


struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedFilters: [String] = []
    
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
                        PersonCard(person: Person(name: "John Doe", locationMet: "iOS Club", major: "CS", dateMet: "11/01/2025", insta: "john_doe",
                            tags: ["📚 Class", "🧩 Club"]))
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 100)
                }
            }
            
            // floating '+' button
            Button(action: {
                // go to add new person screen
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
        }
    }
}

struct PersonCard: View {
    var person: Person
    
    var body: some View {
        
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 4) {
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray.opacity(0.2))
                    .frame(width: 120, height: 120)
                    .padding(.trailing, 12)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(person.name)
                        .font(.system(size: 24, weight: .bold))
                    
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                        Text(person.locationMet)
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "book.closed")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                        Text(person.major)
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                        Text("Met \(person.dateMet)")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "at")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                        Text(person.insta)
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // navigate to add new person screen
                }) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(90))
                        
                }
                .padding(.top, 12)
                
            }
            
            // tags
            HStack(spacing: 12) {
                ForEach(person.tags, id: \.self) { tagName in
                    TagView(label: tagName)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(16)
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black, lineWidth: 1)
        )
        
    }
}


struct TagView: View {
    let label: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(.white)
        .cornerRadius(67)
        .overlay(
            RoundedRectangle(cornerRadius: 67)
                .stroke(.black, lineWidth: 1)
        )
    }
}
