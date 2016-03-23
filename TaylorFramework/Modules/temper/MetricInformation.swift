//
//  MetricInformation.swift
//  Taylor
//
//  Created by Marcel de Siqueira Campos Rebouças on 3/23/16.
//  Copyright © 2016 Marcel Rebouças. All rights reserved.
//

import Foundation

struct MetricInformationData {
    let message: String
    let path: String
    let value: Int
    init(message: String, path: String, value: Int) {
        self.message = message
        self.path = path
        self.value = value
    }
}

struct MetricInformation {
    
    var path : String
    let component : Component
    let metric : Metric
    let message : String
    let value : Int
    
    init(component: Component, metric: Metric, metricInformationData : MetricInformationData) {
        self.component = component
        self.metric = metric
        self.message = metricInformationData.message
        self.value = metricInformationData.value
        self.path = metricInformationData.path.stringByReplacingOccurrencesOfString("\\", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func toDictionary() -> Dictionary<String, AnyObject> {
        var metricInformationDictionary = Dictionary<String, AnyObject>()
        metricInformationDictionary["path"] = path
        metricInformationDictionary["metric"] = metric.metric
        metricInformationDictionary["message"] = message
        if let classComponent = component.classComponent() {
            if let name = classComponent.name {
                metricInformationDictionary["class"] = name
            }
        }
        if component.type == .Function {
            metricInformationDictionary["method"] = component.name
        }
        metricInformationDictionary["value"] = value
        metricInformationDictionary["externalInfoUrl"] = metric.externalInfoUrl
        metricInformationDictionary += component.range.serialize()
        return metricInformationDictionary
    }
    
    private func XMLNodes() -> [NSXMLNode] {
        var attributes = component.range.XMLAttributes()
        attributes = addNodeWithName("metric", stringValue: metric.metric, toAttributes: attributes)
        if let classComponent = component.classComponent() {
            if let name = classComponent.name {
                attributes = addNodeWithName("class", stringValue: name, toAttributes: attributes)
            }
        }
        if component.type == ComponentType.Function {
            if let name = component.name {
                attributes = addNodeWithName("method", stringValue: name, toAttributes: attributes)
            }
        }
        attributes = addNodeWithName("value", stringValue: String(value), toAttributes: attributes)
        attributes = addNodeWithName("externalInfoUrl", stringValue: metric.externalInfoUrl, toAttributes: attributes)
        
        return attributes
    }
    
    private func addNodeWithName(name: String, stringValue: String, toAttributes attributes: [NSXMLNode]) -> [NSXMLNode] {
        var newArray = attributes
        if let node = NSXMLNode.attributeWithName(name, stringValue: stringValue) as? NSXMLNode {
            newArray.append(node)
            return newArray
        }
        
        return attributes
    }
    
    func toXMLElement() -> NSXMLElement {
        let metricInformationElement = NSXMLElement(name: "metricInformation", stringValue: message)
        return XMLNodes().reduce(metricInformationElement) {
            $0.addAttribute($1)
            return $0
        }
    }
    
    var errorString : String {
        return "\(path):\(component.range.startLine):0: warning: \(metric.metric):\(message)\n"
    }
    
    var toString : String {
        return path + ":" + String(component.range.startLine) + ":" + metric.metric + " - " + message + "\n"
    }
}
