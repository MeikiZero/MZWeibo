//
//  HomeController.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class HomeController: BaseViewController {
    
    private lazy var titleBtn = TitleButton()
    
    private lazy var popoverAnimator = PopoverAnimator { presented in
        self.titleBtn.isSelected = presented
    }
    
    private lazy var viewModels = [StatusViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vistorView.addRotationAnimate()
        if !isLogin {
            return
        }
        setNavigationBar()
        
        loadStatuses()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }

}

// MARK: - 设置UI界面
extension HomeController {
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setTitle("MZ", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
    
}

// MARK: - 事件监听
extension HomeController {
    @objc private func titleBtnClick() {
        let popoverVc = PopoverViewController()
        popoverVc.modalPresentationStyle = .custom
        popoverVc.transitioningDelegate = popoverAnimator
        popoverAnimator.presentFrame = CGRect(x: 100, y: 100, width: 180, height: 250)
        present(popoverVc, animated: true, completion: nil)
       
    }
}

// MARK: - 请求数据
extension HomeController {
    private func loadStatuses() {
        NetworkTools.shareInstance.loadStatuses { result, error in
            if error != nil {
                print(error!)
                return
            }
            guard let resultArray = result else { return }
            
            for stausDict in resultArray {
                let status = Status(dict: stausDict)
                let viewModel = StatusViewModel(status: status)
                self.viewModels.append(viewModel)
                
            }
            print(self.viewModels)
            self.tableView.reloadData()
        }
    }
}

// MARK: - tableView代理方法
extension HomeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeViewCell
        cell.viewModel = viewModels[indexPath.row]
        return cell
    }
}

