//
//  ViewController.swift
//  ToDoListDSApp
//
//  Created by Роман Цуприк on 29.07.23.
//

import UIKit
import SnapKit

class ToDoListViewController: UIViewController {
    
    //MARK: - Properties
    var tasksArray = [TaskModel]()
    private lazy var toDoListLabel: UILabel = {
        let label = UILabel()
        label.text = "MY TO DO LIST"
        label.textColor = .systemBlue
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 30)
        label.textAlignment = .center
        return label
    }()
    private lazy var newTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW TASK"
        label.textColor = .black
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        label.textAlignment = .center
        return label
    }()
    private lazy var newTaskField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter name of the task"
        return textField
    }()
    private lazy var addTask: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.addTarget(self, action: #selector(addTaskButtonAction), for: .touchUpInside)
        button.layer.masksToBounds = true
        return button
    }()
    private lazy var allTasksLabel: UILabel = {
        let label = UILabel()
        label.text = "ALL TASKS"
        label.textColor = .black
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        label.textAlignment = .center
        return label
    }()
    private lazy var allTasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: AllTasksTableViewCell.identifire)
        tableView.register(AllTasksTableViewCell.nib().self,
                           forCellReuseIdentifier: AllTasksTableViewCell.identifire)
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.orange
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupConstraints()
    }
    
    // MARK: - Methods
    private func setupAppearance() {
        self.view.backgroundColor = .orange
        self.view.addSubviews([self.toDoListLabel, self.newTaskLabel, self.newTaskField, self.addTask, self.allTasksLabel, self.allTasksTableView])
    }
    private func setupConstraints() {
        self.toDoListLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
        self.newTaskLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.toDoListLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
        self.newTaskField.snp.updateConstraints { (make) in
            make.top.equalTo(self.newTaskLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        self.addTask.snp.updateConstraints { (make) in
            make.top.equalTo(self.newTaskField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        self.allTasksLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.addTask.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
        self.allTasksTableView.snp.updateConstraints { (make) in
            make.top.equalTo(self.allTasksLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.left.right.bottom.equalToSuperview().inset(30)
        }
    }
    
    // MARK: - Actions
    @objc private func addTaskButtonAction() {
        guard let text = self.newTaskField.text, text != "" else { return }
        let model = TaskModel(taskName: text)
        self.tasksArray.append(model)
        self.newTaskField.text = ""
        self.allTasksTableView.reloadData()
    }
}

    // MARK: - UITableViewDelegate, UITableViewDataSource
extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasksArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allTasksTableView.dequeueReusableCell(withIdentifier: AllTasksTableViewCell.identifire, for: indexPath) as! AllTasksTableViewCell
        let view = UIView()
        view.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = view
        cell.configure(with: tasksArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.tasksArray[indexPath.row].isCompleted == true {
            self.tasksArray[indexPath.row].isCompleted = false
            } else {
                self.tasksArray[indexPath.row].isCompleted = true
            }
        self.allTasksTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(
            style: .destructive,
            title: "") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            self.allTasksTableView.performBatchUpdates({
                self.tasksArray.remove(at: indexPath.row)
                self.allTasksTableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: { (isSuccess) in
                completionHandler(isSuccess)
            })
        }
        remove.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [remove])
    }
}



