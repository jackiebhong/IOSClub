import SwiftUI

struct AddPersonView: View {
    var onAdd: (Person) -> Void
    @Environment(\.dismiss) private var dismiss
    
    //add person variables
    @State private var newName : String = ""
    @State private var newLocation : String = ""
    @State private var newMajor : String = ""
    @State private var newDate : String = ""
    @State private var newInsta : String = ""
    @State private var newTags : String = ""
    @State private var newNotes : String = ""
    
    //add requirements
    @State private var showValidationError = false
    
    //photo upload variables
    @State private var showUpload = false
    @State private var photo: UIImage? = nil
    
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
                                    // upload photo code
                                    Text("Upload photo")
                                        .bold()
                                        .padding(.top)
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.gray.opacity(0.2))
                                            .frame(width: 120, height: 120)
                                            .padding(.trailing, 12)
                                            .overlay(
                                                Image(systemName: "person")
                                                    .font(.system(size: 75))
                                                    .foregroundColor(.gray)
                                                    .padding(.trailing, 12)
                                            )
                                        
                                        if let img = photo {
                                            Image(uiImage: img)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width:120, height:120)
                                                .clipShape(RoundedRectangle(cornerRadius:12))
                                                .padding(.trailing, 12)
                                        }
                                        Button {
                                            showUpload = true
                                        } label: {
                                            Color.clear.frame(width:120, height:120)
                                        }
                                        .sheet(isPresented: $showUpload) {
                                            UploadPhotos(selectedImage: $photo)
                                        }
                                    }
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
                                    Button {
                                        if newName.trimmingCharacters(in: .whitespaces).isEmpty {
                                            showValidationError = true
                                        } else {
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
                                                imageData: photo?.jpegData(compressionQuality: 0.9),
                                                description: newNotes
                                            )
                                                onAdd(newPerson)
                                                dismiss()
                                        }
                                    } label: {
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
                                    .alert("Missing name", isPresented: $showValidationError) {
                                        Button("OK", role: .cancel) {}
                                    } message: {
                                        Text("Please enter a name before adding your friend")
                                    }
                                    
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
