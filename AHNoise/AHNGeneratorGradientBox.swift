//
//  AHNGeneratorGradientBox.swift
//  Noise Studio
//
//  Created by App Work on 07/07/2016.
//  Copyright © 2016 Andrew Heard. All rights reserved.
//

import UIKit
import simd


///Generates a box gradient texture comprising four linear gradients originating from the four texture edges.
///
///*Conforms to the `AHNTextureProvider` protocol.*
public class AHNGeneratorGradientBox: AHNGenerator {

  
  
  
  // MARK:- Properties
  
  
  ///The falloff of the gradients originating from the left and right hand texture edges. The default value of `0.0` results in the hoizontal gradients terminating at the centre of the texture, higher values cause the gradient to terminate closer to its originating edge.
  public var xFallOff: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  ///The falloff of the gradients originating from the top and bottom texture edges. The default value of `0.0` results in the vertical gradients terminating at the centre of the texture, higher values cause the gradient to terminate closer to its originating edge.
  public var yFallOff: Float = 0{
    didSet{
      dirty = true
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Initialiser
  
  
  required public init(){
    super.init(functionName: "boxGradientGenerator")
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // MARK:- Argument table update
  
  
  ///Encodes the required uniform values for this `AHNGenerator` subclass. This should never be called directly.
  override public func configureArgumentTableWithCommandencoder(commandEncoder: MTLComputeCommandEncoder) {
    var uniforms = GradientInputs(positions: vector_float4(xFallOff, yFallOff, 0, 0), offsetStrength: offsetStrength, rotations: vector_float3(xRotation, yRotation, zRotation))
    
    if uniformBuffer == nil{
      uniformBuffer = context.device.newBufferWithLength(strideof(GradientInputs), options: .CPUCacheModeDefaultCache)
    }
    
    memcpy(uniformBuffer!.contents(), &uniforms, strideof(GradientInputs))
    
    commandEncoder.setBuffer(uniformBuffer, offset: 0, atIndex: 0)
  }
}