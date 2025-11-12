//
//  UploadPhotos.swift
//  iosproject
//
//  Created by Jackie Hong on 11/11/25.
//

import SwiftUI
import PhotosUI

struct UploadPhotos : View {
    var body : some View {
        PhotoUploadView()
    }
}

struct PhotoUploadView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedItem : Image?
    @State private var imageDta: Data?
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
        }
        //.onChange(of: pickerItem) {
            
        }
    }
}


