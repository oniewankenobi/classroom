import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  ARKitController arkitController;
  ARKitReferenceNode node;
  String anchorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AR Page"),
      ),
      body: ARKitSceneView(
        showFeaturePoints: true,
        planeDetection: ARPlaneDetection.horizontal,
        onARKitViewCreated: onARKitViewCreated,
      ),
    );
  }

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
      url: 'Models.scnassets/eevie.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.002, 0.002, 0.002),
    );
    controller.add(node, parentNodeName: anchor.nodeName);
  }
}