import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BrainARPage extends StatefulWidget {
  @override
  _CustomObjectPageState createState() => _CustomObjectPageState();
}

class _CustomObjectPageState extends State<BrainARPage> {
  final anchorPointStrings = [
    "Cerebrum",
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
        onARKitViewCreated: (ARKitController arkitController) => onARKitViewCreated(arkitController),
      ),
    ),
  );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
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
      url: 'models.scnassets/brain.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.002, 0.002, 0.002),
    );
    controller.add(modelNode, parentNodeName: anchor.nodeName);
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
