package com.example.whatsappautomsg;
import android.accessibilityservice.AccessibilityService;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import androidx.core.view.accessibility.AccessibilityNodeInfoCompat;

import java.util.List;

public class WhatsappAccessibilityService extends AccessibilityService {


    @Override
    public void onAccessibilityEvent (AccessibilityEvent event) {

        if (getRootInActiveWindow () == null) {
            return;
        }

        try {

            AccessibilityNodeInfoCompat rootInActiveWindow = AccessibilityNodeInfoCompat.wrap (getRootInActiveWindow ());

            // TinyDB tinyDB = new TinyDB(this);
            // String watermark = tinyDB.getString(KEY_WATERMARK);
            // boolean isWA = tinyDB.getBoolean(KEY_IS_WA);
            String pkg  = event.getPackageName().toString();

            // Whatsapp Message EditText id
            List<AccessibilityNodeInfoCompat> messageNodeList = rootInActiveWindow.findAccessibilityNodeInfosByViewId (pkg+":id/entry");
            if (messageNodeList == null || messageNodeList.isEmpty ()) {
                return;
            }

            // check if the whatsapp message EditText field is filled with text and ending with your suffix (explanation above)
            AccessibilityNodeInfoCompat messageField = messageNodeList.get (0);
            if (messageField.getText () == null || messageField.getText ().length () == 0
                    || !messageField.getText ().toString ().endsWith ("")) { // So your service doesn't process any message, but the ones ending your apps suffix
                return;
            }

            // Whatsapp send button id
            List<AccessibilityNodeInfoCompat> sendMessageNodeInfoList = rootInActiveWindow.findAccessibilityNodeInfosByViewId (pkg+":id/send");
            if (sendMessageNodeInfoList == null || sendMessageNodeInfoList.isEmpty ()) {
                return;
            }

            AccessibilityNodeInfoCompat sendMessageButton = sendMessageNodeInfoList.get (0);
            if (!sendMessageButton.isVisibleToUser ()) {
                return;
            }

            // Now fire a click on the send button
            sendMessageButton.performAction (AccessibilityNodeInfo.ACTION_CLICK);

            // Now go back to your app by clicking on the Android back button twice:
            // First one to leave the conversation screen
            // Second one to leave whatsapp
            try {
                Thread.sleep (500); // hack for certain devices in which the immediate back click is too fast to handle
                performGlobalAction (GLOBAL_ACTION_BACK);
                Thread.sleep (500);  // same hack as above
            } catch (InterruptedException ignored) {}
            performGlobalAction (GLOBAL_ACTION_BACK);
        }
        catch (Exception d) {}
    }

    @Override
    public void onInterrupt() {
        // ToastUtils.showShort("Message not Sent");
    }
}