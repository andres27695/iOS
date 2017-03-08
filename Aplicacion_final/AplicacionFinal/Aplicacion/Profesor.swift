//
//  Profesor.swift
//  Aplicacion
//
//  Created by dam on 8/2/17.
//  Copyright © 2017 Andres. All rights reserved.
//
import UIKit

class Profesor {
    
    
    // MARK: Properties
    var id: Int
    var nombre : String
    var departamento : String
    
    
    //MARK: Initialization
    
    
    init (_ diccionario: [ String : Any ]) {
        self.id = diccionario["id"] as! Int
        self.nombre = diccionario["nombre"] as! String
        self.departamento = diccionario["departamento"] as! String
    }
    
}
