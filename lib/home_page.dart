import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dialog.dart';
import 'package:tic_tac_toe/game_button.dart';
import 'package:countdown/countdown.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  var Player1;
  var Player2;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();

  }

  List<GameButton>doInit(){
    Player1 = new List();
    Player2 = new List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb){
    setState(() {
      if (activePlayer ==1){
        gb.text = "X";
        gb.bg = Colors.deepOrange;
        activePlayer = 2;
        Player1.add(gb.id);
      }
      else{
        gb.text = "O";
        gb.bg = Colors.black54;
        activePlayer = 1;
        Player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1 ){
        if(buttonsList.every((p)=>p.text != "")){
          CountDown cd = CountDown(Duration(seconds : 1));
          var sub = cd.stream.listen(null);

          // when it finish the onDone cb is called
          sub.onDone(() {
            showDialog(
                context: context,
                builder: (_)=>new CustomDialog("Game tied",
                    "Press Reset to start a new game.", resetGame)); // not sure enough. documentation e dekhlam janina hbe ki na

          });
        }
        else{
          activePlayer ==2 ? autoPlay() : null;
        }
      }
    });
  }


  void autoPlay(){
    var emptyCells = new List();
    var cellID;

    var list = new List.generate(9, (i)=>i+1);
    for (cellID in list){
      if (!(Player1.contains(cellID) || Player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }
    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    cellID = emptyCells[randIndex];
    var i = buttonsList.indexWhere((p)=>p.id == cellID);
    playGame(buttonsList[i]);

  }

  int checkWinner() {
    int winner = -1;
    //row 1
    if (Player1.contains(1) && Player1.contains(2) && Player1.contains(3))
      winner = 1;
    if (Player2.contains(1) && Player2.contains(2) && Player2.contains(3))
      winner = 2;
    //row 2
    if (Player1.contains(4) && Player1.contains(5) && Player1.contains(6))
      winner = 1;
    if (Player2.contains(4) && Player2.contains(5) && Player2.contains(6))
      winner = 2;
    //row 3
    if (Player1.contains(7) && Player1.contains(8) && Player1.contains(9))
      winner = 1;
    if (Player2.contains(7) && Player2.contains(8) && Player2.contains(9))
      winner = 2;
    // col 1
    if (Player1.contains(1) && Player1.contains(4) && Player1.contains(7))
      winner = 1;
    if (Player2.contains(1) && Player2.contains(4) && Player2.contains(7))
      winner = 2;
    //col 2
    if (Player1.contains(2) && Player1.contains(5) && Player1.contains(8))
      winner = 1;
    if (Player2.contains(2) && Player1.contains(5) && Player2.contains(8))
      winner = 2;
    //col 3
    if (Player1.contains(3) && Player1.contains(6) && Player1.contains(9))
      winner = 1;
    if (Player2.contains(3) && Player2.contains(6) && Player2.contains(9))
      winner = 2;
    //diagonal 1
    if (Player1.contains(1) && Player1.contains(5) && Player1.contains(9))
      winner = 1;
    if (Player2.contains(1) && Player2.contains(5) && Player2.contains(9))
      winner = 2;
    //diagonal 2
    if (Player1.contains(3) && Player1.contains(5) && Player1.contains(7))
      winner = 1;
    if (Player2.contains(3) && Player2.contains(5) && Player2.contains(7))
      winner = 2;

    if (winner != -1) {
      if (winner == 1) {

        CountDown cd = CountDown(Duration(seconds : 1));
        var sub = cd.stream.listen(null);
        sub.onDone(() {
          showDialog(
              context: context,
              builder: (_)=>new CustomDialog("Player1 won.",
                  "Press Reset to start a new game.", resetGame));

        });
      }
      else {
        CountDown cd = CountDown(Duration(seconds : 1));
        var sub = cd.stream.listen(null);
        sub.onDone(() {
          showDialog(
              context: context,
              builder: (_)=>new CustomDialog("Player2 won.",
                  "Press Reset to start a new game.", resetGame));

        });
      }
    }
    return winner;
  }

  void resetGame(){
    if(Navigator.canPop(context))
      Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey,
      appBar: new AppBar(
        title: new Center(
        child: new Text("Tic Tac Toe",style: TextStyle(fontSize: 24.0),))
      ),
      body: new Stack(
          fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: AssetImage("asset/flower.jpg"),
            fit: BoxFit.cover,
            color: Colors.grey,
            colorBlendMode: BlendMode.colorBurn,
          ),
          new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: new GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0
                ),
                padding: EdgeInsets.only(left:10.0, right: 10.0, top:50.0),
                itemCount: buttonsList.length,
                itemBuilder: (context,i)=>new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                      onPressed: buttonsList[i].enabled
                          ?()=> playGame(buttonsList[i])
                          :null,
                    child: new Text(
                        buttonsList[i].text,
                      style: new TextStyle(color: Colors.white, fontSize: 50.0),
                    ),
                    color: buttonsList[i].bg,
                    disabledColor: buttonsList[i].bg,
                  ),
                )
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 100.0, right: 100.0, bottom: 50.0, top: 50.0),
              child: new RaisedButton(
                child: Row( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.refresh,color: Colors.white),
                  new Center(
                      child: Text("    Reset",textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 25.0)))
              ]),
                color: Colors.red,
                splashColor: Colors.black54,
                onPressed: resetGame,
              ),
            )
          ],
        ),
      ]),
    );
  }
}






