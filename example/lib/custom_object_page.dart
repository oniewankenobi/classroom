import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomObjectPage extends StatefulWidget {
  @override
  _CustomObjectPageState createState() => _CustomObjectPageState();
}

class _CustomObjectPageState extends State<CustomObjectPage> {
  final anchorPointStrings = [
    "Strong Legs",
    "Fluffy Tail",
    "Eevie's Head",
  ];

  final anchorPointDescs = [
    "Eevee, the Evolution Pokémon. Eevee is a unique Pokémon that can adapt to its environment by changing its form and abilities when evolving.",
    "Eevee evolves into one of three Pokémon, depending on what stone is used on it.",
    "An Eevee has an unstable genetic makeup that suddenly mutates due to its environment. Radiation from various stones causes this Pokémon to evolve.",
  ];

  PageController bottomSheetPageController = PageController();

  ARKitController arkitController;
  ARKitReferenceNode modelNode;
  ARKitNode legNode;
  ARKitNode headNode;
  ARKitNode tailNode;
  String anchorId;
  int _selectedNode = -1;

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
            onARKitViewCreated: (ARKitController arkitController) => onARKitViewCreated(arkitController, context),
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController, BuildContext context) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onNodeTap = (nodes) => _onNodeTapHandler(context, nodes);
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
      geometry: ARKitSphere(materials: _createRandomColorMaterial(this._selectedNode == 0), radius: 0.013),
      position: vector.Vector3(0.015, 0.01, 0.05),
    );

    headNode = ARKitNode(
      geometry: ARKitSphere(materials: _createRandomColorMaterial(this._selectedNode == 2), radius: 0.013),
      position: vector.Vector3(0.005, 0.15, 0.1),
    );

    tailNode = ARKitNode(
      geometry: ARKitSphere(materials: _createRandomColorMaterial(this._selectedNode == 1), radius: 0.013),
      position: vector.Vector3(0.01, 0.12, -0.09),
    );

    controller.add(modelNode, parentNodeName: anchor.nodeName);
    controller.add(legNode, parentNodeName: anchor.nodeName);
    controller.add(headNode, parentNodeName: anchor.nodeName);
    controller.add(tailNode, parentNodeName: anchor.nodeName);
  }

  void _onNodeTapHandler(BuildContext context, List<String> nodesList) {
    for (var i = 0; i < nodesList.length; i++) {
      if(nodesList[i] == legNode.name) {
        // Leg logic
        print("Leg Pressed INFO");
//        legNode.geometry.materials = _createRandomColorMaterial(true);
//        tailNode.geometry.materials = _createRandomColorMaterial(false);
//        headNode.geometry.materials = _createRandomColorMaterial(false);
        _buildBottomSheet(context, 0);
        break;
      } else if (nodesList[i] == tailNode.name) {
        // Tail logic
        print("Super long taillL!!!!");
        setState(() {
          _selectedNode = 1;
        });
//        legNode.geometry.materials = _createRandomColorMaterial(false);
//        tailNode.geometry.materials = _createRandomColorMaterial(true);
//        headNode.geometry.materials = _createRandomColorMaterial(false);
        _buildBottomSheet(context, 1);
        break;
      } else if (nodesList[i] == headNode.name) {
        // Head logic
        print("big head boii!");
        setState(() {
          _selectedNode = 2;
        });
//        legNode.geometry.materials = _createRandomColorMaterial(false);
//        tailNode.geometry.materials = _createRandomColorMaterial(false);
//        headNode.geometry.materials = _createRandomColorMaterial(true);
        _buildBottomSheet(context, 2);
        break;
      }
    }
  }

  List<ARKitMaterial> _createRandomColorMaterial(bool isSelected) {
    print("SELECTED NODE: $_selectedNode");
    var color;
    if (isSelected) {
      color = Colors.red;
      print("------ RED --------");
    } else {
      color = Color(0xFFFFFF.toInt() << 0)
          .withOpacity(0.5);
    }
    return [
      ARKitMaterial(
        shininess: 0,
        transparency: 0.5,
        transparent: ARKitMaterialProperty(
          color: color,
        ),
      )
    ];
  }

  void _buildBottomSheet(BuildContext context, int initialPage) {
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
            controller: PageController(
              initialPage: initialPage,
            ),
            onPageChanged: (int index) {

            },
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
