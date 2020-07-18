import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class CustomObjectPage extends StatefulWidget {
  @override
  _CustomObjectPageState createState() => _CustomObjectPageState();
}

class _CustomObjectPageState extends State<CustomObjectPage> {
  ARKitController arkitController;
  ARKitReferenceNode modelNode;
  ARKitNode legNode;
  ARKitNode headNode;
  ARKitNode tailNode;
  String anchorId;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Custom object on plane Sample')),
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

    print(nodesList);

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
//        lightingModelName: ARKitLightingModel.physicallyBased,
//        diffuse: ARKitMaterialProperty(
//          color: Color(0xFFFFFF.toInt() << 0)
//              .withOpacity(0.5),
//        ),
      )
    ];
  }
}
