//
//  ViewController.swift
//  WhatstheWeather
//
//  Created by Amanda Grayson on 2/15/16.
//  Copyright © 2016 umsi363w16. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!

    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    
    @IBAction func findWeather(sender: AnyObject) {
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text! + "/forecasts/latest")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
        (data,reponse,error) ->Void in
            if error == nil {
                let urlcontent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                let websiteArray = urlcontent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
            
                if websiteArray!.count > 0 {
                    let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                    if weatherArray.count > 0 {
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                    print(weatherSummary)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                    }
                }
            }
        }
    
    
    task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    
    @IBOutlet weak var resultLabel: UILabel!
    


}

