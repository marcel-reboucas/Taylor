//
//  NumberOfMethodsInClassMetricTests.swift
//  Taylor
//
//  Created by Marcel de Siqueira Campos Rebouças on 3/23/16.
//  Copyright © 2016 Marcel Rebouças. All rights reserved.
//

import Nimble
import Quick
@testable import TaylorFramework

class NumberOfMethodsInClassMetricTests: QuickSpec {
    let metric = NumberOfMethodsInClassMetric()
    override func spec() {
        describe("Number Of Methods In Class Metric") {
            it("should not check the non-class components") {
                let component = Component(type: .For, range: ComponentRange(sl: 0, el: 0), name: "blabla")
                let result = self.metric.checkComponent(component)
                expect(result.isOk).to(beFalse())
                expect(result.message).to(beNil())
                expect(result.value).to(beNil())
            }
            it("should return true, a message and a value when the component is a class") {
                let component = Component(type: .Class, range: ComponentRange(sl: 0, el: 0), name: "blabla")
                let result = self.metric.checkComponent(component)
                expect(result.isOk).to(beTrue())
                expect(result.message).toNot(beNil())
                expect(result.value).toNot(beNil())
            }
        }
    }
}

