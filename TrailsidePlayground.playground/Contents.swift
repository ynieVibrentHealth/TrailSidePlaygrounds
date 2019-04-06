import UIKit
import Alamofire
import SnapKit

import PlaygroundSupport
import SnapKit

PlaygroundPage.current.needsIndefiniteExecution = true

class CustomCell:UITableViewCell {
    static let reuseID = "CustomCellREUSEID"
    
    let imgURL = URL(string: "http://lorempixel.com/400/400/")
    
    private lazy var label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    public func configure(with text:String) {
        label.text = text
        label.backgroundColor = .white
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        label.snp.updateConstraints { (make) in
            make.top.bottom.equalTo(self.contentView).inset(10)
            make.leading.trailing.equalTo(self.contentView).inset(20)
        }
        
        super.updateConstraints()
    }
}

class CustomTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    let sampleText:[String] = ["Text test Text test Text test Text test ",
                               "Text test Text test ",
                               "Text test Text test Text test ",
                               "Text test Text test Text test Text test Text test ",
                               "Text test "]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureTableview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureTableview()
    }
    
    func configureTableview() {
        self.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseID)
        self.dataSource = self
        self.delegate = self
        
        self.backgroundColor = .white
        self.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseID, for: indexPath) as! CustomCell
        
        cell.configure(with: sampleText[indexPath.row])
        return cell
    }
}

let frame = CGRect(x: 0, y: 0, width: 300, height: 500)
let tableView = CustomTableView(frame: frame)


PlaygroundPage.current.liveView = tableView

