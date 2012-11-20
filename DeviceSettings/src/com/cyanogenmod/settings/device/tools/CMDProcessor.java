package com.cyanogenmod.settings.device.tools;

import android.util.Log;
import java.io.*;

public class CMDProcessor {

    public static void rootCommand(String cmd)
    {
        File wd = new File("/");
        System.out.println(wd);
        Process proc = null;
        try {
            proc = Runtime.getRuntime().exec("su", null, wd);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (proc != null) {
            PrintWriter out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(proc.getOutputStream())), true);
            out.println(cmd);
            out.println("exit");
            try {
                proc.waitFor();
                out.close();
                proc.destroy();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static String rootCommandOut(String cmd)
    {
        String line = null;
        File wd = new File("/");

        Process proc = null;
        try {
            proc = Runtime.getRuntime().exec("su", null, wd);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (proc != null) {
            BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));
            PrintWriter out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(proc.getOutputStream())), true);
            out.println(cmd);
            out.println("exit");
            try {

                while ((line = in.readLine()) != null) {}
                proc.waitFor();
                in.close();
                out.close();
                proc.destroy();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return line;
    }
}
