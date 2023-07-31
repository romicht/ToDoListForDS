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
    @IBOutlet weak var complitedMarkView: UIView! {
        didSet {
            complitedMarkView.isHidden = true
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
    
    func configure(with model: Model?) {
        guard let model = model else { return }
        self.nameTaskLabel.text = model.taskName
        if model.isComplited == true {
            self.complitedMarkView.isHidden = false
        } else {
            complitedMarkView.isHidden = true
        }
    }
    
    func complitedTask() {
        if complitedMarkView.isHidden == true {
            complitedMarkView.isHidden = false
        } else {
            complitedMarkView.isHidden = true
        }
    }
}
