part of '../painter_controller.dart';

extension PainterControllerItemImage on PainterController {
  /// Adds an image to the painter as a new item, using the provided Uint8List.
  /// The image is inserted at the top of the
  /// items list, and an action is logged.
  ImageItem? addImage(Uint8List image,
      {String? layerTitle, PositionModel? imagePosition, Size? imageSize}) {
    if (image.isNotEmpty) {
      final painterItem = ImageItem(
        id: layerTitle,
        position: imagePosition ?? const PositionModel(),
        image: image,
        layer: LayerSettings(
          title: layerTitle ??
              'Image (${value.items.whereType<ImageItem>().length})',
          index: value.items.length,
        ),
        size: SizeModel(
            width: imageSize?.width ?? 100, height: imageSize?.height ?? 100),
      );
      value = value.copyWith(
        items: value.items.toList()..insert(0, painterItem),
      );
      addAction(
        ActionAddItem(
          item: painterItem,
          listIndex: value.items.length - 1,
          timestamp: DateTime.now(),
          actionType: ActionType.addedImageItem,
        ),
      );
      value.selectedItem = painterItem;

      return painterItem;
    }
    return null;
  }
}
