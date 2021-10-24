import '../appointment_details/appointment_details_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentsPetWidget extends StatefulWidget {
  AppointmentsPetWidget({
    Key key,
    this.userProfile,
  }) : super(key: key);

  final DocumentReference userProfile;

  @override
  _AppointmentsPetWidgetState createState() => _AppointmentsPetWidgetState();
}

class _AppointmentsPetWidgetState extends State<AppointmentsPetWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.userProfile),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: SpinKitPumpingHeart(
                color: FlutterFlowTheme.primaryColor,
                size: 40,
              ),
            ),
          );
        }
        final appointmentsPetUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xFF1A1F24),
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left_rounded,
                color: FlutterFlowTheme.grayLight,
                size: 32,
              ),
            ),
            title: Text(
              'Appointments',
              style: FlutterFlowTheme.title3.override(
                fontFamily: 'Lexend Deca',
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: FlutterFlowTheme.background,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 1,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: FlutterFlowTheme.tertiaryColor,
                        unselectedLabelColor: FlutterFlowTheme.grayLight,
                        labelStyle: GoogleFonts.getFont(
                          'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                        indicatorColor: FlutterFlowTheme.tertiaryColor,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            text: 'Past',
                          ),
                          Tab(
                            text: 'Upcoming',
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: StreamBuilder<List<AppointmentsRecord>>(
                                stream: queryAppointmentsRecord(
                                  queryBuilder: (appointmentsRecord) =>
                                      appointmentsRecord
                                          .where('appointmentPerson',
                                              isEqualTo: currentUserReference)
                                          .where('appointmentTime',
                                              isLessThan: getCurrentTimestamp),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: SpinKitPumpingHeart(
                                          color: FlutterFlowTheme.primaryColor,
                                          size: 40,
                                        ),
                                      ),
                                    );
                                  }
                                  List<AppointmentsRecord>
                                      listViewAppointmentsRecordList =
                                      snapshot.data;
                                  if (listViewAppointmentsRecordList.isEmpty) {
                                    return Center(
                                      child: Image.asset(
                                        'assets/images/noAppointments.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewAppointmentsRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewAppointmentsRecord =
                                          listViewAppointmentsRecordList[
                                              listViewIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 12),
                                        child:
                                            StreamBuilder<AppointmentsRecord>(
                                          stream:
                                              AppointmentsRecord.getDocument(
                                                  listViewAppointmentsRecord
                                                      .reference),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: SpinKitPumpingHeart(
                                                    color: FlutterFlowTheme
                                                        .primaryColor,
                                                    size: 40,
                                                  ),
                                                ),
                                              );
                                            }
                                            final appointmentCardAppointmentsRecord =
                                                snapshot.data;
                                            return InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AppointmentDetailsWidget(
                                                      appointmentDetails:
                                                          appointmentCardAppointmentsRecord
                                                              .reference,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .darkBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 12, 12, 12),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  listViewAppointmentsRecord
                                                                      .appointmentType,
                                                                  style: FlutterFlowTheme
                                                                      .title3
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .chevron_right_rounded,
                                                              color:
                                                                  FlutterFlowTheme
                                                                      .grayLight,
                                                              size: 24,
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      8, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Card(
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
                                                                color: FlutterFlowTheme
                                                                    .background,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8,
                                                                          4,
                                                                          8,
                                                                          4),
                                                                  child: Text(
                                                                    dateTimeFormat(
                                                                        'MMMMEEEEd',
                                                                        listViewAppointmentsRecord
                                                                            .appointmentTime),
                                                                    style: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: FlutterFlowTheme
                                                                          .textColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  'For',
                                                                  style: FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    appointmentCardAppointmentsRecord
                                                                        .appointmentPetName,
                                                                    style: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: FlutterFlowTheme
                                                                          .secondaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: StreamBuilder<List<AppointmentsRecord>>(
                                stream: queryAppointmentsRecord(
                                  queryBuilder: (appointmentsRecord) =>
                                      appointmentsRecord
                                          .where('appointmentPerson',
                                              isEqualTo: currentUserReference)
                                          .where('appointmentTime',
                                              isGreaterThanOrEqualTo:
                                                  getCurrentTimestamp),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: SpinKitPumpingHeart(
                                          color: FlutterFlowTheme.primaryColor,
                                          size: 40,
                                        ),
                                      ),
                                    );
                                  }
                                  List<AppointmentsRecord>
                                      listViewAppointmentsRecordList =
                                      snapshot.data;
                                  if (listViewAppointmentsRecordList.isEmpty) {
                                    return Center(
                                      child: Image.asset(
                                        'assets/images/noAppointments.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewAppointmentsRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewAppointmentsRecord =
                                          listViewAppointmentsRecordList[
                                              listViewIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 12),
                                        child:
                                            StreamBuilder<AppointmentsRecord>(
                                          stream:
                                              AppointmentsRecord.getDocument(
                                                  listViewAppointmentsRecord
                                                      .reference),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: SpinKitPumpingHeart(
                                                    color: FlutterFlowTheme
                                                        .primaryColor,
                                                    size: 40,
                                                  ),
                                                ),
                                              );
                                            }
                                            final appointmentCardAppointmentsRecord =
                                                snapshot.data;
                                            return InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AppointmentDetailsWidget(
                                                      appointmentDetails:
                                                          appointmentCardAppointmentsRecord
                                                              .reference,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .darkBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 12, 12, 12),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  listViewAppointmentsRecord
                                                                      .appointmentType,
                                                                  style: FlutterFlowTheme
                                                                      .title3
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .chevron_right_rounded,
                                                              color:
                                                                  FlutterFlowTheme
                                                                      .grayLight,
                                                              size: 24,
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      8, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Card(
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
                                                                color: FlutterFlowTheme
                                                                    .background,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8,
                                                                          4,
                                                                          8,
                                                                          4),
                                                                  child: Text(
                                                                    dateTimeFormat(
                                                                        'MMMMEEEEd',
                                                                        listViewAppointmentsRecord
                                                                            .appointmentTime),
                                                                    style: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: FlutterFlowTheme
                                                                          .textColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  'For',
                                                                  style: FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    appointmentCardAppointmentsRecord
                                                                        .appointmentPetName,
                                                                    style: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: FlutterFlowTheme
                                                                          .secondaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
