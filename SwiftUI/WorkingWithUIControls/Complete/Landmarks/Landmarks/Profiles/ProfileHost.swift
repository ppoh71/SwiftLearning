/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var mode
    @State var profile = Profile.default
    @State var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button(action: {
                        self.profile = self.draftProfile
                        self.mode?.animation().wrappedValue = .inactive
                    }) {
                        Text("Done")
                    }
                }
                
                Spacer()
                
                EditButton()
            }
            if self.mode?.wrappedValue == .inactive {
                ProfileSummary(profile: profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onDisappear {
                        self.draftProfile = self.profile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
