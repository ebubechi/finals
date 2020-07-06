// import 'package:fuelapp/ui/shared/shared_styles.dart';
import 'package:flutter/material.dart';

class BusyButton extends StatefulWidget {
  final bool busy;
  final Function onPressed;
  final bool enabled;

  const BusyButton({
    this.busy = false,
    @required this.onPressed,
    this.enabled = true
  });

@override 
_BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: widget.onPressed,
      child: InkWell(         
        child: AnimatedContainer( 
          height: widget.busy ? 40 : null,
          width: widget.busy ? 40 : null,
          duration: const Duration(  
            milliseconds: 300),
          // alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: widget.busy ? 10 : 15,
            vertical:  widget.busy ? 10 : 10,),
          decoration: BoxDecoration(
            color: widget.enabled ? Color(0xFF1565C0) : Color(0xFF1565C0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: !widget.busy 
              ? Icon(
                  Icons.arrow_forward,
                  color: Color(0xFFFFFFFF),                
              )
              : CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
              ),
        ),
      ),
    );
  }
}