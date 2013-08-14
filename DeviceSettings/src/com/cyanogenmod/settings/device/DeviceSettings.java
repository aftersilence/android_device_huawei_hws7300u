package com.cyanogenmod.settings.device;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.preference.*;
import android.os.Bundle;
import android.text.InputFilter;
import android.text.InputType;
import android.text.Spanned;
import android.util.Log;
import com.cyanogenmod.settings.device.CMDProcessor.CommandResult;
import android.os.SystemProperties;
import android.os.IBinder;
import android.os.ServiceManager;
import android.os.Parcel;
import android.os.RemoteException;
import android.widget.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DeviceSettings extends PreferenceActivity implements OnSharedPreferenceChangeListener  {

    /**
     * Called when the activity is first created.
     */
    public static final String TAG = "MediapadSettings";

    public static final String KEY_LDC_COLOR = "lcd_color";
    public static final String KEY_DPI = "pref_dpi_list";
    public static final String KEY_WLAN_MAC = "wlan_mac";
    public static final String KEY_EXT_INT = "ext_internal";

    public static final String PROP_COLOR_ENHANCE = "persist.sys.color.enhance";
    public static final String PROP_WLAN_MAC = "persist.wlan.mac";
    public static final String PROP_EXT_INTERNAL = "persist.extinternal";
    public static final String PROP_HW_OVERLAY = "persist.hw.overlay";

    private CheckBoxPreference mPrefColor;
    private Preference mPrefMac;
    private CheckBoxPreference  mExtInternal;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.device_settings);
        getPreferenceScreen().getSharedPreferences().registerOnSharedPreferenceChangeListener(this);
        new CMDProcessor().su.runWaitFor("pwd");
        initPreferenceActivity();
        

    }

    @Override
    public boolean onPreferenceTreeClick(PreferenceScreen preferenceScreen, Preference preference) 
    {

        if(preference == mPrefColor)
            setProp(PROP_COLOR_ENHANCE, (mPrefColor.isChecked() ? "true" : "false"));
            
        if(preference == mPrefMac)
            setCustomMacDialog();

        if(preference == mExtInternal)
		{
			setProp(PROP_EXT_INTERNAL, (mExtInternal.isChecked() ? "1" : "0"));
			new CMDProcessor().su.run("echo "+(mExtInternal.isChecked() ? "1" : "0")+" > /data/system/extinternal");
		}

        return false;
    }


    @Override 
    public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String key) {
		
		if(key.equals(KEY_DPI))
		{
			int dpi = Integer.valueOf(sharedPreferences.getString(KEY_DPI, "213"));
			setLcdDensity(dpi);	
		}
	
    }

	
    private void initPreferenceActivity()
    {
	 mPrefMac = (Preference) findPreference(KEY_WLAN_MAC);
		
        mPrefColor = (CheckBoxPreference) findPreference(KEY_LDC_COLOR);
        mPrefColor.setChecked(getProp(PROP_COLOR_ENHANCE,"false").equals("true"));

        mExtInternal = (CheckBoxPreference) findPreference(KEY_EXT_INT);
        mExtInternal.setChecked(getProp(PROP_EXT_INTERNAL,"0").equals("1"));
    }
	
    private void setProp(String key,String val)
    {
        new CMDProcessor().su.runWaitFor("setprop "+key+" \""+val+"\"");
    }
	
    private String getProp(String key,String def)
    {
        CommandResult result = new CMDProcessor().su.runWaitFor("getprop "+key);
        return (result.getOutput().getFirst().equals("") || result.getOutput().getFirst() == null) ? def : result.getOutput().getFirst() ;
    }	
  
    private void setLcdDensity(int newDensity)
    {
        Helpers.getMount("rw");
        new CMDProcessor().su.runWaitFor("busybox sed -i 's|ro.sf.lcd_density=.*|"
                + "ro.sf.lcd_density" + "=" + newDensity + "|' " + "/system/build.prop");
        Helpers.getMount("ro");
    }
    
    private void setCustomMacDialog()
    {
        final AlertDialog.Builder alert = new AlertDialog.Builder(this);
        final EditText input = new EditText(this);

        alert.setTitle(R.string.title_wlan_mac);
        alert.setView(input);

        input.setText(getProp(PROP_WLAN_MAC,""));
        
        InputFilter filter= new InputFilter() 
        {
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
                setProp(PROP_WLAN_MAC, input.getText().toString().trim() );
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
