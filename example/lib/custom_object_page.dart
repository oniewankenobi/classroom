import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomObjectPage extends StatefulWidget {
  @override
  _CustomObjectPageState createState() => _CustomObjectPageState();
}

class _CustomObjectPageState extends State<CustomObjectPage> {
  final anchorPointStrings = [
    "Cerebrum",
    "Hippocampus",
    "Parietal Lobe",
  ];

  final anchorPointDescs = [
    "Front of the brain",
    "Part of the brain that deals with memory",
    "Deals with sensory things",
  ];

  PageController bottomSheetPageController = PageController();

  ARKitController arkitController;
  ARKitReferenceNode modelNode;
  ARKitNode legNode;
  ARKitNode headNode;
  ARKitNode tailNode;
  String anchorId;

  @override
  void dispose() {
    bottomSheetPageController?.dispose();
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
          color: Colors.black,
          ),
        ),
        body: Container(
          child: ARKitSceneView(
            enableTapRecognizer: true,
            enableRotationRecognizer: true,
            enablePanRecognizer: true,
            showFeaturePoints: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onNodeTap = (nodes) => _onNodeTapHandler(nodes);
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitPlaneAnchor)) {
      return;
    }
    _addPlane(arkitController, anchor);
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    anchorId = anchor.identifier;
    if (modelNode != null) {
      controller.remove(modelNode.name);
    }
    modelNode = ARKitReferenceNode(
      url: 'models.scnassets/eevee.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.005, 0.005, 0.005),
    );

    legNode = ARKitNode(
      geometry: ARKitSphere(materials: _createRandomColorMaterial(), radius: 0.013),
      position: vector.Vector3(0.015, 0.01, 0.05),
    );

    headNode = ARKitNode(
      geometry: ARKitSphere(materials: _createRandomColorMaterial(), radius: 0.013),
      position: vector.Vector3(0.005, 0.15, 0.1),
    );

    tailNode = ARKitNode(
      geometry: ARKitSphere(materials: _createRandomColorMaterial(), radius: 0.013),
      position: vector.Vector3(0.01, 0.12, -0.09),
    );

    controller.add(modelNode, parentNodeName: anchor.nodeName);
    controller.add(legNode, parentNodeName: anchor.nodeName);
    controller.add(headNode, parentNodeName: anchor.nodeName);
    controller.add(tailNode, parentNodeName: anchor.nodeName);
  }

  void _onNodeTapHandler(List<String> nodesList) {
    for (var i = 0; i < nodesList.length; i++) {
      if(nodesList[i] == legNode.name) {
        // Leg logic
        print("Leg Pressed INFO");
        break;
      } else if (nodesList[i] == tailNode.name) {
        // Tail logic
        print("Super long taillL!!!!");
        break;
      } else if (nodesList[i] == headNode.name) {
        // Head logic
        print("big head boii!");
        break;
      }
    }
  }

  List<ARKitMaterial> _createRandomColorMaterial() {
    return [
      ARKitMaterial(
        shininess: 0,
        transparency: 0.5,
        transparent: ARKitMaterialProperty(
          color: Color(0xFFFFFF.toInt() << 0)
            .withOpacity(0.5)
        ),
      )
    ];
  }

  void _buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0.6),
      builder: (BuildContext context) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(40),
          child: PageView(
            controller: bottomSheetPageController,
            children: <Widget>[
              _buildBottomSheetPage(anchorPointStrings[0], anchorPointDescs[0]),
              _buildBottomSheetPage(anchorPointStrings[1], anchorPointDescs[1]),
              _buildBottomSheetPage(anchorPointStrings[2], anchorPointDescs[2]),
            ],
          ),
        );
      }
  );
}

  Widget _buildBottomSheetPage(String title, String desc) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "•  $desc",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "•  $desc",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "•  $desc",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Add more notes here',
                ),
              ),
            ),
          ),
        ],
    );
  }
}
