//
//  TowreSubtestPageController.swift
//  test
//
//  Created by Dominic Heaton on 03/02/2018.
//  Copyright © 2018 Dominic Heaton. All rights reserved.
//


import UIKit

class TowreSubtestPageController: UIPageViewController, UIPageViewControllerDataSource {
    
//    var finalResultsSWE = Double()
//    var scaledResultSWE = Double()
    
    //Function to hide back button from navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nextVC = segue.destination as! SubtestCompleted
//        nextVC.finalResultsSWE = finalResultsSWE
//        nextVC.scaledResultSWE = scaledResultSWE
//    }
    
    lazy var viewControllerList:[UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "TowreSubtestDescriptionPage1")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "TowreSubtestDescriptionPage2")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "TowreSubtestDescriptionPage3")
        
        return [vc1, vc2, vc3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Controls what page comes before the current view controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
    }
    
    //Controls what page comes after the current view controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        return viewControllerList[nextIndex]
    }
    
}

