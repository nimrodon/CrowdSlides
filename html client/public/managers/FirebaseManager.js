// FirebaseManager.js
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.16.0/firebase-app.js";
import { getDatabase, ref, onValue, get, off, runTransaction, set } from "https://www.gstatic.com/firebasejs/9.16.0/firebase-database.js";

const firebaseConfig = {
  apiKey: "AIzaSyCe2S-dIDxepkWkX9IWjjQfg80hXdB4lZQ",
  authDomain: "crowdslides-demo.firebaseapp.com",
  databaseURL: "https://crowdslides-demo-default-rtdb.firebaseio.com",
  projectId: "crowdslides-demo",
  storageBucket: "crowdslides-demo.firebasestorage.app",
  messagingSenderId: "369867568483",
  appId: "1:369867568483:web:a89d83245cd61697d18f56"
};

let db;
let isVotingRef; // required for stop listening
let isVotingCallback; // required for stop listening


export function initDB() {
  const app = initializeApp(firebaseConfig);
  db = getDatabase(app);
}


export async function loadConfig() {
    console.log("load config");
    const configRef = ref(db, 'sharedData/clientConfig');
    try {
        const snapshot = await get(configRef);
        if (snapshot.exists()) {
            const config = snapshot.val();
            console.log("Client config loaded:", config);
            return config;
        } else {
            console.warn("No client config found in Firebase.");
            return {};
        }
    } catch (error) {
        console.error("Error loading client config:", error);
        throw error;
    }
}


export async function loadSelectionConfig() {
    console.log("load selection config");
    const selectionConfigRef = ref(db, 'sharedData/state/currentSelection/clientConfig');
    try {
        const snapshot = await get(selectionConfigRef);
        if (snapshot.exists()) {
            const selectionConfig = snapshot.val();
            console.log("Selection config loaded:", selectionConfig);
            return selectionConfig;
        } else {
            console.warn("No selection config found in Firebase.");
            return {};
        }
    } catch (error) {
        console.error("Error loading selection config:", error);
        throw error;
    }
}


export async function addUserIfNotExists(userId) {
   const userRef = ref(db, `sharedData/users/${userId}`);
   const userSnapshot = await get(userRef);

   if (!userSnapshot.exists()) {
       await set(userRef, { didVote: false });
       console.log(`User ${userId} added to the database.`);
   } else {
       console.log(`User ${userId} already exists in the database.`);
   }
}


export function incrementVote(index) {
   const selectedOptionRef = ref(db, `sharedData/state/currentSelection/votes/${index}`);
   runTransaction(selectedOptionRef, (currentValue) => {
       return (currentValue || 0) + 1;
   }).catch((error) => {
       console.error("Error incrementing new option count:", error);
   });
}


// listeners

export function listenToSlideType(callback) {
    console.log("Listening to slide type...");
    const slideTypeRef = ref(db, "sharedData/state/currentSlideType");
    onValue(slideTypeRef, async (snapshot) => {
        const slideType = snapshot.val();
        callback(slideType)
        console.log("Slide type received:", slideType);
    });
}


export function listenToIsVoting(callback) {
    console.log("Listening to is voting...");
    isVotingRef = ref(db, "sharedData/state/isVoting");

    isVotingCallback = async (snapshot) => {
        const isVoting = snapshot.val();
        callback(isVoting)
    };

    onValue(isVotingRef, isVotingCallback);
}


export function stopListeningToIsVoting() {
    if (isVotingRef && isVotingCallback) {
        off(isVotingRef, isVotingCallback);
        console.log("Stopped listening to is voting.");
    }
}
