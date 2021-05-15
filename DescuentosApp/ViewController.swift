//
//  ViewController.swift
//  DescuentosApp
//
//  Created by Faustino Pulido Sarmiento on 10/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var descuento: UILabel!
    
    @IBOutlet weak var cantidadText: UITextField!
    
    @IBOutlet weak var porcentajeText: UITextField!
    
    @IBOutlet weak var buttonConstrains: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pantalla()
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }

    func pantalla(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height{
            case 1136:
                print("IPHONE 5 O SE")
            case 1334:
                print("IPHONE 6 6S 7 8")
            case 2208:
                print("IPHONE PLUS")
            case 2436:
                print("IPHONE X XS")
                self.buttonConstrains.constant = 53
            case 1792:
                print("IPHONE XR")
            case 2688:
                print("IPHONE XS+")
            default:
                print("cualquier height")
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func teclado(notificacion: Notification) {
        guard let tecladoUp = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return   }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height == 2208 {
                self.view.frame.origin.y = -tecladoUp.height
            }
        } else {
            self.view.frame.origin.y = 0
        }
        
        
        
    }
    
    @IBAction func calcular(_ sender: UIButton) {
        if cantidadText.text != "" && porcentajeText.text != "" {
            self.view.endEditing(true)
            guard let numero = cantidadText.text else { return   }
            guard let porc = porcentajeText.text else { return   }
            let cant = (numero as NSString).floatValue
            let porciento = (porc as NSString).floatValue
            let desc = cant * porciento / 100
            let totalFinal = cant - desc
            total.text = "$\(totalFinal)"
            descuento.text = "$\(desc)"
        } else {
            let alert = UIAlertController(title: "Alerta", message: "Ingresa valores", preferredStyle: .alert )
            let accion = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(accion)
            present(alert, animated: true, completion: nil)
        }
        
            
        
    }
    
    @IBAction func limpiar(_ sender: UIButton) {
        self.view.endEditing(true)
        total.text = "$0.0000"
        descuento.text = "$0.0000"
        cantidadText.text = ""
        porcentajeText.text = ""
    }
    
    
}

