//
//  TableViewCellNombre.swift
//  Aplicacion
//
//  Created by Andres on 15/02/2017.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class TableViewCellNombre: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var Informacion: UILabel!
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var Grupo: UILabel!
    @IBOutlet weak var Descripcion: UILabel!
    
    @IBOutlet weak var textNombre: UITextField!
    @IBOutlet weak var textGrupo: UITextField!
    @IBOutlet weak var textDesc: UITextView!
    
    @IBOutlet weak var section: UILabel!

}
