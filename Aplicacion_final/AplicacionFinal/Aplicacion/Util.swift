//
//  Util.swift
//  Aplicacion
//
//  Created by dam on 8/2/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import Foundation

class Util{
    
    func dictToJson (data: [String:Any])->Data? {
        guard let json = try? JSONSerialization.data(withJSONObject: data as Any, options: []) else {
            return nil
        }
        return json
    }
    
    func jsonToDict (data: Data)-> [[String:Any]]? {
        print(data.description)
        guard let diccionario = try? JSONSerialization.jsonObject( with : data, options : []) as? [[String : Any ]] else {
            return nil
        }
        return diccionario
    }
    
    func getArrayActividadesFromJson (diccionario: [[String : Any ]]) -> [Actividad] {
        var actividades: [Actividad] = []
        
        for diccionarioActividad in diccionario {
            actividades.append (Actividad( diccionarioActividad))
        }
        return actividades
    }
    func getArrayProfesoresFromJson (diccionario: [[String : Any ]]) -> [Profesor] {
        var profesores: [Profesor] = []
 
        for diccionarioProfesor in diccionario {
            profesores.append (Profesor( diccionarioProfesor))
        }
        return profesores
    }

    
}
