 
 
//  List<AccessibilityNodeInfoCompat> messageNodeList = rootInActiveWindow.findAccessibilityNodeInfosByViewId (pkg+":id/entry");
//             if (messageNodeList == null || messageNodeList.isEmpty ()) {
//                 return;
//             }

//             // check if the whatsapp message EditText field is filled with text and ending with your suffix (explanation above)
//             AccessibilityNodeInfoCompat messageField = messageNodeList.get (0);
//             if (messageField.getText Function()  == null || messageField.getText ().length () == 0
//                     || !messageField.getText ().toString ().endsWith (watermark)) { // So your service doesn't process any message, but the ones ending your apps suffix
//                 return;
//             }

//             // Whatsapp send button id
//             List<AccessibilityNodeInfoCompat> sendMessageNodeInfoList = rootInActiveWindow.findAccessibilityNodeInfosByViewId (pkg+":id/send");
//             if (sendMessageNodeInfoList == null || sendMessageNodeInfoList.isEmpty ()) {
//                 return;
//             }

//             AccessibilityNodeInfoCompat sendMessageButton = sendMessageNodeInfoList.get (0);
//             if (!sendMessageButton.isVisibleToUser ()) {
//                 return;
//             }

//             // Now fire a click on the send button
//             sendMessageButton.performAction (AccessibilityNodeInfo.ACTION_CLICK);
