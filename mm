program 1
package com.example.dk1;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CalendarView;
import android.widget.CompoundButton;
import android.widget.ImageButton;
import android.widget.Switch;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {
    ImageButton img;
    Switch sw;
    ConstraintLayout cl;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);
        img=findViewById(R.id.imageButton);
        //cl=findViewById(R.id.constraintLayout);
        sw=findViewById(R.id.switch1);
        img.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                sw.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
                    @Override
                    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                        if(isChecked){
                            img.setEnabled(true);
                            sw.setText("Enabled");
                        }else{
                            img.setEnabled(false);
                            sw.setText("Disabled");
                        }
                    }
                });
                CalendarView cv = new CalendarView(getApplicationContext());
                ConstraintLayout.LayoutParams lp = new ConstraintLayout.LayoutParams(
                        ConstraintLayout.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.MATCH_PARENT
                );
                cv.addView(cv,lp);
            }
        });




    }
}

custom
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item
        android:state_enabled="false"
        android:drawable="@drawable/disabled"/>
    <item
        android:state_pressed="true"
        android:drawable="@drawable/pressed"/>
    <item
        android:drawable="@drawable/bydefault"/>

</selector>

program 2
package com.example.dk2;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
public class MainActivity extends AppCompatActivity {
    ProgressBar pg;
    TextView tv;
    Button bt;
    int progressStatus = 0;
    Handler handler = new Handler();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        pg = findViewById(R.id.progressBar);
        tv = findViewById(R.id.textView);
        bt = findViewById(R.id.button);
        new Thread(new Runnable() {
            @Override
            public void run() {
                while(progressStatus < 100){
                    progressStatus += 1;
                    handler.post(new Runnable() {
                        @Override
                        public void run() {
                            pg.setProgress(progressStatus);
                            tv.setText(progressStatus + "%");
                        }
                    });
                    try{
                        Thread.sleep(800);
                    }catch(InterruptedException e){
                        e.printStackTrace();
                    }
                }
            }
        }).start();
        bt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
                builder.setTitle("Warning!");
                builder.setIcon(R.mipmap.ic_launcher);
                builder.setMessage("Are you sure buddy?");
                builder.setPositiveButton("yes", (dialog, which) -> {
                    finish();
                });
                builder.setNegativeButton("no", (dialog, which) -> {
                    dialog.cancel();
                });
                builder.setNeutralButton("cancel", (dialog, which) -> {
                    dialog.cancel();
                });
                builder.setCancelable(false);
                AlertDialog ad = builder.create();
                ad.show();
            }
        });
    }
}
Program 3
package com.example.dk3;

import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
public class MainActivity extends AppCompatActivity {
    EditText edt;
    Button btn;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        edt = findViewById(R.id.editTextText);
        btn = findViewById(R.id.button);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String str = edt.getText().toString();
                Intent i = new Intent(MainActivity.this, SecondActivity.class);
                i.putExtra("message", str);
                startActivity(i);
            }
        });
    }
}
SecondActivity
package com.example.dk3;

import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;
public class SecondActivity extends AppCompatActivity {
    TextView tv;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        tv = findViewById(R.id.textView);
        Intent i = getIntent();
        String str = i.getStringExtra("message");
        tv.setText("The String you sent is: " + str);
    }
}
program 4
package com.example.fragments;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentContainerView;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    Button button,button2;
    Fragment frag;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        button=findViewById(R.id.button);
        button2=findViewById(R.id.button2);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                frag=new FragmentOne();
                FragmentTransaction fragmentTransaction=getSupportFragmentManager().beginTransaction();
                fragmentTransaction.replace(R.id.container,frag).commit();
            }
        });
        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                frag=new FragmentTwo();
                FragmentTransaction fragmentTransaction=getSupportFragmentManager().beginTransaction();
                fragmentTransaction.replace(R.id.container,frag).commit();
            }
        });

    }
}
actmain
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity"
    android:id="@+id/container"
    >

    <TextView
        android:id="@+id/textView"
        android:layout_width="407dp"
        android:layout_height="632dp"
        android:background="#4CAF50"
        android:text="This is Main Activity's Fragment"
        android:textAlignment="center"
        android:textColor="#FFFFFF"
        android:textSize="34sp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintVertical_bias="0.0" />

    <Button
        android:id="@+id/button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="20dp"
        android:layout_marginEnd="216dp"
        android:layout_marginBottom="32dp"
        android:text="Go to Fragment One"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent" />

    <Button
        android:id="@+id/button2"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="22dp"
        android:layout_marginEnd="16dp"
        android:layout_marginBottom="32dp"
        android:text="Go to Fragment Two"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toEndOf="@+id/button" />


