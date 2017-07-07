//
//  HHDicomFile.swift
//  HHDicom
//
//  Created by iOS on 2017/4/20.
//  Copyright © 2017年 HH. All rights reserved.
//

import ObjectMapper

struct DicomFile: Mappable
{
    var fileName: String?
    var width: Int = 0
    var height: Int = 0
    var pixelData: [Int] = []
    var ww: Int = 0
    var wl: Int = 0
    var se: Int = 0
    var im: Int = 1
    var hospital: String?
    var patient: String?
    var sex: String?
    var age: String?
    var study: String?
    var date: String?
    var signedImg:Bool = false
    var bitsAllocated: Int = 0
    var samplesPerPixel: Int = 0
    var pixelSpacingX: Float = 0
    var pixelSpacingY: Float = 0
    var maxPixel: Int = 0
    var minPixel: Int = 0
    var bwReverse: Bool = false
    var planarConfiguration: Int = 0
    var photometricInterpretation: String?
    
    
    init?(map: Map)
    {
        
    }
    
    mutating func mapping(map: Map)
    {
        fileName  <- map["fileName"]
        width  <- map["width"]
        height <- map["height"]
        pixelData <- map["pixelData"]
        ww <- map["ww"]
        wl <- map["wl"]
        se <- map["se"]
        im <- map["im"]
        hospital <- map["hospital"]
        patient <- map["patient"]
        sex <- map["sex"]
        age <- map["age"]
        study <- map["study"]
        date <- map["date"]
        signedImg <- map["signedImg"]
        bitsAllocated <- map["bitsAllocated"]
        samplesPerPixel <- map["samplesPerPixel"]
        pixelSpacingX <- map["pixelSpacingX"]
        pixelSpacingY <- map["pixelSpacingY"]
        maxPixel <- map["maxPixel"]
        minPixel <- map["minPixel"]
        bwReverse <- map["bwReverse"]
        planarConfiguration <- map["planarConfiguration"]
        photometricInterpretation <- map["photometricInterpretation"]
    }
    
    
    
    func offset() ->Int
    {
        return minPixel < 0 ? 0 - minPixel : -minPixel
    }
    
}
