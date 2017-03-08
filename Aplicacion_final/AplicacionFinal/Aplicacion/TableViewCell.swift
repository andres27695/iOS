//
//  TableViewCell.swift
//  Aplicacion
//
//  Created by Andres on 03/02/2017.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: Properties

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var profesor: UITextField!
    @IBOutlet weak var descripcion: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
