//
//  ViewController.swift
//  Table View App
//
//  Created by Lara Tenore on 02/04/20.
//  Copyright © 2020 Lara Tenore Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Table View Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundColor = UIColor.clear
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return diarias.count
        case 1:
            return semanais.count
        case 2:
            return mensais.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //IndexPath tem dois inteiros (section e row)
 
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.clear
        
        //reusing cell to make effective project
        //let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        //cell.imageView?.image = UIImage(named: "clock")
        //cell.accessoryType = .disclosureIndicator //setinha para a direita (next page)
        
        //Para montar descrição da celula:
        
        //cell.detailTextLabel?.text = ""
        var currentTask: Task!
        
        switch indexPath.section {
        case 0:
            currentTask = diarias[indexPath.row]
            //cell.detailTextLabel?.text = diariasDesc[indexPath.row]
        case 1:
             currentTask =  semanais[indexPath.row]
        case 2:
             currentTask =  mensais[indexPath.row]
        default:
            break
        }
        
        cell.textLabel?.text = currentTask.name
        
        if currentTask.completed {
            cell.textLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        } else {
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryType = .none
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Atividades Diárias"
        case 1:
            return "Atividades Semanais"
        case 2:
            return "Atividades Mensais"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Estas atividades devem ser realizadas diariamente"
        case 1:
            return "Estas atividades devem ser realizadas semanalmente"
        case 2:
            return "Estas atividades devem ser realizadas mensalmente, de preferência, no fim do mês."
        default:
            return nil
        }
    }
    
    
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        
        let mySwitch = sender as! UISwitch
        
        if mySwitch.isOn {
            view.backgroundColor = UIColor.darkGray
        }
        else{
            view.backgroundColor = UIColor.white
        }
        
    }
    
    @IBOutlet weak var taskTableView: UITableView!
    
    @IBAction func resetList(_ sender: Any) {
        
        //criar mensagem para confirmar se quer mesmo resetar
        let confirm =   (title: "Tem certeza?", message: "Se você optar por resetar, todas as atividades serão marcadas como incompletas.", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) {
            action in
            for i in 0..<self.diarias.count{
                self.diarias[i].completed = false
            }
            
            for i in 0..<self.semanais.count{
                self.semanais[i].completed = false
            }
            
            for i in 0..<self.mensais.count{
                self.mensais[i].completed = false
            }
            
            self.taskTableView.reloadData()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel){
            action in
            print("That was a close one!")
        }
        
        //add ações ao Alert Controler
        confirm.addAction(yesAction)
        confirm.addAction(noAction)
        
        //apresentando
        present(confirm, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Linha \(indexPath.row) selecionada na sessão \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let incompleteAction = UIContextualAction(style: .normal, title: "Incomplete") { (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            switch indexPath.section{
            case 0:
                self.diarias[indexPath.row].completed = false
            case 1:
                self.semanais[indexPath.row].completed = false
            case 2:
                self.mensais[indexPath.row].completed = false
                
            default:
                break
            }
            
            tableView.reloadData()
            
            actionPerformed(true)
            
        }
        
        return UISwipeActionsConfiguration(actions: [incompleteAction])
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            switch indexPath.section{
            case 0:
                self.diarias[indexPath.row].completed = true
            case 1:
                self.semanais[indexPath.row].completed = true
            case 2:
                self.mensais[indexPath.row].completed = true
                
            default:
                break
            }
            
            tableView.reloadData()
            
            actionPerformed(true)
            
        }
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    //List of TODOs
    var diarias = [
        Task(name: "Café da manhã", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Regar plantas", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Arrumar cama", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Trocar de roupa", type: .daily, completed: false, lastCompleted: nil),
    ]
    
    var semanais = [
        Task(name: "Faxina na casa (3x/semana)", type: .weekly, completed: false, lastCompleted: nil),
        Task(name: "Fazer almoço", type: .weekly, completed: false, lastCompleted: nil),
        Task(name: "Estender roupa", type: .weekly, completed: false, lastCompleted: nil),
    ]
    
    var mensais = [
        Task(name: "Pagar fatura", type: .monthly, completed: false, lastCompleted: nil),
        Task(name: "Comida da Gaga", type: .monthly, completed: false, lastCompleted: nil),
        Task(name: "Checar conta (BB e Santander)", type: .monthly, completed: false, lastCompleted: nil),
    ]
    
    //let diarias = ["Café da manhã", "Regar as plantas", "Arrumar a cama", "Me trocar", "Trabalhar e estudar"]
    
    //let diariasDesc = ["De acordo com o Meta Real", "Não se esquecer das espadas de Ogum", "Boa sorte", "No pijamas allowed", "Foco no futuro!"]
    
    //let semanais = ["Faxina na casa (3x/semana)", "Fazer almoço", "Estender roupa"]
        
    //let mensais = ["Pagar fatura", "Comida da Gaga", "Checar conta (BB e Santander)"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

