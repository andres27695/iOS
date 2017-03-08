//
//  TableViewControllerAñadir.swift
//  Aplicacion
//
//  Created by Andres on 10/02/2017.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class TableViewControllerNueva: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, ResponseReceiver {
    
    @IBOutlet var pickerView: UIPickerView!
    
    let cells = ["Información General", "Informacion", "Fecha y hora", "fecha", "horaI", "horaF", "Encargado", "profesor"]
    
    var selectedIndexPath : IndexPath?
    
    var profesores:[Profesor] = []
    var util:Util=Util()
    var diccionarioProfesores: [[String : Any]] = [[:]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfesores()
        
    }
    
    private func loadProfesores(){
        guard let conexion = Conection (target: "profesor", responseObject : self) else {
            print("no hago la conexion")
            return
        }
        conexion.request()
        
    }
    func onDataReceived (data: Data) {
        guard let diccionario = util.jsonToDict (data: data) else {
            return
        }
        
        self.diccionarioProfesores=diccionario
        
        self.profesores = util.getArrayProfesoresFromJson(diccionario: diccionarioProfesores )
        print("me llegan los datos")
        DispatchQueue.main.async{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "departamento") as! PickerTableViewCellProfesores
            cell.pickerProf.reloadAllComponents()
            
            print("recargo los datos")
        }
        
    }
    func onErrorReceivingData ( message : String ) {
        return
    }

    @IBAction func addActividad(_ sender: Any) {
    }
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.profesores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.profesores[row].nombre
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if cells [indexPath.row] == "Informacion" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "informacion", for: indexPath) as! TableViewCellNombre
            
            cell.Nombre.text = "Nombre:"
            cell.Grupo.text = "Grupo:"
            cell.Descripcion.text = "Descripcion:"
            
            return cell
            
            
        } else if cells [indexPath.row] == "fecha"{
            
            let cellID = "cell"
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PickerTableViewCell
            
            cell.ProfesorLabel.text = "Fecha"
            
            return cell

        } else if cells [indexPath.row] == "horaI"{
            
            let cellID = "cell2"
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PickerTableViewCell
            
            cell.inicio.text = "Hora Inicio"
            
            return cell
            
        } else if cells [indexPath.row] == "horaF"{
            
            let cellID = "cell3"
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PickerTableViewCell
            
            cell.horaFin.text = "Hora fin"
            
            return cell
            
        } else if cells [indexPath.row] == "profesor" {
            
            let cellID = "departamento"
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PickerTableViewCellProfesores
            
            cell.depart.text = "Departamento"
            cell.profesor.text = "Profesor"
            cell.pickerProf.delegate=self
            cell.pickerProf.dataSource=self
            
            return cell
        } else {
            
            let cellID = "section"
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCellNombre
            cell.section.text = cells[indexPath.row]
            
            return cell
        }
        
        /*
        let cellID = "cell"
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PickerTableViewCell
        
        cell.ProfesorLabel.text = "Fecha"
 
        return cell
        */
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (cells [indexPath.row] == "fecha" || cells [indexPath.row] == "horaI" || cells [indexPath.row] == "horaF"){
        
            let previousIndexPath = selectedIndexPath
            if indexPath == selectedIndexPath {
                selectedIndexPath = nil
            } else {
                selectedIndexPath = indexPath
            }
        
            var indexPaths : Array<IndexPath> = []
            if let previous = previousIndexPath {
                indexPaths += [previous]
            }
            if let current = selectedIndexPath {
                indexPaths += [current]
            }
            if indexPaths.count > 0 {
                tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (cells [indexPath.row] != "Informacion" || cells [indexPath.row] != "profesor"){
            
            //(cell as! PickerTableViewCell).watchFrameChanges()
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (cells [indexPath.row] != "Informacion" || cells [indexPath.row] != "profesor"){
            //(cell as! PickerTableViewCell).ignoreFrameChanges()
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return PickerTableViewCell.expandedHeight
        }else if cells [indexPath.row] == "Informacion" {
            
            return 200
        } else if cells [indexPath.row] == "profesor" {
            return 235
        } else {
          return PickerTableViewCell.defaultHeight
        }
        
    }
    
    

    /*override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
