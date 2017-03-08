//
//  ViewController.swift
//  Aplicacion
//
//  Created by Andres on 01/02/2017.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource ,ResponseReceiver, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var buscar: UIBarButtonItem!
    @IBOutlet weak var filtroFechaProfesor: UISegmentedControl!
    @IBOutlet weak var cancelar: UIBarButtonItem!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var vistaPickerFecha: UIView!
    @IBOutlet weak var pickerFecha: UIDatePicker!
    @IBOutlet weak var vistaPicker: UIView!
    @IBOutlet weak var picker: UIPickerView!

    @IBOutlet weak var tableFiltrada: UITableView!

    var profesores:[Profesor]=[]
    var actividades:[Actividad]=[]
    var actividadesFiltradas:[Actividad]=[]
    var util:Util=Util()
    var diccionarioProfesores: [[String : Any]] = [[:]]
    var selectedRowProfesores: Int = 0
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfesores()
        checkSegmentedControl()
        self.picker.dataSource=self
        self.picker.delegate=self
        self.tableFiltrada.delegate=self
        self.tableFiltrada.dataSource=self
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            print("problemas con el diccionario")
            return
        }
        
        self.diccionarioProfesores=diccionario
        
        profesores = util.getArrayProfesoresFromJson(diccionario: diccionarioProfesores )
        print("me llegan los datos")
        DispatchQueue.main.async{
            self.picker.reloadAllComponents()
            print("recargo los datos")
        }
        
    }
    func onErrorReceivingData ( message : String ) {
        return
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRowProfesores=row
        print(selectedRowProfesores)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell else {
            fatalError("He tenido que crear una celda")
        }
        let actividades = self.actividadesFiltradas[indexPath.row]

        cell.name.text = actividades.nombre
        cell.imagen.image = actividades.photo
        cell.profesor.text = actividades.nombreProfesor
        cell.descripcion.text=actividades.descripcionCorta
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.actividadesFiltradas.count
    }

    @IBAction func filtrar(_ sender: Any) {
        actividadesFiltradas.removeAll()
        DispatchQueue.main.async {
            self.tableFiltrada.reloadData()
        }
        if(filtroFechaProfesor.selectedSegmentIndex==0){
            for actividad in self.actividades {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat="yyyy-MMM-dd"
                
                print("fecha picker ",dateFormatter.string(from: pickerFecha.date))
                print(actividad.fecha)
                if(actividad.fecha==dateFormatter.string(from: pickerFecha.date)){
                    print(actividad.nombre, "Actividad agregada")
                    actividadesFiltradas.append(actividad)
                }
            }
        }else{
            for actividad in self.actividades {
                
                if(actividad.nombreProfesor == profesores[selectedRowProfesores].nombre){
                    print(profesores[selectedRowProfesores].nombre)
                    print(actividad.nombreProfesor)
                    actividadesFiltradas.append(actividad)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableFiltrada.reloadData()
        }
    }

    @IBAction func cambiarPicker(_ sender: UISegmentedControl) {
        checkSegmentedControl()
    }


    func checkSegmentedControl(){
        if(filtroFechaProfesor.selectedSegmentIndex==0){
            titulo.text="Fecha"
            vistaPickerFecha.isHidden=false
            vistaPicker.isHidden=true
        }else{
            titulo.text="Profesor"
            vistaPickerFecha.isHidden=true
            vistaPicker.isHidden=false
        }

    }
}

