import SwiftUI

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

let bgColor = Color(red: 0.988, green: 0.988, blue: 0.996)
let linGradient = Gradient(colors: [Color(red: 0.271, green: 0.337, blue: 0.863), Color(red: 0.455, green: 0.580, blue: 1.00)])


// add
struct Tag: Identifiable, Hashable {
    var id = UUID()
    var emoji: String
    var name: String
    var isSelected: Bool = false
}


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

struct PersonCard: View {
    var person: Person
    @State private var showprofilecard = false
    @State private var people: [Person] = [
        Person(name: "John Doe",
               locationMet : "iOS Club",
               major: "CS",
               dateMet: "11/01/2025",
               insta: "john_doe",
               tags: ["📚 Class", "🧩 Club"],
               description: "-cool\n-smart\n-funny")
    ]
    
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
                    showprofilecard = true
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
        .sheet(isPresented: $showprofilecard) {
            PersonProfileCard(person: person)
        }
        
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

struct AddPersonView: View {
    var onAdd: (Person) -> Void
    @Environment(\.dismiss) private var dismiss
    
    @State private var newName : String = ""
    @State private var newLocation : String = ""
    @State private var newMajor : String = ""
    @State private var newDate : String = ""
    @State private var newInsta : String = ""
    @State private var newTags : String = ""
    @State private var newNotes : String = ""
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack (alignment: .leading){
                    VStack (alignment: .leading){
                        HStack{
                            Text("Add new friend")
                                .font(.largeTitle)
                                .bold()
                                .padding(.top, 20)
                                .padding(.bottom, 16)
                                
                            Spacer ()
                                
                            Button {
                                dismiss()
                            } label : {
                                Image(systemName: "xmark")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(10)
                            }
                        }
                        }
                        VStack (alignment: .leading){
                            ZStack {
                                VStack (alignment: .leading){
                                    Text("Upload photo")
                                        .bold()
                                        .padding(.top)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.gray.opacity(0.2))
                                        .frame(width: 120, height: 120)
                                        .padding(.trailing, 12)
                                    HStack{
                                        Text("Name")
                                            .padding(.top)
                                            .bold()
                                        Text("*")
                                            .padding(.top)
                                            .bold()
                                            .foregroundColor(.blue)
                                    }
                                    
                                    TextField("John Doe", text: $newName)
                                        .padding(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                            .stroke(.black, lineWidth: 1))
                                    Text("Where You Met")
                                        .padding(.top)
                                        .bold()
                                    TextField("iOS Club", text: $newLocation)
                                        .padding(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                            .stroke(.black, lineWidth: 1))
                                    Text("Major")
                                        .padding(.top)
                                        .bold()
                                    TextField("Computer Science", text: $newMajor)
                                        .padding(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                            .stroke(.black, lineWidth: 1))
                                    Text("Date Met")
                                        .padding(.top)
                                        .bold()
                                    TextField("mm/dd/yyyy", text: $newDate)
                                        .padding(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                            .stroke(.black, lineWidth: 1))
                                    Text("Instagram")
                                        .padding(.top)
                                        .bold()
                                    TextField("@username", text: $newInsta)
                                        .padding(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                            .stroke(.black, lineWidth: 1))
                                    HStack {
                                        Text("Tags")
                                            .bold()
                                            .padding(.top)
                                        Text("*")
                                            .padding(.top)
                                            .bold()
                                            .foregroundColor(.blue)
                                    }
                                    VStack{
                                        HStack {
                                            
                                        }
                                        TextField("New tag name", text: $newTags)
                                            .padding(12)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                .stroke(.black, lineWidth: 1))
                                    }
                                    Text("Additional Notes")
                                        .bold()
                                        .padding(.top)
                                    ZStack{
                                        TextEditor(text: $newNotes)
                                            .frame(height: 100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                .stroke(.black, lineWidth: 1))
                                            .overlay(
                                                Group {
                                                    if newNotes.isEmpty {
                                                        TextField("Interests, what you talked about, etc...", text: $newNotes)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                    .frame(width: 350, height: 80, alignment:.topLeading)
                                            )
                                    }
                                    Button(action: {
                                        let tagArray = newTags
                                            .split(separator: ",")
                                            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
                                        let newPerson = Person(
                                            name: newName,
                                            locationMet: newLocation,
                                            major: newMajor,
                                            dateMet: newDate,
                                            insta: newInsta,
                                            tags: tagArray,
                                            description: newNotes
                                        )
                                            onAdd(newPerson)
                                            dismiss()
                                        })
                                    {
                                        Text("Add Friend!")
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 40)
                                            .padding(.vertical, 14)
                                            .background(.blue)
                                            .cornerRadius(67)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, 20)
                                    
                                }
                            }
                        }
                }
                .padding(16)
                .background(.white)
                .cornerRadius(16)
            }
        }
        Spacer()
    }
}

struct PersonProfileCard: View {
    var person: Person
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    // Header
                    HStack {
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.black)
                                .padding(10)
                                
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30) // optional, for spacing from top
                    
                    HStack {
                        Text(person.name)
                            .font(.system(size: 32, weight: .bold))
                            .frame(alignment: .center)
                    }
                    .padding(.horizontal, 24)
                    
                    // Photo placeholder
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray.opacity(0.15))
                        .frame(width: 180, height: 180)
                    
                    // Tags
                    HStack(spacing: 8) {
                        ForEach(person.tags, id: \.self) { tagName in
                            TagView(label: tagName)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
                    
                    // Info section
                    VStack(alignment: .leading, spacing: 12) {
                        InfoRow(icon: "mappin.and.ellipse", text: person.locationMet)
                        InfoRow(icon: "book.closed", text: person.major)
                        InfoRow(icon: "calendar", text: "Met \(person.dateMet)")
                        InfoRow(icon: "at", text: person.insta)
                    }
                    .padding(.horizontal, 24)
                    
                    // Description section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notes")
                            .font(.system(size: 18, weight: .semibold))
                        Text(person.description)
                            .font(.system(size: 16))
                            .foregroundColor(.black.opacity(0.7))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .background(.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.black, lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    
                    Spacer(minLength: 50)
                }
                .padding(.bottom, 30)
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
