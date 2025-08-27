package com.sacombank.cmv
// import com.microsoft.appcenter.AppCenter
// import com.microsoft.appcenter.distribute.Distribute
// import com.microsoft.appcenter.analytics.Analytics
// import com.microsoft.appcenter.crashes.Crashes
import android.app.Application

class SBAApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // AppCenter.start(
        //     this, 
        //     "d7936e74-8bff-450e-b53c-6d23c05687a5", 
        //     Distribute::class.java,
        //     Analytics::class.java, 
        //     Crashes::class.java
        // )
    }
}