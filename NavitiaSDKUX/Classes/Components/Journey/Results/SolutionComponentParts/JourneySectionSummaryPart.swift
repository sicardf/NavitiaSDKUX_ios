//
//  JourneySectionSummaryPart.swift
//  RenderTest
//
//  Created by Thomas Noury on 02/08/2017.
//  Copyright © 2017 Kisio. All rights reserved.
//

import Render
import NavitiaSDK

extension Components.Journey.Results.SolutionComponentParts {
    class JourneySectionSummaryPart: ViewComponent {
        let JourneySectionSegmentPart: Components.Journey.Results.SolutionComponentParts.JourneySectionSegmentPart.Type = Components.Journey.Results.SolutionComponentParts.JourneySectionSegmentPart.self
        
        var section: Section?
        var disruptions: [Disruption]?

        override func render() -> NodeType {
            var duration: Int32 = 0
            duration = self.section!.duration!
            let containerStyles: [String: Any] = [
                "fontSize": 16,
                "flexGrow": Int(duration),
                "marginEnd": config.metrics.margin,
            ]

            return ComponentNode(ViewComponent(), in: self, props: {(component, _) in
                component.styles = mergeDictionaries(dict1: containerStyles, dict2: self.styles)
            }).add(children: [
                ComponentNode(ViewComponent(), in: self, props: {(component, _) in
                    component.styles = self.viewStyles
                }).add(children: [
                    ComponentNode(ModeComponent(), in: self, props: {(component, _) in
                        component.section = self.section
                        component.styles = self.modeStyles
                    }),
                    ComponentNode(LineCodeWithDisruptionStatusComponent(), in: self, props: {(component, _) in
                        component.section = self.section
                        component.disruptions = self.disruptions
                    })
                ]),
                ComponentNode(JourneySectionSegmentPart.init(), in: self, props: {(component, _) in
                    component.section = self.section
                }),
            ])
        }

        let viewStyles: [String: Any] = [
            "flexDirection": YGFlexDirection.row,
            "marginBottom": 12,
        ]
        let modeStyles = [
            "marginRight": config.metrics.marginS,
            "height": 28,
        ]
    }
}
