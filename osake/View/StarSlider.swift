//
//  StarSlider.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/06.
//

import SwiftUI

struct StarSlider: View {
    @Binding var evaluation: Double
    
    init(evaluation: Binding<Double>) {
        self._evaluation = evaluation
    }
    
    var body: some View {
        HStack {
            ForEach(1...floor(self.evaluation), id:\.self) { star in
                Image(systemName: "star.leadinghalf.fill").foregroundColor(.yellow)
            }
            if self.evaluation == 0.5 {
                Image(systemName: "star.leadinghalf.fill").foregroundColor(.yellow)
            }
            ForEach(self.floorevaluation...5, id:\.self) { colorlessstar in
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
