package com;

import java.io.File;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TempFileCleaner {
    private static final ScheduledExecutorService service = Executors.newScheduledThreadPool(1);

    public static void cleaneFiles(String folderPath, int maxTime)
    {
        service.scheduleAtFixedRate(() -> {
            File file = new File(folderPath);
            File[] files = file.listFiles();
            if(files != null)
            {
                long now = System.currentTimeMillis();
                for (File file1 : files)
                {
                    long lastModified = file1.lastModified();
                    if((now - lastModified) > (maxTime * 60 * 1000))
                    {
                        file1.delete();
                    }
                }
            }
        },0,1, TimeUnit.MINUTES);
    }
}
