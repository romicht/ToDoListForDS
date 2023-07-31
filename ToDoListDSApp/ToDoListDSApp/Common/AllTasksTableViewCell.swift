//
//  AllTasksTableViewCell.swift
//  ToDoListDSApp
//
//  Created by Роман Цуприк on 30.07.23.
//

import UIKit

class AllTasksTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    @IBOutlet weak var conteinerView: UIView! 
    @IBOutlet weak var nameTaskLabel: UILabel!
    @IBOutlet weak var completedMarkView: UIView! {
        didSet {
            completedMarkView.isHidden = true
        }
    }
    static let identifire = "AllTasksTableViewCell"

    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AllTasksTableViewCell", bundle: nil)
    }
    
    //MARK: - Methods
    func configure(with model: TaskModel?) {
        guard let model = model else { return }
        self.nameTaskLabel.text = model.taskName
        if model.isCompleted == true {
            self.completedMarkView.isHidden = false
        } else {
            completedMarkView.isHidden = true
        }
    }
    
    func complitedTask() {
        if completedMarkView.isHidden == true {
            completedMarkView.isHidden = false
        } else {
            completedMarkView.isHidden = true
        }
    }
}
