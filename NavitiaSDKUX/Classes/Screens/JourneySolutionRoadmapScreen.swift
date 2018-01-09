import Foundation
import Render
import NavitiaSDK

public struct JourneySolutionRoadmapState: StateType {
    public init() {
    }

    var journey: Journey?
    var disruptions: [Disruption]?
}

open class JourneySolutionRoadmapScreen: StylizedComponent<JourneySolutionRoadmapState> {
    let StepComponent: Components.Journey.Roadmap.StepComponent.Type = Components.Journey.Roadmap.StepComponent.self
    let PlaceStepComponent: Components.Journey.Roadmap.Steps.PlaceStepComponent.Type = Components.Journey.Roadmap.Steps.PlaceStepComponent.self
    let JourneySolutionComponent: Components.Journey.Results.JourneySolutionComponent.Type = Components.Journey.Results.JourneySolutionComponent.self
    
    var navigationController: UINavigationController?
    
    open override func componentDidMount() {
        self.update()
        for childComponentView in self.childrenComponent.enumerated() {
            if let mapViewComponent = childComponentView.element.value as? JourneyMapViewComponent {
                mapViewComponent.componentDidMount()
            }
        }
    }
    
    override open func render() -> NodeType {
        return ComponentNode(ScreenComponent(), in: self).add(children: [
            ComponentNode(ScreenHeaderComponent(), in: self, props: { (component: ScreenHeaderComponent, _) in
                component.navigationController = self.navigationController
                component.styles = self.screenHeaderStyle
            }),
            Node<UIView>() { view, layout, size in
                layout.height = 0.4 * size.height
            }.add(children: [
                ComponentNode(JourneyMapViewComponent(), in: self, props: { (component: JourneyMapViewComponent, _) in
                    component.styles = self.mapViewStyles
                    component.journey = self.state.journey
                })
            ]),
            ComponentNode(ScrollViewComponent(), in: self).add(children: [
                ComponentNode(ContainerComponent(), in: self).add(children: [
                    ComponentNode(JourneySolutionComponent.init(), in: self, props: { (component: Components.Journey.Results.JourneySolutionComponent, _) in
                        component.journey = self.state.journey!
                        component.disruptions = self.state.disruptions
                        component.isTouchable = false
                    })
                ]),
                ComponentNode(ListViewComponent(), in: self).add(children: getSectionComponents())
            ])
        ])
    }

    func getSectionComponents() -> [NodeType] {
        var sectionComponents: [NodeType] = []
        
        let journey = self.state.journey!
        let disruptions = self.state.disruptions ?? []
        
        let lastIndex = journey.sections!.count - 1
        for (index, section) in journey.sections!.enumerated() {
            if index == 0 {
                sectionComponents.append(
                    ComponentNode(self.PlaceStepComponent.init(), in: self, props: {(components: Components.Journey.Roadmap.Steps.PlaceStepComponent, _) in
                        components.styles = self.originSectionStyles
                        components.datetime = journey.departureDateTime
                        components.placeType = NSLocalizedString("component.PlaceStepComponent.departure", bundle: self.bundle, comment: "")
                        components.placeLabel = section.from?.name!
                        components.backgroundColorProp = config.colors.origin
                    })
                )
            }
            
            if section.type == "street_network" || section.type == "public_transport" || section.type == "transfer" {
                sectionComponents.append(
                    ComponentNode(self.StepComponent.init(), in: self, props: { (component: Components.Journey.Roadmap.StepComponent, _) in
                        component.section = section
                        
                        if section.type == "public_transport" {
                            if index > 0 {
                                let prevSection = journey.sections![index - 1]
                                if prevSection.type == "waiting" {
                                    component.waitingTime = prevSection.duration
                                }
                            }
                            
                            if disruptions.count > 0 {
                                component.disruptions = section.getMatchingDisruptions(from: disruptions)
                            }
                        } else if section.type == "street_network" {
                            let mode = section.mode!
                            var network: String?
                            if index > 0 {
                                let prevSection = journey.sections![index - 1]
                                if prevSection.type == "bss_rent" {
                                    network = ""
                                    if let poi = section.from?.poi, let networkProp = poi.properties?["network"] {
                                        network = networkProp
                                    }
                                    component.isBSS = true
                                }
                            }
                            component.descriptionProp = self.getDescriptionLabel(mode: mode, duration: section.duration!, toLabel: section.to!.name!, network: network, fromLabel: section.from?.name!)
                        } else if section.type == "transfer" {
                            let mode = section.transferType!
                            component.descriptionProp = self.getDescriptionLabel(mode: mode, duration: section.duration!, toLabel: section.to!.name!)
                        }
                    })
                )
            }
            
            if index == lastIndex {
                sectionComponents.append(
                    ComponentNode(self.PlaceStepComponent.init(), in: self, props: {(components: Components.Journey.Roadmap.Steps.PlaceStepComponent, _) in
                        components.styles = self.destinationSectionStyles
                        components.datetime = journey.arrivalDateTime
                        components.placeType = NSLocalizedString("component.PlaceStepComponent.arrival", bundle: self.bundle, comment: "")
                        components.placeLabel = section.to?.name!
                        components.backgroundColorProp = config.colors.destination
                    })
                )
            }
        }
        return sectionComponents
    }

