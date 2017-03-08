//
//  Actividades.swift
//  Aplicacion
//
//  Created by Andres on 06/02/2017.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class Actividad {
    

    // MARK: Properties
    var id: Int
    var nombre : String
    var idProfesor: Int
    var nombreProfesor: String
    var departamento: String
    var descripcionCorta: String?
    var descripcionLarga: String?
    var grupo: String?
    var fecha: String
    var lugar: String?
    var horaInicio: String
    var horaFin: String
    var photo: UIImage?
    

    //MARK: Initialization

    
    init (_ diccionario: [ String : Any ]) {
        self.id = diccionario["id"] as! Int
        self.nombre = diccionario["nombre"] as! String
        self.idProfesor=diccionario["idProfesor"] as! Int
        self.nombreProfesor=diccionario["nombreProfesor"] as! String
        self.departamento=diccionario["departamento"] as! String
        self.descripcionCorta=diccionario["descripcionCorta"] as? String
        self.descripcionLarga=diccionario["descripcionLarga"] as? String
        self.grupo=diccionario["grupo"] as? String
        self.fecha=diccionario["fecha"] as! String
        self.lugar=diccionario["lugar"] as? String
        self.horaInicio=diccionario["horaInicio"] as! String
        self.horaFin=diccionario["horaFin"] as! String
    }
    
}
