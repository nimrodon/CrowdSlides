// main.js
//
// This is the main file of the CrowdSlides HTML client.
// The content of the client page is determined by a database which is updated by the master client (a computer connected to a display that everyone watches)
// which displays a slideshow.
// This client supports user insteractions with the slideshow: in certain points the users are requested to select an option,
// and the results of the total voting affects the flow of the slideshow.
//
// there are four content types that can be displayed:
// 1. intro - user is presented with a welcome message
// 2. ending - user is presented with a farewell message
// 3. selection - user is presented with a selection UI, and needs to vote.
// 4. waiting - user is prsented with a random waiting message. this is generally the mosts frequent content type.
//
//

import * as dbManager from "./managers/FirebaseManager.js";
import * as userManager from "./managers/UserManager.js"
import * as uiManager from "./managers/UIManager.js";


// initialization

async function initApp() {
  dbManager.initDB()
  try {
      await initializeUser();
      const config = await dbManager.loadConfig();
      uiManager.initUI(config, (selectedIndex) => {
        handleSelectedOption(selectedIndex)
      });
      console.log("All configurations loaded!");
      initDBListeners();
  } catch (error) {
      console.error("Error during initialization:", error);
  }
}

async function initializeUser() {
    const userId = userManager.getOrCreateUserId();
    await dbManager.addUserIfNotExists(userId);
    console.log('User initialization complete.');
}

function initDBListeners() {
  dbManager.listenToSlideType((slideType) => {
    handleSlide(slideType)
  });
}



// Event handlers

async function handleSlide(slideType) {
    console.log("Handle slide...");

    switch (slideType) {
        case 'intro':
            uiManager.showIntro()
            break;

        case 'selection':
            handleNewSelection()
            break;

        case 'ending':
            uiManager.showEnding()
            break;

        default:
            uiManager.showWaitMessage();
            break;
    }
}


async function handleNewSelection() {
  selectionConfig = await dbManager.loadSelectionConfig();
  dbManager.listenToIsVoting((isVoting) => {
    handleIsVoting(isVoting)
  });
}


function handleIsVoting(isVoting) {
  if (isVoting) {
    uiManager.showSelection(selectionConfig);
  }
  else {
    uiManager.showWaitMessage();
    dbManager.stopListeningToIsVoting();
  }
}


function handleSelectedOption(index) {
    console.log("selected option: " + index)
    dbManager.incrementVote(index)
    uiManager.displayVoteSubmittedMessage();
    uiManager.updateSelectionUI(index);
}

// main

console.log("running main...")
let selectionConfig;

await initApp();
