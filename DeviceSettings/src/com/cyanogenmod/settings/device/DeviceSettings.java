package com.cyanogenmod.settings.device;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.preference.*;
import android.os.Bundle;
import android.text.InputFilter;
import android.text.InputType;
import android.text.Spanned;
import android.util.Log;
import com.cyanogenmod.settings.device.tools.CMDProcessor;
import com.cyanogenmod.settings.device.tools.SystemProperties;
import android.widget.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DeviceSettings extends PreferenceActivity  {

    /**
     * Called when the activity is first created.
     */
    public static final String TAG = "MediapadSettings";

    public static final String KEY_LDC_COLOR = "lcd_color";
    public static final String KEY_WLAN_MAC = "wlan_mac";
    public static final String KEY_EXT_INT = "ext_internal";

    public static final String PROP_COLOR_ENHANCE = "persist.sys.color.enhance";
    public static final String PROP_WLAN_MAC = "persist.wlan.mac";
    public static final String PROP_EXT_INTERNAL = "persist.extinternal";

    private CheckBoxPreference mPrefColor;
    private Preference mPrefMac;
    private CheckBoxPreference mExtInternal;
    private Context context;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.device_settings);
        context = getBaseContext();
        initPreferenceActivity();
        CMDProcessor.rootCommand("pwd");
    }

    @Override
    public boolean onPreferenceTreeClick(PreferenceScreen preferenceScreen, Preference preference) {

        if(preference == mPrefColor)
            SystemProperties.set(context, PROP_COLOR_ENHANCE, (mPrefColor.isChecked() ? "true" : "false"));
        if(preference == mPrefMac)
            setCustomMacDialog();
        if(preference == mExtInternal)
            SystemProperties.set(context, PROP_EXT_INTERNAL, (mExtInternal.isChecked() ? "1" : "0"));


        return false;
    }

    private void initPreferenceActivity()
    {
        mPrefColor = (CheckBoxPreference) findPreference(KEY_LDC_COLOR);
        mPrefColor.setChecked(SystemProperties.get(context, PROP_COLOR_ENHANCE).equals("true"));
        mExtInternal = (CheckBoxPreference) findPreference(KEY_EXT_INT);
        mExtInternal.setChecked(SystemProperties.get(context, PROP_EXT_INTERNAL).equals("1"));

        mPrefMac = (Preference) findPreference(KEY_WLAN_MAC);

    }

    private void setCustomMacDialog()
    {
        final AlertDialog.Builder alert = new AlertDialog.Builder(this);
        final EditText input = new EditText(this);
        final SharedPreferences.Editor editor = context.getSharedPreferences(TAG, 0).edit();
        final SharedPreferences sharedPreferences = context.getSharedPreferences(TAG, 0);

        alert.setTitle(R.string.title_wlan_mac);
        alert.setView(input);


        input.setText(SystemProperties.get(context, PROP_WLAN_MAC));
        InputFilter filter= new InputFilter() {
            public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) {
                for (int i = start; i < end; i++) {
                    String checkMe = String.valueOf(source.charAt(i));

                    Pattern pattern = Pattern.compile("[ABCDEFabcdef0123456789]*");
                    Matcher matcher = pattern.matcher(checkMe);
                    boolean valid = matcher.matches();
                    if(!valid){
                        Log.d(TAG, "Mac char invalid");
                        return "";
                    }
                }
                return null;
            }
        };

        input.setFilters(new InputFilter[]{filter,new InputFilter.LengthFilter(12)});
        input.setInputType(InputType.TYPE_CLASS_TEXT);



        alert.setPositiveButton(getString(R.string.save), new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                SystemProperties.set(context,PROP_WLAN_MAC, input.getText().toString().trim() );
                editor.putString(PROP_WLAN_MAC,input.getText().toString().trim());
                editor.commit();
                dialog.cancel();
            }
        });

        alert.setNegativeButton(getString(R.string.cancel),
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int whichButton) {
                        dialog.cancel();
                    }
                });
        alert.show();
    }





}
