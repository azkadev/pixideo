 
/// 
/// ```dart
/// // ignore_for_file: avoid_print, use_build_context_synchronously, public_member_api_docs
/// 
/// import 'dart:io';
/// 
/// import 'package:flutter/material.dart';
/// import 'package:pixideo/pixideo.dart';
///  
/// import "package:path/path.dart" as path;
/// 
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///   runApp(PixideoExampleApp());
/// }
/// 
/// class PixideoExampleApp extends StatelessWidget {
///   const PixideoExampleApp({super.key});
/// 
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       debugShowCheckedModeBanner: false,
///       theme: ThemeData.light(),
///       darkTheme: ThemeData.dark(),
///       themeMode: ThemeMode.system,
///       home: PixideoExampleMainApp(),
///     );
///   }
/// }
/// 
/// class PixideoExampleMainApp extends StatefulWidget {
///   const PixideoExampleMainApp({super.key});
/// 
///   @override
///   State<PixideoExampleMainApp> createState() => _PixideoExampleMainAppState();
/// }
/// 
/// class _PixideoExampleMainAppState extends State<PixideoExampleMainApp> {
///   @override
///   void initState() {
///     // TODO: implement initState
///     super.initState();
///     WidgetsBinding.instance.addPostFrameCallback((_) {
///       setState(() {});
///     });
///   }
/// 
/// 
///   final controller = PixideoController();
/// 
///   @override
///   Widget build(BuildContext context) {
///     final content = Composition(
///       fps: 30,
///       duration: const Time.duration(
///         Duration(seconds: 20),
///       ),
///       width: 1920,
///       height: 1080,
///       //
///       // width: 1080,
///       // height: 1920,
///       child: const ContohSederhanaScene(),
///     );
///     return PixideoWidget(
///       controller: controller,
///       composition: content,
///       projectName: "video_sintetis_azkadev",
///       directoryProject: Directory(
///         path.join(
///           Directory.current.path,
///           "temp",
///           "pixideo",
///           "generated",
///         ),
///       ),
///     );
///   }
/// }
/// 
/// 
/// /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
/// class ContohSederhanaScene extends StatelessWidget {
///   /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
///   const ContohSederhanaScene({super.key});
/// 
///   @override
///   Widget build(BuildContext context) { 
///     return Stack(
///       children: [
///         Series(
///           children: [
///             // Intro
///             ...() {
///               final String textIntro = """
/// Hai selamat datang di channel azkadev
/// """
///                   .trim();
///               final child = Center(
///                 child: Padding(
///                   padding: EdgeInsetsGeometry.all(10),
///                   child: TextWithBorderWidget(
///                     text: textIntro,
///                     overflow: TextOverflow.clip,
///                     strokeWidth: 10,
///                     textStyleBuilder: (context, textStyle) {
///                       return textStyle.copyWith(
///                         fontSize: 150,
///                         fontWeight: FontWeight.w900,
///                       );
///                     },
///                   ),
///                 ),
///               );
///               return [
///                 SeriesSequence(
///                   marker: const SeriesMarker('Slide Intro'),
///                   duration: const Time.duration(Duration(milliseconds: 500)),
///                   child: SlideWidget(
///                     background: Colors.red,
///                     foreground: Colors.white,
///                     child: child,
///                   ),
///                 ),
///                 SeriesSequence(
///                   marker: const SeriesMarker('Intro'),
///                   duration: const Time.duration(Duration(seconds: 5)),
///                   child: Freeze(
///                     time: const Time.relative(1),
///                     child: SlideWidget(
///                       background: Colors.red,
///                       foreground: Colors.white,
///                       child: child,
///                     ),
///                   ),
///                 ),
///               ];
///             }(),
///             ...() {
///               final String textIntro = """
/// Di video ini aku akan menunjukan sebuah project contoh yang aku buat
/// """
///                   .trim();
///               final child = Center(
///                 child: Padding(
///                   padding: EdgeInsetsGeometry.all(10),
///                   child: TextWithBorderWidget(
///                     text: textIntro,
///                     overflow: TextOverflow.clip,
///                     strokeWidth: 10,
///                     textStyleBuilder: (context, textStyle) {
///                       return textStyle.copyWith(
///                         fontSize: 150,
///                         fontWeight: FontWeight.w900,
///                       );
///                     },
///                   ),
///                 ),
///               );
///               return [
///                 SeriesSequence(
///                   marker: const SeriesMarker('Content'),
///                   duration: const Time.duration(Duration(milliseconds: 500)),
///                   child: SlideWidget(
///                     background: Colors.blue,
///                     foreground: Colors.white,
///                     child: child,
///                   ),
///                 ),
///                 SeriesSequence(
///                   marker: const SeriesMarker('Content'),
///                   duration: const Time.duration(Duration(seconds: 5)),
///                   child: Freeze(
///                     time: const Time.relative(1),
///                     child: SlideWidget(
///                       background: Colors.blue,
///                       foreground: Colors.white,
///                       child: child,
///                     ),
///                   ),
///                 ),
///               ];
///             }(),
///             ...() {
///               final String textIntro = """
/// Check saja di github 
/// 
/// https://github.com/azkadev/pixideo
/// """
///                   .trim();
///               final child = Center(
///                 child: Padding(
///                   padding: EdgeInsetsGeometry.all(10),
///                   child: TextWithBorderWidget(
///                     text: textIntro,
///                     overflow: TextOverflow.clip,
///                     strokeWidth: 10,
///                     textStyleBuilder: (context, textStyle) {
///                       return textStyle.copyWith(
///                         fontSize: 100,
///                         fontWeight: FontWeight.w900,
///                       );
///                     },
///                   ),
///                 ),
///               );
///               return [
///                 SeriesSequence(
///                   marker: const SeriesMarker('Content'),
///                   duration: const Time.duration(Duration(milliseconds: 500)),
///                   child: SlideWidget(
///                     background: Colors.blue,
///                     foreground: Colors.white,
///                     child: child,
///                   ),
///                 ),
///                 SeriesSequence(
///                   marker: const SeriesMarker('Content'),
///                   duration: const Time.duration(Duration(seconds: 5)),
///                   child: Freeze(
///                     time: const Time.relative(1),
///                     child: SlideWidget(
///                       background: Colors.blue,
///                       foreground: Colors.white,
///                       child: child,
///                     ),
///                   ),
///                 ),
///               ];
///             }(),
///             SeriesSequence(
///               marker: const SeriesMarker('Terimakasih'),
///               duration: const Time.duration(Duration(hours: 24)),
///               child: Freeze(
///                 time: const Time.relative(1),
///                 child: SlideWidget(
///                   background: Colors.yellow,
///                   foreground: Colors.black,
///                   child: Center(
///                     child: Padding(
///                       padding: EdgeInsetsGeometry.all(10),
///                       child: TextWithBorderWidget(
///                         text: "Terimakasih",
///                         overflow: TextOverflow.clip,
///                         strokeWidth: 10,
///                         textStyleBuilder: (context, textStyle) {
///                           return textStyle.copyWith(
///                             fontSize: 150,
///                             fontWeight: FontWeight.w900,
///                           );
///                         },
///                       ),
///                     ),
///                   ),
///                 ),
///               ),
///             ),
///           ],
///         ),
///       ], 
///     );
///   }
/// }
///  
/// /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
/// class SlideWidget extends StatelessWidget {
///   /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
///   final Widget child;
/// 
///   /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
///   final Color background;
/// 
///   /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
///   final Color foreground;
/// 
///   /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
///   const SlideWidget({
///     super.key,
///     required this.child,
///     this.background = Colors.white,
///     this.foreground = Colors.black,
///   });
/// 
///   @override
///   Widget build(BuildContext context) {
///     final time = context.video.time();
///     final MediaQueryData mediaQueryData = MediaQuery.of(context);
///     final Size size = mediaQueryData.size;
///     return Container(
///       color: background,
///       height: size.height,
///       child: Opacity(
///         opacity: time,
///         child: Transform.translate(
///           offset: Offset(0, 100 * (1 - Curves.easeOut.transform(time))),
///           child: child,
///         ),
///       ),
///     );
///   }
/// }
///   
/// /// UncompleteDocumentation
/// class TextWithBorderWidget extends StatelessWidget {
///   /// UncompleteDocumentation
///   final String text;
/// 
///   /// UncompleteDocumentation
///   final TextAlign? textAlign;
/// 
///   /// UncompleteDocumentation
///   final double strokeWidth;
/// 
///   /// UncompleteDocumentation
///   final Color? strokeColor;
/// 
///   /// UncompleteDocumentation
///   final TextOverflow? overflow;
/// 
///   /// UncompleteDocumentation
///   final TextStyle Function(BuildContext context, TextStyle textStyle)? textStyleBuilder;
/// 
///   /// UncompleteDocumentation
///   const TextWithBorderWidget({
///     super.key,
///     required this.text,
///     this.strokeColor,
///     this.strokeWidth = 6,
///     this.textStyleBuilder,
///     this.textAlign = TextAlign.center,
///     this.overflow = TextOverflow.ellipsis,
///   });
/// 
///   /// UncompleteDocumentation
///   TextStyle textStyleBuilderWidgetDefault(BuildContext context, TextStyle style) {
///     return style;
///   }
/// 
///   @override
///   Widget build(BuildContext context) {
///     final ThemeData theme = Theme.of(context);
///     final TextStyle textStyle = (textStyleBuilder ?? textStyleBuilderWidgetDefault).call(
///         context,
///         (theme.textTheme.titleMedium ?? const TextStyle()).copyWith(
///           color: theme.indicatorColor,
///           fontWeight: FontWeight.bold,
///         ));
///     return Stack(
///       children: List.generate(
///         2,
///         (index) {
///           return Text(
///             text,
///             style: () {
///               if (index == 0) {
///                 final Paint foreground = Paint();
///                 foreground.style = PaintingStyle.stroke;
///                 foreground.strokeWidth = strokeWidth;
/// 
///                 if (strokeColor != null) {
///                   foreground.color = strokeColor!;
///                 } else {
///                   foreground.color = theme.indicatorColor == Colors.black ? Colors.white : Colors.black;
///                 }
///                 return textStyle.copyWith(
///                   color: null,
///                   foreground: foreground,
///                 );
///               }
///               return textStyle;
///             }(),
///             textAlign: textAlign,
///             overflow: overflow,
///           );
///         },
///       ),
///     );
///   }
/// }
/// 
/// ```
/// 
/// 
library;

export 'core/composition.dart';
export 'core/config.dart';
export 'core/context_extensions.dart';
export 'core/controller.dart';
export 'core/loop.dart';
export 'core/markers.dart';
export 'core/freeze.dart';
export 'core/sequence.dart';
export 'core/series.dart';
export 'core/time.dart';


export "widget/widget.dart";