import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soft_bill/list/empty_state.dart';
import 'package:soft_bill/list/form.dart';
import 'package:soft_bill/list/user.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];
  TextEditingController cous_name = new TextEditingController();
  TextEditingController store_add = new TextEditingController();
  TextEditingController store_name = new TextEditingController();
  TextEditingController cous_no = new TextEditingController();
  TextEditingController seller = new TextEditingController();
  String netP;
  var dandt = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        title: Text('XYZ Company'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF30C1FF),
              Color(0xFF2AA7DC),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: users.length <= 0
            ? ListView(
            children:<Widget> [
        new Column(
            children:<Widget> [
              Padding(
                padding: EdgeInsets.all(16),
                child: Material(
                  elevation: 1,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(8),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppBar(
                          leading: Icon(Icons.verified_user),
                          elevation: 0,
                          title: Text('Enter Seller Details'),
                          backgroundColor: Theme.of(context).accentColor,
                          centerTitle: true,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: TextFormField(
                            controller: seller,
                            decoration: InputDecoration(
                              labelText: 'Enter Seller Name :',
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: TextFormField(
                            controller: store_name,
                            decoration: InputDecoration(
                              labelText: 'Enter Store Name :',
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: TextFormField(
                            controller: store_add,
                            decoration: InputDecoration(
                              labelText: 'Enter Store Address :',
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: TextFormField(
                            controller: cous_name,
                            decoration: InputDecoration(
                              labelText: 'Enter Customer Name :',
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16,bottom: 24),
                          child: TextFormField(
                            controller: cous_no,
                            decoration: InputDecoration(
                              labelText: 'Enter Customer Number :',
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              EmptyState(
                title: 'Welcome',
                message: 'Add Item by tapping add button below',
              ),
            ]
        )])
            : ListView.builder(
          addAutomaticKeepAlives: true,
          itemCount: users.length,
          itemBuilder: (_, i) => users[i],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
            (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());

      if (allValid) {
        var t=0;
        var data = users.map((it) => it.user).toList();
        for(int i=0;i<data.length;i++){
          t=t+int.parse(data[i].a);
        }
        this.netP=t.toString();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
                appBar: AppBar(
                  title: Text('Bill Preview'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('PDF'),
                      textColor: Colors.white,
                      onPressed: _createPDF,
                    )
                  ],
                ),
                body: Column(
                  children: <Widget>[
                    new Expanded(
                      child: new ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (_, i) => ListTile(
                            leading: CircleAvatar(
                              child: Text(data[i].fullName.substring(0, 1)),
                            ),
                            title: Text(data[i].fullName),
                            subtitle: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Price'),
                                    Text('Quantity'),
                                    Text('Total'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(data[i].price),
                                    Text(data[i].qty),
                                    Text(data[i].a),

                                  ],
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                    new Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF30C1FF),
                              Color(0xFF2AA7DC),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16,bottom: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Total Bill : ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                              Text('Rs. '+t.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                    )
                  ],
                )
            ),
          ),
        );
      }
    }
  }

  Future<void> _createPDF() async {

    //Create a PDF document.
//Creates a new PDF document
    PdfDocument document = PdfDocument();

//Adds page settings
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.margins.all = 50;

//Adds a page to the document
    PdfPage page = document.pages.add();
    PdfGraphics graphics = page.graphics;    //Add page and draw text to the page.

    var data = users.map((it) => it.user).toList();

    Widget _getData01(List listOfData) {
      List<DataRow> rows = [];

      for(int i=0;i<data.length;i++)
      {
        rows.add(
            DataRow(
                cells: [
                  DataCell(
                    Text(data[i].fullName),
                  ),
                  DataCell(
                    Text(data[i].price),
                  ),
                  DataCell(
                    Text(data[i].qty),
                  ),
                  DataCell(
                    Text(data[i].a),
                  ),
                ]
            )
        );
      }

      return DataTable(
        columns: [
          DataColumn(
            label: Text("FullName"),
            numeric: false,
          ),
          DataColumn(
            label: Text("Price"),
            numeric: false,
          ),
          DataColumn(
            label: Text("Qty"),
            numeric: false,
          ),
          DataColumn(
            label: Text("Amount"),
            numeric: false,
          ),
        ],
        rows: rows,
      );
    }


    PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    Rect bounds = Rect.fromLTWH(0, 160, graphics.clientSize.width, 30);

//Draws a rectangle to place the heading in that region
    graphics.drawRectangle(brush: solidBrush, bounds: bounds);

//Creates a font for adding the heading in the page
    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);

//Creates a text element to add the invoice number
    PdfTextElement element =
    PdfTextElement(text: 'INVOICE 001', font: subHeadingFont);
    element.brush = PdfBrushes.white;

//Draws the heading on the page
    PdfLayoutResult result =
    element.draw(page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0));
    String currentDate = this.dandt.toString();

//Measures the width of the text to place it in the correct location
    Size textSize = subHeadingFont.measureString(currentDate);
    Offset textPosition = Offset(
        graphics.clientSize.width - textSize.width - 10, result.bounds.top);

//Draws the date by using drawString method
    graphics.drawString(currentDate, subHeadingFont,
        brush: element.brush,
        bounds: Offset(graphics.clientSize.width - textSize.width - 10,
            result.bounds.top) &
        Size(textSize.width + 2, 20));

//Creates text elements to add the address and draw it to the page
    element = PdfTextElement(
        text: 'BILL TO ',
        font: PdfStandardFont(PdfFontFamily.timesRoman, 10,
            style: PdfFontStyle.bold));
    element.brush = PdfSolidBrush(PdfColor(126, 155, 203));
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

    PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 10);

    element = PdfTextElement(text: this.cous_name.text, font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0));

    element = PdfTextElement(
        text: this.cous_no.text, font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0));

//Draws a line at the bottom of the address
    graphics.drawLine(
        PdfPen(PdfColor(126, 151, 173), width: 0.7),
        Offset(0, result.bounds.bottom + 3),
        Offset(graphics.clientSize.width, result.bounds.bottom + 3));


//Creates the datasource for the table
    // DataTable invoiceDetails = getProductDetailsAsDataTable();

//Creates a PDF grid
    PdfGrid grid = PdfGrid();

//Set padding for grid cells
    grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Adds the data source
    grid.dataSource = _getData01(users);

    PdfGridRow header = grid.headers[0];

//Creates the header style
    PdfGridCellStyle headerStyle = PdfGridCellStyle();
    headerStyle.borders.all = PdfPen(PdfColor(126, 151, 173));
    headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    headerStyle.textBrush = PdfBrushes.white;
    headerStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
        style: PdfFontStyle.regular);

//Adds cell customizations
    for (int i = 0; i < header.cells.count; i++) {
      if (i == 0 || i == 1) {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
      header.cells[i].style = headerStyle;
    }

//Creates the grid cell styles
    PdfGridCellStyle cellStyle = PdfGridCellStyle();
    cellStyle.borders.all = PdfPens.white;
    cellStyle.borders.bottom = PdfPen(PdfColor(217, 217, 217), width: 0.70);
    cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 12);
    cellStyle.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));
//Adds cell customizations
    for (int i = 0; i < grid.rows.count; i++) {
      PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        row.cells[j].style = cellStyle;
        if (j == 0 || j == 1) {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.left,
              lineAlignment: PdfVerticalAlignment.middle);
        } else {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.right,
              lineAlignment: PdfVerticalAlignment.middle);
        }
      }
    }

//Creates layout format settings to allow the table pagination
    PdfLayoutFormat layoutFormat =
    PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
    PdfLayoutResult gridResult = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
            graphics.clientSize.width, graphics.clientSize.height - 100),
        format: layoutFormat);

    gridResult.page.graphics.drawString(
        'Grand Total :                       \Rs. '+this.netP, subHeadingFont,
        brush: PdfSolidBrush(PdfColor(126, 155, 203)),
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 30, 0, 0));

    gridResult.page.graphics.drawString(
        'Thank you for your purchase !', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 60, 0, 0));

    //Save the document
    var bytes = document.save();
    // Dispose the document
    document.dispose();

    Directory directory = await getExternalStorageDirectory();
//Get directory path
    String path = directory.path;
//Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
//Write PDF data
    await file.writeAsBytes(bytes, flush: true);
//Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
  }
}