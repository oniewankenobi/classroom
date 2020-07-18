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
  ARKitReferenceNode node;
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
    floatingActionButton: FloatingActionButton(
      onPressed: () => _buildBottomSheet(context),
      child: Icon(
        Icons.radio,
      ),
    ),
    body: Container(
      child: ARKitSceneView(
        showFeaturePoints: true,
        planeDetection: ARPlaneDetection.horizontal,
        onARKitViewCreated: onARKitViewCreated,
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
    if (node != null) {
      controller.remove(node.name);
    }
    node = ARKitReferenceNode(
      url: 'models.scnassets/brain.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.002, 0.002, 0.002),
    );
    controller.add(node, parentNodeName: anchor.nodeName);
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
