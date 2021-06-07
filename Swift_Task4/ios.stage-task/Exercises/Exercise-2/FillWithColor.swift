import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        var numToFill: Int?
        
        for (rIndex, r) in image.enumerated() {
            if (rIndex == row) {
                for (cIndex, _) in r.enumerated() {
                    if (cIndex == column) {
                        numToFill = image[rIndex][cIndex];
                        break;
                    }
                }
            }
        }
        
        if (numToFill == nil) {
            return image;
        }
        
        var result = image;
        
        for rIndex in 0..<image.count {
            let r = image[rIndex];

            for cIndex in 0..<r.count {
                if (rIndex == row && cIndex == column) {
                    result[rIndex][cIndex] = newColor;
                    
                    if (rIndex - 1 >= 0 && image[rIndex - 1][cIndex] == numToFill!) {
                        result[rIndex - 1][cIndex] = newColor;
                    }
                    
                    if (rIndex + 1 < image.count && image[rIndex + 1][cIndex] == numToFill!) {
                        result[rIndex + 1][cIndex] = newColor;
                    }
                    var tempCIndex = cIndex - 1;
                    
                    while (tempCIndex >= 0 && image[rIndex][tempCIndex] == numToFill!) {
                        result[rIndex][tempCIndex] = newColor;
                        tempCIndex -= 1;
                    }
                    
                    tempCIndex = cIndex + 1;
                    while (tempCIndex < image[rIndex].count && image[rIndex][tempCIndex] == numToFill!) {
                        result[rIndex][tempCIndex] = newColor;
                        tempCIndex += 1;
                    }
                }
                        
            }
        }
        
        return result;
    }
}
