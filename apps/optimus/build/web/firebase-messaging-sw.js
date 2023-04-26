importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
   apiKey: "AIzaSyB56ivACc9ORYxX5bRpjrh4fNxb_4Qts2o",
   authDomain: "merchant-app-74cb3.firebaseapp.com",
   databaseURL: "https://merchant-app-74cb3.firebaseio.com",
   projectId: "merchant-app-74cb3",
   storageBucket: "merchant-app-74cb3.appspot.com",
   messagingSenderId: "526964442224",
   appId: "1:526964442224:web:e251c16a79518d314ca0b5",
   measurementId: "G-PTFXH6C37G"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});