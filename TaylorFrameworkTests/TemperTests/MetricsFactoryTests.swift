//
//  MetricsFactoryTests.swift
//  Taylor
//
//  Created by Marcel de Siqueira Campos Rebouças on 3/23/16.
//  Copyright © 2016 Marcel Rebouças. All rights reserved.
//


import Nimble
import Quick
@testable import TaylorFramework

class MetricsFactoryTests : QuickSpec {
    let helper = TestsHelper()
    override func spec() {
        describe("MetricsFactory") {
            it("should return the metrics") {
                let metrics = MetricsFactory().getMetrics()
                expect(metrics.count).to(equal(1))
            }
        }
    }
}
