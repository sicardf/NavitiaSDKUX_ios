import Foundation
import Render
import NavitiaSDK

class JourneyRoadmapSectionComponent: ViewComponent {
    var section: Section?

    public required init() {
        super.init()
        NSLog("#SCREEN level 1# JourneyRoadmapSectionComponent init")
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func render() -> NodeType {
        switch self.section!.type! {
        case "transfer":
            return ComponentNode(JourneyRoadmapSectionTransferComponent(), in: self, props: { (component: JourneyRoadmapSectionTransferComponent, hasKey: Bool) in
                component.section = self.section
            })
        case "public_transport":
            NSLog("#SCREEN level 1# JourneyRoadmapSectionComponent public_transport")
            return ComponentNode(JourneyRoadmapSectionPublicTransportComponent(),
                    in: self,
                    key: "\(String(describing: type(of: self)))_\(self.section!.type!)_\(self.section!.departureDateTime!)",
                    props: { (component: JourneyRoadmapSectionPublicTransportComponent, hasKey: Bool) in
                        NSLog("#SCREEN level 1# JourneyRoadmapSectionComponent public_transport configuration \(self.section!.displayInformations!.label!)")
                        component.section = self.section
                    }
            )
        default:
            return ComponentNode(JourneyRoadmapSectionDefaultComponent(), in: self, props: { (component: JourneyRoadmapSectionDefaultComponent, hasKey: Bool) in
                component.section = self.section
            })
        }
    }
}
