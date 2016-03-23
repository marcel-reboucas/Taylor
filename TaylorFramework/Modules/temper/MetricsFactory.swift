//
//  MetricsFactory.swift
//  Taylor
//
//  Created by Marcel de Siqueira Campos Rebouças on 3/23/16.
//  Copyright © 2016 Marcel Rebouças. All rights reserved.
//

struct MetricsFactory {
    func getMetrics() -> [Metric] {
        return [NumberOfMethodsInClassMetric()]
    }
}