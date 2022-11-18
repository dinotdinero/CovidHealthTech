
 Row(
                  children: <Widget>[
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                          image:
                              _imageFile == null ? null : FileImage(_imageFile),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.camera,
                          size: 30.0,
                        ),
                        onPressed: () {
                          _selectAndPickImage();
                        },
                      ),
                    ),
                  ],
                ),


                InkWell(
      onTap: () {
        Route route = MaterialPageRoute(
            builder: (c) => ViewMonitoring(monitoringModel: model));
        Navigator.pushReplacement(context, route);

        Provider.of<MonitoringChanger>(context, listen: false)
            .displayResult(widget.value);
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.0),
                      width: screenWidth * 0.8,
                      child: Table(
                        children: [
                          TableRow(children: [
                            const Icon(
                              Icons.calendar_view_day,
                              size: 11,
                            ),
                            KeyText(
                              msg: "Day:",
                            ),
                            Text((widget.model.day).toString()),
                          ]),
                          TableRow(children: [
                            const Icon(
                              Icons.calendar_view_day,
                              size: 11,
                            ),
                            KeyText(
                              msg: "Date:",
                            ),
                            Text((widget.model.publishedDate)
                                .toDate()
                                .toString()),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await MonitoringModel.deleteItem(
                        monitoringId: widget.MonitoringId,
                      );
                    },
                  ),
                )
              ],
            ),
            Container(),
          ],
        ),
      ),

      Table(
                        children: [
                          TableRow(children: [
                            KeyText(
                              msg: "Day:",
                            ),
                            Text((widget.model.day).toString()),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "Temperature:",
                            ),
                            Text((widget.model.temperature).toString() + "°C"),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "HeartBeat:",
                            ),
                            Text((widget.model.heartbeat).toString() + " bpm"),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "Cough:",
                            ),
                            Text(widget.model.cough),
                          ]),
                          TableRow(children: [
                            const Icon(
                              Icons.person,
                              size: 11,
                            ),
                            KeyText(
                              msg: "Tiredness:",
                            ),
                            Text(widget.model.tired),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "Loss of smell or Taste:",
                            ),
                            Text(widget.model.smell),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "Sore Throat:",
                            ),
                            Text(widget.model.sore),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg:
                                  "Difficulty breathing or shortness of breath:",
                            ),
                            Text(widget.model.breath),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "loss of speech, mobility or confusion:",
                            ),
                            Text(widget.model.speech),
                          ]),
                          TableRow(children: [
                            const Icon(
                              Icons.person,
                              size: 11,
                            ),
                            KeyText(
                              msg: "Chest Pain:",
                            ),
                            Text(widget.model.chest + " bpm"),
                          ]),
                        ],
                      ),
    );