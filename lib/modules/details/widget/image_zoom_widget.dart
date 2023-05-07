import 'package:adope/core/model/hive_model.dart';
import 'package:flutter/material.dart';

class ImageZoomWidget extends StatefulWidget {
  final PetModel petModel;

  const ImageZoomWidget({
    Key? key,
    required this.petModel,
  }) : super(key: key);

  @override
  State<ImageZoomWidget> createState() => _ImageZoomWidgetState();
}

class _ImageZoomWidgetState extends State<ImageZoomWidget> {
  late TransformationController transformationController;

  @override
  void initState() {
    super.initState();
    transformationController = TransformationController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: InteractiveViewer(
                child: Hero(
                  tag: widget.petModel.id,
                  child: Image.network(
                    widget.petModel.imagePath,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