    func getDescriptionLabel(mode: String, duration: Int32, toLabel: String) -> NSMutableAttributedString {
        return self.getDescriptionLabel(mode: mode, duration: duration, toLabel: toLabel, network: nil, fromLabel: nil)
    }
    
    func getDescriptionLabel(mode: String, duration: Int32, toLabel: String, network: String?, fromLabel: String?) -> NSMutableAttributedString {
        let durationLabel: String = durationText(bundle: self.bundle, seconds: duration, useFullFormat: true)
        let descriptionLabel = NSMutableAttributedString.init()
        
        if network != nil {
            let takeStringTemplate = NSLocalizedString("component.JourneyRoadmapStepComponent.mode.bss.take", bundle: self.bundle, comment: "") + " "
            let take = String(format: takeStringTemplate, network!)
            descriptionLabel.append(NSAttributedString.init(string: take))
            
            let departureSpannableString = NSAttributedString.init(string: fromLabel!, attributes: [
                NSFontAttributeName: UIFont.systemFont(ofSize: CGFloat.init(config.metrics.text), weight: UIFontWeightBold)
            ])
            descriptionLabel.append(departureSpannableString)
            
            let inDirection = " " + NSLocalizedString("component.JourneyRoadmapStepComponent.mode.bss.to", bundle: self.bundle, comment: "") + " "
            descriptionLabel.append(NSAttributedString.init(string: inDirection))
        } else {
            let to = NSLocalizedString("component.JourneyRoadmapStepComponent.to", bundle: self.bundle, comment: "") + " "
            descriptionLabel.append(NSAttributedString.init(string: to))
        }
        
        let toSpannableString = NSAttributedString.init(string: toLabel, attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: CGFloat.init(config.metrics.text), weight: UIFontWeightBold)
            ])
        descriptionLabel.append(toSpannableString)
        
        var durationString = "\n"
        switch mode {
        case "walking":
            let walkingStringTemplate = NSLocalizedString("component.JourneyRoadmapStepComponent.mode.walking", bundle: self.bundle, comment: "")
            durationString += String(format: walkingStringTemplate, durationLabel)
            break
        case "bike":
            let bikeStringTemplate = NSLocalizedString("component.JourneyRoadmapStepComponent.mode.bike", bundle: self.bundle, comment: "")
            durationString += String(format: bikeStringTemplate, durationLabel)
            break
        case "car":
            let carStringTemplate = NSLocalizedString("component.JourneyRoadmapStepComponent.mode.car", bundle: self.bundle, comment: "")
            durationString += String(format: carStringTemplate, durationLabel)
            break
        default:
            break
        }
        descriptionLabel.append(NSAttributedString.init(string: durationString))
        
        return descriptionLabel
    }

    let screenHeaderStyle: [String: Any] = [
        "backgroundColor": config.colors.tertiary,
        "height": 20,
    ]
    let mapViewStyles: [String: Any] = [
        "flexGrow": 1,
    ]
    let originSectionStyles: [String: Any] = [
        "marginBottom": config.metrics.margin,
    ]
    let destinationSectionStyles: [String: Any] = [
        "marginTop": config.metrics.margin,
    ]
}
