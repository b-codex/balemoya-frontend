import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:balemoya/account/profile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<UserResume> fetchPost({required sessionID}) async {
  final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:8000/microservice/accountService/users/profile'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $sessionID'
      }).timeout(Duration(seconds: 120));
  print(response.body);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    return UserResume.fromJson(parsed);
  } else {
    throw Exception('Failed to load file');
  }
}

Future createPDF({required String sessionID}) async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();
  UserResume userResumeData = await fetchPost(sessionID: sessionID);

  page.graphics.drawString(
      userResumeData.fullName,
      // page.graphics.drawString(UserResume.fullName,
      PdfStandardFont(PdfFontFamily.helvetica, 28, style: PdfFontStyle.bold));
  //profession
  page.graphics.drawString(
      userResumeData.profession.isEmpty ? " " : userResumeData.profession.first,
      PdfStandardFont(PdfFontFamily.helvetica, 17),
      bounds: Rect.fromLTWH(0, 40, 500, 40));
  //phone Number
  page.graphics.drawString("Phone Number:${userResumeData.phoneNumber}",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0, 80, 500, 40));
  //email
  page.graphics.drawString("Email: ${userResumeData.email}",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0, 95, 0, 40));
  //Description
  final PdfLayoutResult layoutResult = PdfTextElement(
          text: userResumeData.description,
          font: PdfStandardFont(PdfFontFamily.helvetica, 10),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)))
      .draw(
          page: page,
          bounds: Rect.fromLTWH(
              0, 120, page.getClientSize().width, page.getClientSize().height),
          format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
  //previousExperience
  page.graphics.drawString("Previous Experience",
      PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          0, 180, page.getClientSize().width, page.getClientSize().height));
  page.graphics.drawLine(
      PdfPen(PdfColor(205, 205, 205)),
      Offset(0, layoutResult.bounds.bottom + 40),
      Offset(page.getClientSize().width, layoutResult.bounds.bottom + 40));

  if (userResumeData.previousExperience.length >= 1) {
    // final DateTime now = DateTime.now();

    PdfTextElement(
            text: userResumeData.previousExperience[0]["dateStarted"],
            font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
                style: PdfFontStyle.bold))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 210, page.getClientSize().width / 4,
                page.getClientSize().height / 2));
    PdfTextElement(
            text: userResumeData.previousExperience.length >= 1
                ? userResumeData.previousExperience[0]
                : "",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 12))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                page.getClientSize().width / 5,
                210,
                3 * page.getClientSize().width / 2,
                page.getClientSize().height / 2));
  }
  if (userResumeData.previousExperience.length >= 2) {
    PdfTextElement(
            text: "29-02-11",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
                style: PdfFontStyle.bold))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 260, page.getClientSize().width / 4,
                page.getClientSize().height / 2));
    PdfTextElement(
            text: userResumeData.previousExperience.length >= 2
                ? userResumeData.previousExperience[1]
                : "",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 12))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                page.getClientSize().width / 5,
                260,
                3 * page.getClientSize().width / 2,
                page.getClientSize().height / 2));
  }
  if (userResumeData.previousExperience.length >= 3) {
    PdfTextElement(
            text: "29-02-11",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
                style: PdfFontStyle.bold))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 310, page.getClientSize().width / 4,
                page.getClientSize().height / 2));
    PdfTextElement(
            text: userResumeData.previousExperience.length >= 3
                ? userResumeData.previousExperience[2]
                : "",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 12))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                page.getClientSize().width / 5,
                310,
                3 * page.getClientSize().width / 2,
                page.getClientSize().height / 2));
  }

  // PdfUnorderedList(

  //         text:
  //             'It is a long Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \nIt is a long Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using\nIt is a long Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
  //         style: PdfUnorderedMarkerStyle.square,
  //         font: PdfStandardFont(PdfFontFamily.helvetica, 11),
  //         indent: 10,
  //         textIndent: 10,
  //         format: PdfStringFormat(lineSpacing: 10))
  //     .draw(
  //         page: page,
  //         bounds: Rect.fromLTWH(
  //             0, 210, page.getClientSize().width, page.getClientSize().height));
  // educationalBackground[0]alBackground
  page.graphics.drawString("Educational Background",
      PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          0, 370, page.getClientSize().width, page.getClientSize().height));
  page.graphics.drawLine(
      PdfPen(PdfColor(205, 205, 205)),
      Offset(0, layoutResult.bounds.bottom + 230),
      Offset(page.getClientSize().width, layoutResult.bounds.bottom + 230));
  if (userResumeData.educationalBackground.length >= 1) {
    PdfTextElement(
            text: "29-02-11",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
                style: PdfFontStyle.bold))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 400, page.getClientSize().width / 4,
                page.getClientSize().height / 2));
    PdfTextElement(
            text: userResumeData.educationalBackground.length >= 1
                ? userResumeData.educationalBackground[0]
                : "",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 12))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                page.getClientSize().width / 5,
                400,
                3 * page.getClientSize().width / 2,
                page.getClientSize().height / 2));
  }
  if (userResumeData.educationalBackground.length >= 2) {
    PdfTextElement(
            text: "29-02-11",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
                style: PdfFontStyle.bold))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 450, page.getClientSize().width / 4,
                page.getClientSize().height / 2));
    PdfTextElement(
            text: userResumeData.educationalBackground.length >= 2
                ? userResumeData.educationalBackground[1]
                : "",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 12))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                page.getClientSize().width / 5,
                450,
                3 * page.getClientSize().width / 2,
                page.getClientSize().height / 2));
  }
  if (userResumeData.educationalBackground.length >= 3) {
    PdfTextElement(
            text: "29-02-11",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
                style: PdfFontStyle.bold))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 500, page.getClientSize().width / 4,
                page.getClientSize().height / 2));
    PdfTextElement(
            text: userResumeData.educationalBackground.length >= 3
                ? userResumeData.educationalBackground[2]
                : "",
            font: PdfStandardFont(PdfFontFamily.timesRoman, 12))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                page.getClientSize().width / 5,
                500,
                3 * page.getClientSize().width / 2,
                page.getClientSize().height / 2));
  }

  // PdfUnorderedList(
  //         text:
  //             'It is a long Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \nIt is a long Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using\nIt is a long Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
  //         style: PdfUnorderedMarkerStyle.square,
  //         font: PdfStandardFont(PdfFontFamily.helvetica, 11),
  //         indent: 10,
  //         textIndent: 10,
  //         format: PdfStringFormat(lineSpacing: 10))
  //     .draw(
  //         page: page,
  //         bounds: Rect.fromLTWH(
  //             0, 400, page.getClientSize().width, page.getClientSize().height));

// Create a new PDF text element class and draw the flow layout text.
  // page.graphics.drawString("References",
  //     PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
  //     bounds: Rect.fromLTWH(
  //         0, 550, page.getClientSize().width, page.getClientSize().height));
  // page.graphics.drawLine(
  //     PdfPen(PdfColor(205, 205, 205)),
  //     Offset(0, layoutResult.bounds.bottom + 410),
  //     Offset(page.getClientSize().width, layoutResult.bounds.bottom + 410));
  // PdfUnorderedList(
  //         text: userResumeData.refer.isEmpty
  //             ? ""
  //             : userResumeData.profession.first,
  //         style: PdfUnorderedMarkerStyle.square,
  //         font: PdfStandardFont(PdfFontFamily.helvetica, 11),
  //         indent: 10,
  //         textIndent: 10,
  //         format: PdfStringFormat(lineSpacing: 10))
  //     .draw(
  //         page: page,
  //         bounds: Rect.fromLTWH(
  //             0, 580, page.getClientSize().width, page.getClientSize().height));
// Draw the next paragraph/content.

  List<int> bytes = document.save();
  document.dispose();

  saveAndLaunchFile(bytes, "Output.pdf");
  return {'success': true};
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}
