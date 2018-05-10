//
//  SideMenuViewController.swift
//  restARant
//
//  Created by Patrick Maribojoc on 5/9/18.
//  Copyright © 2018 PatrickMaribojoc. All rights reserved.
//

import UIKit
import SideMenu

protocol SideMenuViewControllerDelegate: class {
    
    func menu(_ menu: SideMenuViewController, didSelectItemAt index: Int, at point: CGPoint)
    func menuDidCancel(_ menu: SideMenuViewController)

}

class SideMenuViewController: UITableViewController {
    
    weak var delegate: SideMenuViewControllerDelegate?
    var selectedItem = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SideMenuViewController viewWillAppear");
        let indexPath = IndexPath(row: selectedItem, section: 0)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
}

extension SideMenuViewController {
    
    @IBAction fileprivate func dismissMenu() {
        print("Dismissing menu");
        delegate?.menuDidCancel(self)
    }
}

//MARK: Menu protocol
extension SideMenuViewController: Menu {
    
    var menuItems: [UIView] {
        return [tableView.tableHeaderView!] + tableView.visibleCells
    }
}

extension SideMenuViewController {
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath == tableView.indexPathForSelectedRow ? nil : indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rect = tableView.rectForRow(at: indexPath)
        var point = CGPoint(x: rect.midX, y: rect.midY)
        point = tableView.convert(point, to: nil)
        delegate?.menu(self, didSelectItemAt: indexPath.row, at: point)
    }
}
