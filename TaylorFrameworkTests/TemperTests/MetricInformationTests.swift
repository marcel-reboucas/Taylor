//
//  MetricInformationTests.swift
//  Taylor
//
//  Created by Marcel de Siqueira Campos Rebouças on 3/23/16.
//  Copyright © 2016 Marcel Rebouças. All rights reserved.
//


import Nimble
import Quick
@testable import TaylorFramework


class MetricInformationTests : QuickSpec {
    let helper : TestsHelper = TestsHelper()
    let aComponent = TestsHelper().anotherComponent
    let aMetric = TestsHelper().aMetric
    
    override func spec() {
        var metricInformation: MetricInformation!
        beforeEach() {
            metricInformation = MetricInformation(component: self.aComponent, metric: self.aMetric, metricInformationData: MetricInformationData(message: "msg", path: "path", value: 100))
        }
        
        describe("MetricInformation") {
            it("should instantiate from component, rule, message and path") {
                expect(metricInformation.component).to(equal(self.aComponent))
                expect(metricInformation.metric.metric).to(equal(self.aMetric.metric))
                expect(metricInformation.message).to(equal("msg"))
                expect(metricInformation.path).to(equal("path"))
                expect(metricInformation.metric.externalInfoUrl).to(equal(self.aMetric.externalInfoUrl))
            }
            it("should return the correct dictionary") {
                let metricInformationDictionary = metricInformation.toDictionary()
                expect(metricInformation.message).to(equal(metricInformationDictionary["message"] as? String))
                expect(metricInformation.metric.metric).to(equal(metricInformationDictionary["metric"] as? String))
                expect(metricInformation.path).to(equal(metricInformationDictionary["path"] as? String))
                expect(metricInformation.metric.externalInfoUrl).to(equal(metricInformationDictionary["externalInfoUrl"] as? String))
                expect(metricInformation.value).to(equal(metricInformationDictionary["value"] as? Int))
                expect(metricInformation.component.name).to(equal(metricInformationDictionary["class"] as? String))
                
                let range = ComponentRange.deserialize(metricInformationDictionary)
                expect(metricInformation.component.range).to(equal(range))
            }
            it("should return the correct dictionary from function component") {
                let classComponent = Component(type: .Class, range: ComponentRange(sl: 0, el: 0), name: "TheClass")
                let component = self.helper.ifComponent
                component.parent = classComponent
                let metricInformation = MetricInformation(component: component, metric: self.aMetric, metricInformationData: MetricInformationData(message: "msg", path: "path", value: 100))
                let metricInformationDictionary = metricInformation.toDictionary()

                expect(metricInformation.message).to(equal(metricInformationDictionary["message"] as? String))
                expect(metricInformation.metric.metric).to(equal(metricInformationDictionary["metric"] as? String))
                expect(metricInformation.path).to(equal(metricInformationDictionary["path"] as? String))
                expect(metricInformation.metric.externalInfoUrl).to(equal(metricInformationDictionary["externalInfoUrl"] as? String))
                expect(metricInformation.value).to(equal(metricInformationDictionary["value"] as? Int))
                expect(metricInformation.component.name).to(equal(metricInformationDictionary["method"] as? String))
                let range = ComponentRange.deserialize(metricInformationDictionary)
                expect(metricInformation.component.range).to(equal(range))
            }
            it("should return the correct XML element") {
                let element = metricInformation.toXMLElement()
                expect(element.stringValue).to(equal("msg"))
                let attributes = element.attributes
                expect(attributes).to(contain(NSXMLNode.attributeWithName("metric", stringValue: metricInformation.metric.metric) as? NSXMLNode))
                if let classComponent = metricInformation.component.classComponent() {
                    if let name = classComponent.name {
                        expect(attributes).to(contain(NSXMLNode.attributeWithName("class", stringValue: name) as? NSXMLNode))
                    }
                }
                expect(attributes).to(contain(NSXMLNode.attributeWithName("externalInfoUrl", stringValue: metricInformation.metric.externalInfoUrl) as? NSXMLNode))
                if self.aComponent.type == ComponentType.Function {
                    if let name = self.aComponent.name {
                        expect(attributes).to(contain(NSXMLNode.attributeWithName("method", stringValue: name) as? NSXMLNode))
                    }
                }
                expect(attributes).to(contain(NSXMLNode.attributeWithName("beginline", stringValue: String(self.aComponent.range.startLine)) as? NSXMLNode))
                expect(attributes).to(contain(NSXMLNode.attributeWithName("endline", stringValue: String(self.aComponent.range.endLine)) as? NSXMLNode))
            }
            it("should remove backslashes from path when creating the metric information") {
                var containsBackslash = false
                for character in metricInformation.path.characters {
                    if character == "\\" {
                        containsBackslash = true
                    }
                }
                expect(containsBackslash).to(beFalse())
            }
            it("should return the correct error string for stderr") {
                let metricInformation =  MetricInformation(component: self.aComponent, metric: self.aMetric, metricInformationData: MetricInformationData(message: "msg", path: "thepath", value: 100))
                let errorString = metricInformation.errorString
                expect(errorString).to(equal("thepath:\(self.aComponent.range.startLine):0: warning: \(self.aMetric.metric):msg\n"))
            }
        }
    }
}
