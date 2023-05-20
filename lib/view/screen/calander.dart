import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/calander_controller.dart';
import 'package:pfe_flutter/core/class/handlingdataview.dart';
import 'package:pfe_flutter/core/constant/color.dart';
import 'package:pfe_flutter/core/functions/alertexitapp.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalanderPage extends StatelessWidget {
  const CalanderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CalanderController());
    return GetBuilder<CalanderController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: alertExitApp,
          child: HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Scaffold(
              appBar: AppBar(

                centerTitle: true,
                backgroundColor: AppColor.primaryColor,
                elevation: 0.0,
                title: Text('My Calendar',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColor.secoundColor)),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SfCalendar(
                        view: CalendarView.month,
                        dataSource: controller.dataSource,
                        onSelectionChanged: controller.selectionChanged,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black12,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(2),
                          itemCount: controller.selectedAppointments.length,
                          itemBuilder: (context, index) {
                            final appointment = controller.selectedAppointments[index];
                            return Container(
                              padding: const EdgeInsets.all(2),
                              height: 60,
                              color: appointment.color,
                              child: ListTile(
                                onTap: () => controller.goToInspectionDetailsPage(index),
                                leading: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd').format(appointment.startTime),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (appointment.notes != null)
                                      Text(
                                        appointment.notes!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                ),
                                title: Text(
                                  appointment.subject,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: Icon(
                                  controller.getIcon(appointment.color == Colors.green),
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(height: 5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

