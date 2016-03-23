//
//  Metric.swift
//  Taylor
//
//  Created by Marcel de Siqueira Campos Rebouças on 3/23/16.
//  Copyright © 2016 Marcel Rebouças. All rights reserved.
//

protocol Metric {
    
    /**
     The metric name
     */
    
    var metric : String { get }
    
    /**
     The external info about the metric
     */
    
    var externalInfoUrl : String { get }
    
    /**
     The method check the component in order to apply the metric
     
     :param: component The component for checking
     
     :returns: bool isOk A bool value that indicates if the component is eligible to the metric
     :returns: String? message The message with the information of the metric, if the component is eligible to the metric
     :returns: Int? value The value of the metric, if the component is eligible to the metric
     */
    
    func checkComponent(component: Component) -> Result
    
    /**
     The method format the message for reporters
     
     :param: name The name of the component
     :param: value The metric value
     
     :returns: String The formatted message for reporters
     */
    
    func formatMessage(name: String, value: Int) -> String
}