</androidx.constraintlayout.widget.ConstraintLayout>
fragment one
package com.example.fragments;



import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link FragmentOne#newInstance} factory method to
 * create an instance of this fragment.
 */
public class FragmentOne extends Fragment {
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_one, container, false);
    }
}
xml
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    tools:context=".FragmentOne">

    <!-- TODO: Update blank fragment layout -->
    <TextView
        android:layout_width="match_parent"
        android:layout_height="188dp"
        android:layout_gravity="center"
        android:background="#F60000"
        android:text="This is Fragment One which is overlayed on a Activity "
        android:textAlignment="center"
        android:textColor="#FFFFFF"
        android:textSize="34sp"/>


</FrameLayout>
fragment two
package com.example.fragments;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class FragmentTwo extends Fragment {

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_two, container, false);
    }
}
xml
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".FragmentTwo">

    <!-- TODO: Update blank fragment layout -->
    <TextView
        android:layout_width="match_parent"
        android:layout_height="188dp"
        android:layout_gravity="center"
        android:background="#873DA2"
        android:text="This is Fragment Two which is overlayed on a Activity "
        android:textAlignment="center"
        android:textColor="#FFFFFF"
        android:textSize="34sp"
        android:textColorHighlight="@color/cardview_dark_background"  />


</FrameLayout>
program6
program6
package com.example.dk6;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
public class MainActivity extends AppCompatActivity {
    EditText edt1, edt2;
    Button btn;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        edt1 = findViewById(R.id.editTextText);
        edt2 = findViewById(R.id.editTextText2);
        btn = findViewById(R.id.button);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try{
                    String phone = edt1.getText().toString();
                    String message = edt2.getText().toString();
                    SmsManager smgr = SmsManager.getDefault();
                    smgr.sendTextMessage(phone, null, message, null, null);
                    Toast.makeText(getApplicationContext(), "Message Sent",
                            Toast.LENGTH_LONG).show();
                }catch (Exception e){
                    Toast.makeText(getApplicationContext(), "Message Not Sent",
                            Toast.LENGTH_LONG).show();
                }
            }
        });
    }
}
Andriod manifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <uses-feature
        android:name="android.hardware.telephony"
        android:required="false"/>
    <uses-permission android:name="android.permission.SEND_SMS"/>

    <application
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.DK6"
        tools:targetApi="31">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>

program7
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="Manifest" href="./manifest.json">
</head>
<body>
    <h1>ServiceWorler</h1>
    <script src="./sw/sw.js"></script>
    <center>
        <p>username<input type="text", class="username", id="username"></p><br><br><br>
        <p>password<input type="password" class="passwrod", id="password"></p><br><br>
        <p><input type="submit" value="submit" onclick="verify()"></p>
    </center>
</body>
</html>
start.js
if('serviceWorker' in navigator){
    navigator.serviceWorker.register('/sw/sw.js')
    .then((reg)=>console.log("Registered", reg))
    .catch((err)=>console.log("err",err))
}else{
    console.log("ServiceWorker doesn't dupport in this browser")
}
sw.js
self.addEventListener('install', event=>{
    console.log("ServiceWorker Installing")
    self.skipWaiting()
})

self.addEventListener('activate', event=>{
    console.log("ServiceWorker Activating")
})

self.addEventListener('fetch',event=>{
    console.log("Fetching",event.request.url)
})
manifest.json
{
    "name":"ServiceWorker",
    "short_name":"sw",
    "start_url":"./index.html",
    "description":"My first ServiceWorker Program",
    "background_color":"#ffff00",
    "theme_color":"#ff2200",
    "display":"standalone",
    "orientation":"portrait",
    "icons":[
        {
            "src":"/icons/rvce_logo.png",
            "sizes":"316X316",
            "type":"image/png"
        },
        {
            "src":"/icons/rvce_logo.png",
            "sizes":"316X316",
            "type":"image/png"
        }
    ]
}
program 8
index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="Manifest" href="./Manifest.json">
</head>
<body>
    <center>
    <h1>ServiceWorker</h1>
    <script src="./sw/start.js"></script>
    <script src="./sw/log.js"></script>
        <p>username : <input type="text", name="username", id="username"></p><br><br><br>
        <p>password : <input type="password" name="passwrod", id="password"></p><br><br>
        <p><input type="submit" value="submit" onclick="verify()()"></p>
    </center>
