//
//  CreateOrUpdateGameViewController.swift
//  ColeccionDeJuegos
//
//  Created by mbtec22 on 4/15/21.
//

import UIKit

class CreateOrUpdateGameViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var btnCmeraOrGalery: UIBarButtonItem!
    
    @IBOutlet weak var imagaViwe: UIImageView!
    
    var imagePicker=UIImagePickerController()
    
    var juego : Juego? = nil
    
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    @IBOutlet weak var eliminarBoton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate=self
        btnCmeraOrGalery.image=UIImage(named: "camera")?.withRenderingMode(.alwaysOriginal)
        if juego != nil{
            imagaViwe.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden=true
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickAlertCameraOrGalery(_ sender: Any) {
        let alert = UIAlertController(title: "Semana6", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camara", style: .default, handler: {
            _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Galeria", style: .default, handler: {_ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        present(alert, animated: true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagaViwe.image=image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
            juego!.titulo = tituloTextField.text
            juego!.imagen = imagaViwe.image!.pngData() as Data?
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = imagaViwe.image!.pngData() as Data?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
