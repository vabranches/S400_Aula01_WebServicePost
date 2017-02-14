
import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var plataformaTextField: UITextField!
    @IBOutlet weak var anoTextField: UITextField!
    
    //MARK: Propriedades
    var minhaSessao : URLSession!
    var baseURL = URL(string: "https://meuws.herokuapp.com/api/v1/jogos")!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.minhaSessao = URLSession(configuration: .default)

    }

    
    //MARK: Actions
    @IBAction func cadastrar(_ sender: UIButton) {
        var stringTitulo = ""
        var stringPlataforma = ""
        var stringAno = ""
        

            
            if !(tituloTextField.text!.isEmpty || plataformaTextField.text!.isEmpty || anoTextField.text!.isEmpty) {
                stringTitulo = self.tituloTextField.text!
                stringPlataforma = self.plataformaTextField.text!
                stringAno = self.anoTextField.text!
                
                //A tarefa post necessita de uma requisicao
                var minhaRequisicao = URLRequest(url: self.baseURL)
                minhaRequisicao.httpMethod = "POST"
                minhaRequisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                //Montar os dados que serão montados
                let dadosUsuario = ["titulo" : stringTitulo, "plataforma" : stringPlataforma, "ano" : stringAno]
                
                do{
                    let dadosUsuarioJSON = try JSONSerialization.data(withJSONObject: dadosUsuario, options: JSONSerialization.WritingOptions())
                    minhaRequisicao.httpBody = dadosUsuarioJSON
                } catch {}
                
                //Criando a tarefa que vai gravar o JSON
                let tarefa = minhaSessao.dataTask(with: minhaRequisicao, completionHandler: { (data, response, erro) in
                    
                    if erro == nil {
                        guard let meuResponse = response as? HTTPURLResponse else {return}
                        
                        if meuResponse.statusCode == 201{
                            guard let meuData = data else {return}
                            
                            if let dataString = String(data: meuData, encoding: .utf8){
                                print(dataString)
                            }
                            
                            DispatchQueue.main.async {
                                let alerta = UIAlertController(title: "Alerta", message: "Cadastro efetuado com sucesso", preferredStyle: .alert)
                                let botao = UIAlertAction(title: "OK", style: .default)
                                alerta.addAction(botao)
                                self.present(alerta, animated: true)
                                
                                self.tituloTextField.text = ""
                                self.plataformaTextField.text = ""
                                self.anoTextField.text = ""
                                
                            }
                            
                        } else {
                            print("\nStatus da rede: \(meuResponse.statusCode)\n")
                        }
                    }
                })
                
                tarefa.resume()
            } else {
                let alerta = UIAlertController(title: "Alerta", message: "Preencha todos os campos", preferredStyle: .alert)
                let botao = UIAlertAction(title: "OK", style: .default)
                alerta.addAction(botao)
                self.present(alerta, animated: true)
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