</body>
</html>
Manifest.json
{
    "name":"ServiceWorker",
    "short_name":"sw",
    "start_url":"./index.html",
    "description":"My first ServiceWorker Program",
    "background_color":"#ffff00",
    "theme_color":"#ff2200",
    "display":"standalone",
    "orientation":"portrait",
    "icons":[
        {
            "src":"/icons/rvce_logo.png",
            "sizes":"316x316",
            "type":"image/png"
        },
        {
            "src":"/icons/rvce_logo.png",
            "sizes":"316x316",
            "type":"image/png"
        }
    ],
    "screenshots":[
        {
            "src":"/icons/rvce_logo.png",
            "sizes":"320x320",
            "type":"image/png",
            "purpose":"any",
            "form_factor":"wide"
        },
        {
            "src":"/icons/rvce_logo.png",
            "sizes":"320x320",
            "type":"image/png",
            "purpose":"any"
        }
    ],
    "protocol_handlers":[{
        "protocol":"web+jngl",
        "url":"/lookup?type=%s"
    },
{
    "protocol":"web+jnglstore",
    "url":"/shop?for=%s"

}]
}
log.js
localStorage.setItem("username","rvce")
localStorage.setItem("passme1","rvce")

function verify(){
    var username = document.getElementById('username').value
    var password = document.getElementById('password').value

    let un = localStorage.getItem("username")
    let pa = localStorage.getItem("passme1")
    alert(username+" "+password+" "+un+" "+pa);
    let stun = un.localeCompare(username)
    let stpas = pa.localeCompare(password)

    if(stun!=-1 && stpas!=-1){
        alert("authentication done")
    }else{
        alert("authentication failure")
    }
}
start.js
if('serviceWorker' in navigator){
    navigator.serviceWorker.register('/sw/sw.js')
    .then((reg)=>console.log("Registered", reg))
    .catch((err)=>console.log("err",err))
}else{
    console.log("ServiceWorker doesn't dupport in this browser")
}
sw.js
self.addEventListener('install', event=>{
    console.log("ServiceWorker Installing")
    self.skipWaiting()
})

self.addEventListener('activate', event=>{
    console.log("ServiceWorker Activating")
})

self.addEventListener('fetch',event=>{
    console.log("Fetching",event.request.url)
})
program 9'

<!DOCTYPE html>
<html>
<head>
</head>
<link rel="manifest" href="manifest.json">
<body>
<h1>Github Profile</h1>
<input type="text" id="text_input">
<input type="button" onclick="gitdata()" value="Get Profile">
<div id='git_image'>
<img src="" alt="profile image" id="image">
<p id='para'></p>
</div>
</body>
<script>
    
function gitdata(){
    var url = "https://api.github.com/users/" + document.getElementById("text_input").value;
    fetch(url)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log(data.avatar_url);
        var im = document.getElementById("image");
        im.setAttribute("src", data.avatar_url);
        var gi = document.getElementById("para");
        gi.innerHTML = JSON.stringify(data);
    })
    .catch(error => {
        console.error('There was a problem with the fetch operation:', error);
    });
}
</script>
</html>

Manifest.json
{
    "name": "Stock Display",
    "short_name": "Stock-Display",
    "display": "standalone",
    "start_url": "/",
    "id": "/",
    "description": "Display stock from json file",
    "icons": [
    {
    "src": "rvce.png",
    "type": "image/png",
    "sizes": "512x512",
    "purpose": "maskable"
    },
    {
    "src": "rvce.png",
    "type": "image/png",
    "sizes": "512x512",
    "purpose": "any"
    }
    ],
    "background_color": "#00AA00",
    "theme_color": "#00CC00"
    }
    sw.js
    self.addEventListener("install", (e) => { 
    console.log("installed");
  });
  
  self.addEventListener("activate", (e) => { 
    console.log("activated");
  });
  self.addEventListener("fetch", (e) => { 
    console.log("fetched");
    // Fetching user data from the GitHub API
    fetch("https://api.github.com/users/"+document.getElementById("text_input"))
      .then((response) => {
        return response.json();
      })
      .then((json) => {
        console.log(json);
      })
      .catch((error) => {
        console.log(error);
      });
  });
