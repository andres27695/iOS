//
//  PickerTableViewCell.swift
//  Aplicacion
//
//  Created by Andres on 10/02/2017.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class PickerTableViewCell : UITableViewCell {
    
    @IBOutlet weak var ProfesorLabel: UILabel!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var pickerInicio: UIDatePicker!
    @IBOutlet weak var inicio: UILabel!
    @IBOutlet weak var horaFin: UILabel!
    @IBOutlet weak var pickerFin: UIDatePicker!
    
    class var expandedHeight: CGFloat { get { return 200 } }
    class var defaultHeight: CGFloat  { get { return 44  } }
    
    @IBOutlet weak var encargados: UILabel!
    @IBOutlet weak var departamento: UILabel!
    @IBOutlet weak var profesor: UIPickerView!
    @IBOutlet weak var prof: UILabel!
    
    var frameAdded = false
    
    
    func checkHeight(){

        
    }
    
    func watchFrameChanges(){
        if(!frameAdded){
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
            frameAdded = true
            checkHeight()
        }
    }
    
    func ignoreFrameChanges(){
        if (frameAdded){
        removeObserver(self, forKeyPath: "frame")
            frameAdded = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame"{
            checkHeight() 
        }
    }
    deinit {
        print("deinit called");
        ignoreFrameChanges()
    }
}
