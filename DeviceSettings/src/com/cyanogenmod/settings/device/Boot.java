package com.cyanogenmod.settings.device;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

/**
 * Created with IntelliJ IDEA.
 * User: zyr3x
 * Date: 22.10.12
 * Time: 17:56
 * To change this template use File | Settings | File Templates.
 */
public class Boot extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        Intent service = new Intent(context, BootService.class);
        context.startService(service);
    }
}