program9
index.html
<!DOCTYPE html>
<html>
<head>
</head>
<link rel="manifest" href="manifest.json">
<body>
<h1>Github Profile</h1>
<input type="text" id="text_input">
<input type="button" onclick="gitdata()" value="Get Profile">
<div id='git_image'>
<img src="" alt="profile image" id="image">
<p id='para'></p>
</div>
</body>
<script>
    
function gitdata(){
    var url = "https://api.github.com/users/" + document.getElementById("text_input").value;
    fetch(url)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log(data.avatar_url);
        var im = document.getElementById("image");
        im.setAttribute("src", data.avatar_url);
        var gi = document.getElementById("para");
        gi.innerHTML = JSON.stringify(data);
    })
    .catch(error => {
        console.error('There was a problem with the fetch operation:', error);
    });
}
</script>
</html>
sw.js
self.addEventListener("install", (e) => { 
    console.log("installed");
  });
  
  self.addEventListener("activate", (e) => { 
    console.log("activated");
  });
  self.addEventListener("fetch", (e) => { 
    console.log("fetched");
    // Fetching user data from the GitHub API
    fetch("https://api.github.com/users/"+document.getElementById("text_input"))
      .then((response) => {
        return response.json();
      })
      .then((json) => {
        console.log(json);
      })
      .catch((error) => {
        console.log(error);
      });
  });
Manifest.json
{
    "name": "Stock Display",
    "short_name": "Stock-Display",
    "display": "standalone",
    "start_url": "/",
    "id": "/",
    "description": "Display stock from json file",
    "icons": [
    {
    "src": "rvce.png",
    "type": "image/png",
    "sizes": "512x512",
    "purpose": "maskable"
    },
    {
    "src": "rvce.png",
    "type": "image/png",
    "sizes": "512x512",
    "purpose": "any"
    }
    ],
    "background_color": "#00AA00",
    "theme_color": "#00CC00"
    }
    program10
    [{
    "name":"abc",
    "company":"google",
    "age":"23"
},
{
    "name":"abc",
    "company":"google",
    "age":"23"
},{
    "name":"abc",
    "company":"google",
    "age":"23"
},{
    "name":"abc",
    "company":"google",
    "age":"23"
},{
    "name":"abc",
    "company":"google",
    "age":"23"
}]
index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="Manifest" href="Manifest.json">

    <style>
        table{
            border-collapse:collapse ;
        }
        td,th{
            border: 1px solid blue;
            padding: 1em;
        }
    </style>    
</head>
<body>
    <center>
        <h1>Stock Market</h1>
        <div id="stock"></div>
    </center>
    <script>
        if('ServiceWorker' in navigator){
            navigator.ServiceWorker.register("sw.js")
            .then((e)=>{
                if(e.active===null){
                    console.log("Registered")
                }
            });
        }else{
            console.log("ServiceWorker doesn't support in this browser")
        }

        fetch("data.json")
            .then((res)=>{
                return res.json();
            })

            .then((stock)=>{
                var table="<table><tr><th>name</th><th>company</th><th>age</th></tr>";

                    for(item of stock){
                        table+="<tr><td>"+item.name+"</td><td>"+item.company+"</td><td>"+item.age+"</td></tr>"
                    }
                    table+="</table>"
                    document.getElementById("stock").innerHTML=table
            })
        
    </script>
</body>
</html>
Manifest.json
{
    "name":"ServiceWorker",
    "short_name":"sw",
    "start_url":"./index.html",
    "description":"Stock Market Table",
    "display":"standalone",
    "background_color":"#ffff00",
    "orientation":"portrait",
    "theme_color":"#ff2211",
    "icons":[{
        "src":"./rvce.png",
        "sizes":"300x300",
        "type":"image/png",
        "purpose":"any"
    },
    {
        "src":"./rvce.png",
        "sizes":"500x500",
        "type":"image/png",
        "purpose":"any"
    }
],
"screenshots":[
    {
        "src":"./rvce.png",
        "sizes":"300x300",
        "type":"image/png",
        "purpose":"any"
    }
]
}
sw.js
self.addEventListener('install',event=>{
    console.log("ServiceWorker Installing")
    self.skipWaiting();
});

