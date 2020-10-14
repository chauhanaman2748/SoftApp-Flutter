import 'package:flutter/material.dart';
import 'package:soft_bill/list/user.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();
  var v1,v2;
  String v;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('Enter Product Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.user.fullName,
                  onSaved: (val) { widget.user.fullName = val;},
                  validator: (val) =>
                  val.length > 0 ? null : 'Enter Product Name',
                  decoration: InputDecoration(
                    labelText: 'Enter Name',
                    hintText: 'Enter Name',
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.user.price,
                  onSaved: (val) {
                    v1 = val;
                    widget.user.price = val;
                    },
                  validator: (val) =>
                  val.length > 0 ? null : 'Enter Product Price',
                  decoration: InputDecoration(
                    labelText: 'Enter Product Price',
                    hintText: 'Enter Product Price',
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16,bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.user.qty,
                  onSaved: (val) {
                    v2 = val;
                    v= ((int.parse(v1))*(int.parse(v2))).toString();
                    widget.user.qty = val;
                    widget.user.a = v;
                    },
                  validator: (val) =>
                  val.length > 0 ? null : 'Enter Product Quantity',
                  decoration: InputDecoration(
                    labelText: 'Enter Product Quantity',
                    hintText: 'Enter Product Quantity',
                    isDense: true,
                  ),
                ),
              ),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text("Quantity : "),
                  ),
                  Row(
                    children: <Widget>[
                      _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
                      new Text(_itemCount.toString()),
                      new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
                    ],
                  ),
                ],
              )*/
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}