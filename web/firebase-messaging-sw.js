// web/firebase-messaging-sw.js
console.log("Service Worker Loaded");

importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js');

firebase.initializeApp({
    apiKey: "AIzaSyAWDbGCMs34-0TnbrVdjIMLUiHah_aNLTo",
    authDomain: "new-pharmacy-stilo.firebaseapp.com",
    projectId: "new-pharmacy-stilo",
    storageBucket: "new-pharmacy-stilo.appspot.com",
    messagingSenderId: "1077717598939",
    appId: "1:1077717598939:web:b5eaf839621c27588502fe",
    measurementId: "G-HL22JKZPES"
});

const messaging = firebase.messaging();
console.log("Firebase Messaging initialized in Service Worker");

messaging.setBackgroundMessageHandler(function (payload) {
  console.log('Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/logo.png'  // Update to your own icon if necessary
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});

self.addEventListener('notificationclick', function (event) {
  console.log('Notification click: ', event.notification);
  event.notification.close();
});