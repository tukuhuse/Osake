//
//  StarSlider.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/06.
//

/*
import SwiftUI
import Foundation

struct StarSlider: View {
    @Binding var evaluation: Double
    @State var intevaluation: Int
    @State var decimaleflag: Bool
    
    init(evaluation: Binding<Double>) {
        self._evaluation = evaluation
        self.intevaluation = Int(evaluation)
        self.decimaleflag = evaluation - Double(self.intevaluation) == 0 ? true : false
    }
    
    var body: some View {
        HStack {
            ForEach(0..<self.intevaluation) { star in
                Image(systemName: "star.leadinghalf.fill").foregroundColor(.yellow)
            }
            if self.decimaleflag {
                Image(systemName: "star.leadinghalf.fill").foregroundColor(.yellow)
            }
            ForEach(self.intevaluation+1..<6) { colorlessstar in
                Image(systemName: "star.fill")
            }
        }
    }
}

struct StarSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        StarSlider(evaluation: .constant(2.5))
    }
}
*/
