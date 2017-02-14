
import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var plataformaTextField: UITextField!
    @IBOutlet weak var anoTextField: UITextField!
    
    //MARK: Propriedades
    var minhaSessao : URLSession!
    var baseURL = URL(string: "https://meuws.herokuapp.com/api/v1/jogos")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.minhaSessao = URLSession(configuration: .default)

    }

    
    //MARK: Actions
    @IBAction func cadastrar(_ sender: UIButton) {
        var minhaTarefa = minhaSessao.dataTask(with: baseURL!) { (data, response, erro) in
            //
        }
    }
    
    
    //MARK: Métodos de UIResponder
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }



}

