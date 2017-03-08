//
//  ViewControllerAddEdit.swift
//  Aplicacion
//
//  Created by dam on 21/2/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class ViewControllerAddEdit: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ResponseReceiver{

    @IBOutlet weak var tituloSegue: UILabel!
    @IBOutlet weak var cancelarActividad: UIBarButtonItem!
    @IBOutlet weak var nombreActividad: UILabel!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var grupoActividad: UILabel!
    @IBOutlet weak var grupo: UITextField!
    @IBOutlet weak var lugar: UITextField!
    @IBOutlet weak var descripcionActividad: UILabel!
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet weak var tituloHorarioActividad: UILabel!
    @IBOutlet weak var fechaActividad: UILabel!
    @IBOutlet weak var pickerFecha: UIDatePicker!
    @IBOutlet weak var horaIniActividad: UILabel!
    @IBOutlet weak var pickerHoraIni: UIDatePicker!
    @IBOutlet weak var horaFinActividad: UILabel!
    @IBOutlet weak var pickerHoraFin: UIDatePicker!
    @IBOutlet weak var tituloResponsableActividad: UILabel!
    @IBOutlet weak var departamentoProfesor: UILabel!
    @IBOutlet weak var departamento: UITextField!
    @IBOutlet weak var profesorActividad: UILabel!
    @IBOutlet weak var pickerProfesor: UIPickerView!
    @IBOutlet weak var agregarEditarBoton: UIBarButtonItem!
    
    var profesores:[Profesor]=[]
    var util:Util=Util()
    var diccionarioProfesores: [[String : Any]] = [[:]]
    var diccionarioActividad: [String:Any] = [:]
    var selectedRowProfesor: Int=0
    var actividad:Actividad?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfesores()
        self.nombreActividad.text="Nombre:"
        self.nombre.placeholder="Actividad de medio ambiente"
        self.grupoActividad.text="Grupo:"
        self.grupo.placeholder="1ºA"
        self.lugar.placeholder="Palacio de deportes"
        self.descripcionActividad.text="Descripcion:"
            self.descripcion.text=""
        
        self.tituloHorarioActividad.text="Fecha y hora"
        self.fechaActividad.text="Fecha:"
        self.horaIniActividad.text="Hora inicio:"
        self.horaFinActividad.text="Hora fin:"
        self.tituloResponsableActividad.text="Encargado:"
        self.departamentoProfesor.text="Departamento:"
        self.departamento.isEnabled=false
        self.profesorActividad.text="Profesor:"
        
        self.pickerProfesor.delegate=self
        self.pickerProfesor.dataSource=self
        if(actividad==nil){
            self.agregarEditarBoton.title="Agregar"
            self.tituloSegue.text="Nueva Actividad"
        }else{
            self.agregarEditarBoton.title="Editar"
            self.tituloSegue.text="Editando Actividad"
            
        }
        
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
            return
        }
        
        self.diccionarioProfesores=diccionario
        
        profesores = util.getArrayProfesoresFromJson(diccionario: diccionarioProfesores )
        print("me llegan los datos")
        DispatchQueue.main.async{
            self.pickerProfesor.reloadAllComponents()
            print("recargo los datos")
            if((self.actividad) != nil){
                self.cargarDatos()
            }
        }
        
        
        
    }
    func onErrorReceivingData ( message : String ) {
        print("datos erroneos")
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
       self.departamento.text=self.profesores[row].departamento
        self.selectedRowProfesor=row
        print(component)
    }
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingMain = presentingViewController is UINavigationController
        if isPresentingMain {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else {
            fatalError("Error al cerrar el segue")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(actividad != nil ){
            recogerDatos()
            print("hago un put")
            print(diccionarioActividad)
            guard let conexion2 = Conection (target: "actividad",responseObject : self, "PUT",diccionarioActividad) else {
                print("no hago la conexion")
                return
            }
            conexion2.request()
        }else if(actividad == nil && self.nombre.text != ""){
            recogerDatos()
            print("hago un post")
            print(diccionarioActividad)
            guard let conexion2 = Conection (target: "actividad",responseObject : self, "POST",diccionarioActividad) else {
                print("no hago la conexion")
                return
            }
            conexion2.request()
        }
    }

    func recogerDatos(){
        if(actividad==nil){
            diccionarioActividad["id"]=""
        }else{
            diccionarioActividad["id"]=actividad!.id
        }
        
        diccionarioActividad["nombre"]=self.nombre.text
        diccionarioActividad["idProfesor"]=self.profesores[selectedRowProfesor].id
        diccionarioActividad["descripcionCorta"]=self.descripcion.text
        diccionarioActividad["descripcionLarga"]=self.descripcion.text
        diccionarioActividad["grupo"]=self.grupo.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale=Locale.init(identifier:"es_ES")
        dateFormatter.dateFormat="yyyy-MM-dd"
        diccionarioActividad["fecha"]=dateFormatter.string(from: pickerFecha.date)
        print(diccionarioActividad["fecha"])
        diccionarioActividad["lugar"]=self.lugar.text
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale.init(identifier:"es_ES")
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        diccionarioActividad["horaInicio"]=timeFormatter.string(from: pickerHoraIni.date)
        print("Formato de un time picker ", pickerHoraIni.date)
        print(diccionarioActividad["horaInicio"])
        let timeFormatter2 = DateFormatter()
        timeFormatter2.locale = Locale.init(identifier:"es_ES")
        timeFormatter2.dateStyle = .none
        timeFormatter2.timeStyle = .short
        diccionarioActividad["horaFin"]=timeFormatter2.string(from: pickerHoraFin.date)
        print(diccionarioActividad["horaFin"])
        
    }
    
    func cargarDatos(){
        self.agregarEditarBoton.title="Editar"
        self.nombre.text=actividad!.nombre
        self.grupo.text=actividad!.grupo
        self.lugar.text=actividad!.lugar
        self.descripcion.text=actividad!.descripcionLarga
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="yyyy-M-dd"
        dateFormatter.locale = Locale.init(identifier: "ES_es")
        let fecha = dateFormatter.date(from: (actividad!.fecha))
        self.pickerFecha.date=fecha!
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "H:mm"
        timeFormatter.locale = Locale.init(identifier: "ES_es")
        let timeInicio = timeFormatter.date(from: (actividad!.horaInicio))
        self.pickerHoraIni.date=(timeInicio)!
        let timeFormatter2 = DateFormatter()
        timeFormatter2.dateFormat = "H:mm"
        timeFormatter2.locale = Locale.init(identifier: "ES_es")
        let timeFin = timeFormatter2.date(from: (actividad!.horaFin))
        self.pickerHoraFin.date=(timeFin)!
        for i in stride ( from : 0, to:profesores.count, by: 1) {
            if(actividad?.nombreProfesor==profesores[i].nombre){
                selectedRowProfesor=i
                break
            }
        }
        print(selectedRowProfesor)
        print(actividad!.nombreProfesor)
        self.pickerProfesor.selectRow(selectedRowProfesor, inComponent: 0, animated: true)
        self.departamento.text=actividad!.departamento
    }
    
}
