//
//  LeagueController.swift
//  LoLProject
//
//  Created by Антон on 02.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LeagueController: UIViewController {
    
    var leagueId: String = ""
    
    @IBOutlet weak var test: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.text = leagueId
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
