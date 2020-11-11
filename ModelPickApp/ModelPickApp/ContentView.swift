//
//  ContentView.swift
//  ModelPickApp
//
//  Created by Sam Goldfield on 11/10/20
//  From https://www.youtube.com/watch?v=9R_G0EI-UoI
//  Step 2

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        Text("Hello World")
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        

        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