self.addEventListener('activate',event=>{
    console.log("Service Worker Activated");
});

self.addEventListener('fetch',event=>{
    console.log("fetching",event.request.url)
});
10 Program Ten
All files are as same as 7 and 8. New path for stock.html should exist in server.js
Additional Files
stock.html (A stock.json should also exist locally to access the json data)
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<center>
<h1>Real Time Fetch with Simple Balance Sheet Statement</h1>
<table id='tbl' border=1>
<tr>
<th style="width: 120px;"> date </th>
<th style="width: 120px;"> netReceivables </th>
<th style="width: 120px;"> cashAndCashEquivalents </th>
<th style="width: 120px;"> taxAssets </th>
<th style="width: 120px;"> otherCurrentLiabilities </th>
<th style="width: 120px;"> commonStock </th>
<th style="width: 120px;"> totalInvestments </th>
</tr>
</table>
</center>
</body>
<!-- https://financialmodelingprep.com/api/v3/balance-sheetstatement/AAPL?period=annual&apikey=RslEVBRQCqRMloHRNgFZKgkM1UhHPCKM" -->
<script>
 window.addEventListener('DOMContentLoaded',(event) => {
 let source = ["/stock.json"]
 let index = 0
 while(index < source.length){
 console.log("fetching from "+ source[index]);
 fetch(source[index])
 .then(response => response.json())
 .then(data => {
 console.log(data);
 let dat = JSON.stringify(data);
 dat1 = data;
 console.log(dat1);
 let bod = document.getElementById("body");
 // var tb = document.getElementById("tb1");
 var tb = document.getElementById("tbl");
 for(let i=0; i<dat1.length;i++)
 {
 var tr = document.createElement('tr');
 var td = document.createElement('td');
 td.innerHTML = dat1[i]["date"];
 tr.appendChild(td);
 tb.appendChild(tr);
 var td = document.createElement('td');
 td.innerHTML = dat1[i]["netReceivables"];
 tr.appendChild(td);
 tb.appendChild(tr);
 var td = document.createElement('td');
 td.innerHTML = dat1[i]["cashAndCashEquivalents"];
 tr.appendChild(td);
 tb.appendChild(tr);
 var td = document.createElement('td');
 td.innerHTML = dat1[i]["taxAssets"];
 tr.appendChild(td);
 tb.appendChild(tr);
 var td = document.createElement('td');
 td.innerHTML = dat1[i]["otherCurrentLiabilities"];
 tr.appendChild(td);
 tb.appendChild(tr);
 var td = document.createElement('td');
 td.innerHTML = dat1[i]["commonStock"];
 tr.appendChild(td);
 tb.appendChild(tr);
 var td = document.createElement('td');
 td.innerHTML = dat1[i]["totalInvestments"];
 tr.appendChild(td);
 tb.appendChild(tr);
 }
 })
 .catch(err => console.log('err', err));
 index+=1;
 }
 });
</script>
</html>
sw.js
(function(){
 self.addEventListener('install',event =>{
 console.log('service worker installing');
 self.skipWaiting();
 })
 self.addEventListener('activate',event=>{
 console.log('service worker activating...')
 })
 self.addEventListener('fetch',event=>{
 console.log('fetching',event.request.url);
 })
})
program6
package com.example.dk6;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
public class MainActivity extends AppCompatActivity {
    EditText edt1, edt2;
    Button btn;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        edt1 = findViewById(R.id.editTextText);
        edt2 = findViewById(R.id.editTextText2);
        btn = findViewById(R.id.button);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try{
                    String phone = edt1.getText().toString();
                    String message = edt2.getText().toString();
                    SmsManager smgr = SmsManager.getDefault();
                    smgr.sendTextMessage(phone, null, message, null, null);
                    Toast.makeText(getApplicationContext(), "Message Sent",
                            Toast.LENGTH_LONG).show();
                }catch (Exception e){
                    Toast.makeText(getApplicationContext(), "Message Not Sent",
                            Toast.LENGTH_LONG).show();
                }
            }
        });
    }
}
Andriod manifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <uses-feature
        android:name="android.hardware.telephony"
        android:required="false"/>
    <uses-permission android:name="android.permission.SEND_SMS"/>

    <application
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.DK6"
        tools:targetApi="31">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
