import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:hotel_pbp/invoice/get_total_invoice.dart';
import 'package:hotel_pbp/invoice/item_doc.dart';
import 'package:hotel_pbp/invoice/model/custom_row_invoice.dart';
import 'package:hotel_pbp/invoice/model/hotel_room.dart';
import 'package:hotel_pbp/pdf/preview_screen.dart';
import 'package:hotel_pbp/model/user.dart';

Future<void> createPdf(User? currentUser, String id, BuildContext context,
    String name, String price, String jumlah) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  final pricee = int.parse(price); // Menampilkan waktu terbuatnya document PDF
  final jumlahh = int.parse(jumlah);

  // Mengambil gambar dari asset untuk ditampilkan pada document PDF untuk header document PDF dan logo untuk invoicenya :
  final imageLogo =
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List();
  final imageInvoice = pw.MemoryImage(imageLogo);

  // Memberi border pada document PDF :
  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
            width: 1.w,
          ),
        ),
      );
    },
  );

  final List<CustomRow> elements = [
    CustomRow('Item Name', 'Item Price', 'Amount', 'Sub Total Product'),
    CustomRow(
      name,
      pricee.toString(),
      jumlahh.toString(),
      (pricee * jumlahh).toString(),
    ),
    CustomRow(
      'Sub Total',
      '',
      '',
      'Rp ${pricee * jumlahh}',
    ),
    CustomRow(
      'PPN Total(11%)',
      '',
      '',
      'Rp ${(pricee / 100 * 11) * jumlahh}',
    ),
    CustomRow(
      'Total',
      '',
      '',
      'Rp ${(pricee * jumlahh) + ((pricee / 100 * 11) * jumlahh)}',
    ),
  ];

  pw.Widget table = itemColumn(elements);

  doc.addPage(
    pw.MultiPage(
        
      pageTheme: pdfTheme,
      // Header PDF :
      header: (pw.Context context) {
        return headerPDF();
      },
      // Isi halaman PDF :
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Bagian PDF yang menampilkan invoice :
                topOfInvoice(imageInvoice, currentUser),
                pw.SizedBox(height: 5.h),

                contentOfInvoice(table),

                // Barcode didalam document PDF :
                barcodeKotak(id),
                pw.SizedBox(height: 1.h),
              ],
            ),
          ),
        ];
      },
      // Bagian Footer :
      footer: (pw.Context context) {
        return pw.Container(
          color: PdfColor.fromHex('#FFBD59'),
          child: footerPDF(formattedDate),
        );
      },
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PreviewScreen(doc: doc),
    ),
  );
}

pw.Header headerPDF() {
  return pw.Header(
    margin: pw.EdgeInsets.zero,
    outlineColor: PdfColors.amber50,
    outlineStyle: PdfOutlineStyle.normal,
    level: 5,
    decoration: pw.BoxDecoration(
      shape: pw.BoxShape.rectangle,
      gradient: pw.LinearGradient(
        colors: [
          PdfColor.fromHex('#FCDF8A'),
          PdfColor.fromHex('#F38381'),
        ],
        begin: pw.Alignment.topLeft,
        end: pw.Alignment.bottomRight,
      ),
    ),
    child: pw.Center(
      child: pw.Text(
        'Hotel Room Invoice',
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    ),
  );
}

pw.Padding topOfInvoice(
  pw.MemoryImage imageInvoice,
  User? currentUser,
) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Image(
          imageInvoice,
          height: 30.h,
          width: 30.w,
        ),
      //   pw.Expanded(
      //     child: pw.Container(
      //       height: 10.h,
      //       decoration: const pw.BoxDecoration(
      //         borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
      //         color: PdfColors.amberAccent,
      //       ),
      //       padding: const pw.EdgeInsets.only(
      //         left: 40,
      //         top: 10,
      //         bottom: 10,
      //         right: 40,
      //       ),
      //       alignment: pw.Alignment.centerLeft,
      //       child: pw.DefaultTextStyle(
      //         style: const pw.TextStyle(
      //           color: PdfColors.amber100,
      //           fontSize: 12,
      //         ),
      //         child: pw.GridView(
      //           crossAxisCount: 2,
      //           children: [
      //             pw.Text(
      //               'Customer:',
      //               style: pw.TextStyle(
      //                 fontSize: 10.sp,
      //                 color: PdfColors.blue800,
      //               ),
      //             ),
      //             pw.Text(
      //               currentUser!.username!,
      //               style: pw.TextStyle(
      //                 fontSize: 10.sp,
      //                 color: PdfColors.blue800,
      //               ),
      //             ),
      //             pw.SizedBox(height: 1.h),
      //             pw.Text(
      //               'Email:',
      //               style: pw.TextStyle(
      //                 fontSize: 10.sp,
      //                 color: PdfColors.blue800,
      //               ),
      //             ),
      //             pw.SizedBox(height: 1.h),
      //             pw.Text(
      //               currentUser.email!,
      //               style: pw.TextStyle(
      //                 fontSize: 10.sp,
      //                 color: PdfColors.blue800,
      //               ),
      //             ),
      //             pw.SizedBox(height: 1.h),
      //             pw.Text(
      //               'Phone Number:',
      //               style: pw.TextStyle(
      //                 fontSize: 10.sp,
      //                 color: PdfColors.blue800,
      //               ),
      //             ),
      //             pw.Text(
      //               currentUser.nomorTelepon!,
      //               style: pw.TextStyle(
      //                 fontSize: 10.sp,
      //                 color: PdfColors.blue800,
      //               ),
      //             ),
      //             pw.SizedBox(height: 1.h),
      //             pw.Text(
      //               'Origin:',
      //               style: pw.TextStyle(
      //                 fontSize: 10.sp,
      //                 color: PdfColors.blue800,
      //               ),
      //             ),
      //             pw.Text(
      //               currentUser.origin!,
      //               style: pw.TextStyle(
      //                 fontSize: 10.sp,
      //                 color: PdfColors.blue800,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      ],
    ),
  );
}

pw.Padding contentOfInvoice(pw.Widget table) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Column(
      children: [
        pw.Text('Dear Customer, Thank you for buying our hotel room, '),
        pw.SizedBox(height: 3.h),
        table, // Table yang sudah diatur tampilannya didalam file item_doc.dart
        pw.Text('Thanks for your trust, and till the next time.'),
        pw.SizedBox(height: 3.h),
        pw.Text('Kind regards,'),
        pw.SizedBox(height: 3.h),
        pw.Text('Hotel\'s Management'),
      ],
    ),
  );
}

pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
    child: pw.Center(
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: id,
        width: 15.w,
        height: 15.h,
      ),
    ),
  );
}

pw.Container barcodeGaris(String id) {
  return pw.Container(
    child: pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child: pw.BarcodeWidget(
        barcode: Barcode.code128(escapes: true),
        data: id,
        width: 10.w,
        height: 5.h,
      ),
    ),
  );
}

pw.Center footerPDF(String formattedDate) => pw.Center(
      child: pw.Text(
        'Created At $formattedDate',
        style: pw.TextStyle(
          fontSize: 10.sp,
          color: PdfColors.blue,
        ),
      ),
    );
