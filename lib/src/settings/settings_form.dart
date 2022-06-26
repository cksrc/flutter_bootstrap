import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../common/singletons/utils.dart';

/// The widget below demonstrates how to create scrollable forms the right way.
/// Using ListView.builder is not recommended for input form fields.
/// Also note the use of `physics: const AlwaysScrollableScrollPhysics()` in the
/// `SingleChildScrollView` to allow using the `RefreshIndicator`.
class SettingsForm extends StatefulWidget {
  final Map<String, RemoteConfigValue> settings;
  final Future<void> Function() pullRefresh;
  const SettingsForm(this.settings, this.pullRefresh, {Key? key})
      : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return RefreshIndicator(
        onRefresh: widget.pullRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: _getFormWidgetListFromSettings(widget.settings),
              ),
            ),
          ),
        ),
      );
    });

    // Uncomment to use with ListBuilder instead
    // return RefreshIndicator(
    //   onRefresh: widget.pullRefresh,
    //   child: ListView.builder(
    //     itemCount: widget.settings.length,
    //     itemBuilder: (context, index) {
    //       var kv = widget.settings.entries.elementAt(index);
    //       return _getFormWidgetFromSettings(kv.key, kv.value);
    //     },
    //   ),
    // );
  }

  List<Widget> _getFormWidgetListFromSettings(
      Map<String, RemoteConfigValue> settings) {
    List<Widget> formFields = [];
    settings.forEach((key, value) {
      formFields.add(
        FormBuilderTextField(
          name: key,
          decoration: InputDecoration(
            labelText: Utils.instance.settingsKeyToLabel(key),
          ),
          onChanged: (value) {},
          validator: FormBuilderValidators.required(),
          initialValue: value.asString(),
        ),
      );
    });
    return formFields;
  }

  // Uncomment to use with ListBuilder instead
  //   Widget _getFormWidgetFromSettings(String key, RemoteConfigValue value) {
  //   return FormBuilderTextField(
  //     name: key,
  //     decoration: InputDecoration(
  //       labelText: Utils.instance.settingsKeyToLabel(key),
  //     ),
  //     onChanged: (value) {},
  //     validator: FormBuilderValidators.required(),
  //     initialValue: value.asString(),
  //   );
  // }
}
