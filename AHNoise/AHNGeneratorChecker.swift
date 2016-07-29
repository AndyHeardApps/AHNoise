//
//  AHNGeneratorChecker.swift
//  Noise Studio
//
//  Created by App Work on 23/06/2016.
//  Copyright © 2016 Andrew Heard. All rights reserved.
//

import UIKit
import simd


///Generates a texture representing a slice through a field of alternating black and white cubes.
///
///*Conforms to the `AHNTextureProvider` protocol.*
public class AHNGeneratorChecker: AHNGenerator {
  
  
  // MARK:- Properties
  
  
  ///The frequency of the cubes, higher values result in more, closer packed cubes. The default value is `1.0`.
  public var frequency: Float = 1{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The value along the z axis that the texture slice is taken. The default value is `0.0`.
  public var zValue: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Initialiser
  
  
  required public init(){
    super.init(functionName: "checkerGenerator")
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Argument table update
  
  
  ///Encodes the required uniform values for this `AHNGenerator` subclass. This should never be called directly.
  override public func configureArgumentTableWithCommandencoder(commandEncoder: MTLComputeCommandEncoder) {
    var uniforms = GeometricInputs(offset: 0, frequency: frequency, xPosition: 0, yPosition: 0, zValue: zValue, offsetStrength: offsetStrength, rotations: vector_float3(xRotation, yRotation, zRotation))
    
    if uniformBuffer == nil{
      uniformBuffer = context.device.newBufferWithLength(strideof(GeometricInputs), options: .CPUCacheModeDefaultCache)
    }
    
    memcpy(uniformBuffer!.contents(), &uniforms, strideof(GeometricInputs))
    
    commandEncoder.setBuffer(uniformBuffer, offset: 0, atIndex: 0)
  }
}