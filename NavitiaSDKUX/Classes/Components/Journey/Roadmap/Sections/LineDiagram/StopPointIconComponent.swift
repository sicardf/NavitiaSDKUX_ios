import Foundation
import Render
import NavitiaSDK

extension Components.Journey.Roadmap.Sections.LineDiagram {
    class StopPointIconComponent: ViewComponent {
        var color: UIColor?
        var outerFontSize: Int = 18
        var innerFontSize: Int = 12
        
        override func render() -> NodeType {
            return ComponentNode(ViewComponent(), in: self, props: { (component: ViewComponent, hasKey: Bool) in
                component.styles = self.stopPointIconContainerStyles
            }).add(children: [
                getOuterCicleContainer(color: color!, fontSize: outerFontSize),
                getInnerCircleContainer(fontSize: innerFontSize),
            ])
        }
        
        func getOuterCicleContainer(color: UIColor, fontSize: Int) -> NodeType {
            return ComponentNode(ViewComponent(), in: self, props: { (component: ViewComponent, hasKey: Bool) in
                component.styles = self.circleContainerStyles
            }).add(children: [
                ComponentNode(IconComponent(), in: self, props: { (component: IconComponent, hasKey: Bool) in
                    component.name = "circle-filled"
                    component.styles = [
                        "color": color,
                        "fontSize": fontSize,
                    ]
                })
            ])
        }
        
        func getInnerCircleContainer(fontSize: Int) -> NodeType {
            return ComponentNode(ViewComponent(), in: self, props: { (component: ViewComponent, hasKey: Bool) in
                component.styles = self.circleContainerStyles
            }).add(children: [
                ComponentNode(IconComponent(), in: self, props: { (component: IconComponent, hasKey: Bool) in
                    self.innerCircleStyles["fontSize"] = fontSize
                    component.name = "circle-filled"
                    component.styles = self.innerCircleStyles
                })
            ])
        }
        
        let stopPointIconContainerStyles: [String: Any] = [
            "flexGrow": 1,
            "alignSelf": YGAlign.stretch,
        ]
        
        let circleContainerStyles: [String: Any] = [
            "position": YGPositionType.absolute,
            "start": 0,
            "top": 0,
            "end": 0,
            "bottom": 0,
            "alignItems": YGAlign.center,
            "justifyContent": YGJustify.center,
        ]
        
        var innerCircleStyles: [String: Any] = [
            "color": UIColor.white,
        ]
    }
}