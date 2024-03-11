//
//  ViewController.swift
//  simple
//
//  Created by Mac on 11.03.2024.
//

import UIKit


class Task {
    let title: String
    var completed: Bool
    
    init(title: String) {
        self.title = title
        self.completed = false
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tasks: [Task] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter task"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(addButton)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            
            addButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func addTask() {
        guard let taskTitle = textField.text, !taskTitle.isEmpty else {
            return
        }
        
        let newTask = Task(title: taskTitle)
        tasks.append(newTask)
        
        textField.text = ""
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.accessoryType = task.completed ? .checkmark: .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].completed = !tasks[indexPath.row].completed
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
