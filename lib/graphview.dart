import 'package:first_project/bottom_bar.dart';
import 'package:first_project/node_data.dart';
import 'package:first_project/node_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  NodeData defaultNode = NodeData(id: -1);
  late Paint defaultPaint;
  late Paint edgeFromSrcNodePaint;
  late NodeData isSelected;
  int DEFAULT_ITERATIONS = 1000;
  double REPULSION_RATE = 0.5;
  double REPULSION_PERCENTAGE = 0.4;
  double ATTRACTION_RATE = 0.2;
  double ATTRACTION_PERCENTAGE = 0.3;
  int nodeId = 13;

  void addUser(NodeData srcUser) {
    Node newNode = Node.Id(NodeData(id: nodeId++));
    print(srcUser.id);
    var srcNode = graph.getNodeUsingId(srcUser);
    graph.addEdge(srcNode, newNode, paint: edgeFromSrcNodePaint);
    setState(() {});
  }

  void removeUser(NodeData deleteUser) {
    var deleteNode = graph.getNodeUsingId(deleteUser);
    isSelected = NodeData(id: -1);
    graph.removeNode(deleteNode);
    setState(() {});
  }

  void deleteSelectedOldNode() {
    var node = graph.getNodeUsingId(isSelected);
    List<Edge> edges = graph.getInEdges(node);
    edges.addAll(graph.getOutEdges(node));
    List<Edge> newE = edges
        .map((e) => Edge(e.source, e.destination, paint: defaultPaint))
        .toList();
    graph.removeEdges(edges);
    graph.addEdges(newE);
  }

  void highlightEdge(NodeData nodeData) {
    var node = graph.getNodeUsingId(nodeData);
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    List<Edge> edges = graph.getInEdges(node);
    var edges2 = graph.getOutEdges(node);
    if (edges.isNotEmpty) {
      graph.removeEdges(edges);
      var newEdges = edges
          .map((e) => Edge(e.source, e.destination, paint: paint))
          .toList();
      graph.addEdges(newEdges);
    }
    if (edges2.isNotEmpty) {
      graph.removeEdges(edges2);
      var newE2 = edges2
          .map(
              (e) => Edge(e.source, e.destination, paint: edgeFromSrcNodePaint))
          .toList();
      graph.addEdges(newE2);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InteractiveViewer(
                constrained: false,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.001,
                maxScale: 5.6,
                child: GraphView(
                  graph: graph,
                  algorithm: FruchtermanReingoldAlgorithm(
                    iterations: DEFAULT_ITERATIONS,
                    repulsionRate: REPULSION_RATE,
                    repulsionPercentage: REPULSION_PERCENTAGE,
                    attractionRate: ATTRACTION_RATE,
                    attractionPercentage: ATTRACTION_PERCENTAGE,
                  ),
                  builder: (Node node) {
                    // I can decide what widget should be shown here based on the id
                    var a = node.key!.value as NodeData;
                    return nodeWidget(a);
                  },
                )),
          ),
          BottomBar(isSelected, addUser, removeUser),
        ],
      ),
    ));
  }

  Widget nodeWidget(NodeData nodeData) {
    return GestureDetector(
      onTap: () {
        if (isSelected.id != -1) {
          deleteSelectedOldNode();
        }
        isSelected = nodeData;
        highlightEdge(nodeData);
        print('clicked');
      },
      child: NodeWidget(
          key: ValueKey(nodeData.id),
          idSelected: isSelected.id,
          data: nodeData),
    );
  }

  final Graph graph = Graph()..isTree = false;

  @override
  void initState() {
    super.initState();
    isSelected = defaultNode;
    edgeFromSrcNodePaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    defaultPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    final node1 = Node.Id(NodeData(id: 1));
    final node2 = Node.Id(
        NodeData(id: 2, image: 'assets/images/dogcoin.jpeg', name: 'Dogcoin'));
    final node3 = Node.Id(NodeData(id: 3));
    final node4 = Node.Id(
        NodeData(id: 4, image: 'assets/images/dogcoin.jpeg', name: 'Dogcoin'));
    final node5 = Node.Id(NodeData(id: 5));
    final node6 = Node.Id(
        NodeData(id: 6, image: 'assets/images/dogcoin.jpeg', name: 'Dogcoin'));
    final node7 = Node.Id(NodeData(id: 7));
    final node8 = Node.Id(
        NodeData(id: 8, image: 'assets/images/dogcoin.jpeg', name: 'Dogcoin'));
    final node9 = Node.Id(NodeData(id: 9));
    final node10 = Node.Id(
        NodeData(id: 10, image: 'assets/images/dogcoin.jpeg', name: 'Dogcoin'));
    final node11 = Node.Id(NodeData(id: 11));
    final node12 = Node.Id(NodeData(id: 12));

    graph.addEdge(node1, node2, paint: defaultPaint);
    graph.addEdge(node1, node3, paint: defaultPaint);
    graph.addEdge(node1, node4, paint: defaultPaint);
    graph.addEdge(node2, node5, paint: defaultPaint);
    graph.addEdge(node2, node6, paint: defaultPaint);
    graph.addEdge(node6, node7, paint: defaultPaint);
    graph.addEdge(node6, node8, paint: defaultPaint);
    graph.addEdge(node4, node9, paint: defaultPaint);
    graph.addEdge(node4, node10, paint: defaultPaint);
    graph.addEdge(node4, node11, paint: defaultPaint);
    graph.addEdge(node11, node12, paint: defaultPaint);
  }
}
