//
//  Conection.swift
//  Aplicacion
//
//  Created by dam on 8/2/17.
//  Copyright © 2017 Andres. All rights reserved.
//
import UIKit


class Conection {
    
    
    // MARK: Properties
    let urlApi: String = "https://aplicacion-andres27695.c9users.io/pruebadoctrine/ios/"
    let respuesta: ResponseReceiver
    let sesion : URLSession
    var urlPeticion : URLRequest
    let util: Util
    //MARK: Initialization
    
    init?(target:String,responseObject:ResponseReceiver,_ method:String="GET",_ data : [String:Any] = [:]) {
        guard let url = URL( string : self.urlApi + target) else {
            return nil
        }
        self.respuesta = responseObject
        self.sesion = URLSession(configuration:URLSessionConfiguration.default)
        self.urlPeticion=URLRequest(url:url)
        self.urlPeticion.httpMethod = method
        self.util = Util()
        
        if method != "GET" && data.count > 0 {
            guard let json = util.dictToJson(data:data) else{
            return nil
        }
            self.urlPeticion.addValue("application/json",forHTTPHeaderField:"Content-Type")
            self.urlPeticion.httpBody=json
        }
    }
    
    func request(){
        let task = self.sesion.dataTask(with: self.urlPeticion, completionHandler: self.callBack)
        task.resume()
    }
    
    private func callBack (_ data:Data?, _ respuesta: URLResponse?, _ error: Error?) {
        DispatchQueue.main.async {
                guard error == nil else {
                    self.respuesta.onErrorReceivingData( message: "error")
                    return
                }
                guard let datos = data else {
                    self.respuesta.onErrorReceivingData ( message : "error datos")
                    return
                }
                self.respuesta.onDataReceived(data: datos)
        }
    }
    
    
        
}
