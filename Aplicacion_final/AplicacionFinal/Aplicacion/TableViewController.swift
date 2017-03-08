//
//  TableViewController.swift
//  Aplicacion
//
//  Created by Andres on 06/02/2017.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController , ResponseReceiver{
    
    @IBOutlet weak var filtrar: UIBarButtonItem!
    
    //MARK: Properties
    
     var actividades:[Actividad] = []
    let util: Util = Util()
    var diccionario: [[String : Any]] = [[:]]
    var selectedRow:Int=0
    var diccionarioActividadID:[String:Int]=[:]
    //MARK: Private Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(loadSampleActividad())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func loadSampleActividad(){
        guard let conexion = Conection (target: "actividad", responseObject : self) else {
            return
        }
        conexion.request()
        
    }
    func onDataReceived (data: Data) {
        guard let diccionario = util.jsonToDict (data: data) else {
            return
        }
        
        self.diccionario=diccionario
        
        self.actividades = util.getArrayActividadesFromJson(diccionario: diccionario )
        let photo1 = UIImage(named:"Image")
        for i in stride ( from : 0, to:self.actividades.count, by: 1) {
            self.actividades[i].photo=photo1
        }
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
            print("Recargo la tabla de actividades")
        }
        
    }
    func onErrorReceivingData ( message : String ) {
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="filtrarSegue"){
            guard let vista:ViewController=segue.destination as? ViewController else{
                return
            }
            vista.actividades=self.actividades
            
        }else if(segue.identifier=="agregarSegue"){
            guard let vista:ViewControllerAddEdit=segue.destination as? ViewControllerAddEdit else{
                return
            }
            vista.actividad=nil
            
        }else if(segue.identifier=="ShowDetail"){
            guard let vista:ViewControllerAddEdit=segue.destination as? ViewControllerAddEdit else{
                return
            }
            guard let celdaSeleccionada:TableViewCell = sender as? TableViewCell else{
                return
            }
            vista.actividad=self.actividades[(tableView.indexPath(for: celdaSeleccionada)?.row)! ]
            
        }
        /*guard let vista:ViewController=segue.destination as? ViewController else{
         guard let vista:ViewControllerAddEdit=segue.destination as! ViewControllerAddEdit else{
         return
         }
         return
         }
         vista.actividades=self.actividades
         print(vista.actividades)
         print("actividades enviadas")
         */

        
    }
    
    @IBAction func vuelta(segue: UIStoryboardSegue){
        self.actividades.removeAll()
        loadSampleActividad()
    }
    
    
    // MARK: - Table view data source
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     
     return 1
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
     return actividades.count
     }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell else {
            fatalError("He tenido que crear una celda")
        }
        
        let actividad = self.actividades[indexPath.row]
        
        
        cell.name.text = actividad.nombre
        cell.imagen.image = actividad.photo
        cell.profesor.text = actividad.nombreProfesor
        cell.descripcion.text=actividad.descripcionCorta
        
        return cell
    }
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.actividades.count
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            diccionarioActividadID["id"]=self.actividades[indexPath.row].id
            self.actividades.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            guard let conexion = Conection (target: "actividad", responseObject : self,"Delete",diccionarioActividadID) else {
                return
            }
            conexion.request()
        }
    }

    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.selectedRow=indexPath.row
        
    }*/

    
}

