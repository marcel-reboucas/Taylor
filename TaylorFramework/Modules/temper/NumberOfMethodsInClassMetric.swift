//
//  NumberOfMethodsInClassMetric.swift
//  Taylor
//
//  Created by Marcel de Siqueira Campos Rebouças on 3/23/16.
//  Copyright © 2016 Marcel Rebouças. All rights reserved.
//

final class NumberOfMethodsInClassMetric : Metric {
    
    let metric = "NumberOfMethodsInClass"
    
    let externalInfoUrl = ""
    
    func checkComponent(component: Component) -> Result {
        if component.type != ComponentType.Class { return (false, nil, nil) }
        let methodsCount = getMethodsCountForComponent(component)
        let name = component.name ?? "unknown"
        
        let message = formatMessage(name, value: methodsCount)
        return (true, message, methodsCount)
    }
    
    func formatMessage(name: String, value: Int) -> String {
        return "Class '\(name)' contains \(value) methods."
    }
    
    private func getMethodsCountForComponent(component: Component) -> Int {
        return component.components.filter({ $0.type == ComponentType.Function }).count
    }

}

