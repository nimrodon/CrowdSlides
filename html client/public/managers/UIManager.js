// UIManager.js

let appDiv;
let config;
let userSelectionCallback;

export function initUI(configuration, selectionCallback) {
    window.selectOption = selectOption;
    config = configuration;
    userSelectionCallback = selectionCallback;
    let direction;
    if (config.isRTL) {
        direction = 'rtl';
    }
    else {
        direction = 'ltr';
    }
    console.log("dir = " + direction)
    appDiv = document.getElementById('app');
    appDiv.setAttribute('dir', direction);
}

export function showSelection(selectionConfig) {
    console.log("Show selection");
    const options = selectionConfig.options || [];
    const titleHTML = selectionConfig.message || "Choose:";
    let optionsHTML = `<div class="title">${titleHTML}</div>`;
    options.forEach((option, index) => {
        optionsHTML += `
        <button
            class="selection-button"
            data-index="${index}"
            onclick="selectOption(${index})">
            ${option}
        </button>
        `;
    });
    appDiv.innerHTML = optionsHTML;

    updateSelectionUI(-1);
}


export function updateSelectionUI(selectedIndex) {
    const buttons = document.querySelectorAll('.selection-button');
    buttons.forEach((button) => {
        const buttonIndex = parseInt(button.getAttribute('data-index'), 10);

        if (buttonIndex === selectedIndex) {
            button.classList.add('selected');
        } else {
            button.classList.remove('selected');
        }

        button.disabled = selectedIndex !== -1;
    });
}


export function showWaitMessage() {
  console.log("show wait message")
  if  (document.getElementById("wait-message") === null) {
      const waitMessages = config.waitForSelectionTexts || ['Please wait'];
      const waitMessage = waitMessages[Math.floor(Math.random() * waitMessages.length)];
      appDiv.innerHTML = `<span id ="wait-message" class="general-text">${waitMessage}</span>`;
  }
}


export function displayVoteSubmittedMessage() {
    const voteSubmittedMessage = document.createElement('div');
    voteSubmittedMessage.className = 'vote-submitted-message';
    voteSubmittedMessage.innerText = config.voteSubmittedText;
    document.getElementById('app').appendChild(voteSubmittedMessage);
}

export function showIntro() {
  const introTitleText = config.introTitleText || 'Welcome!';
  appDiv.innerHTML = `
      <h1>${introTitleText}</h1>
      <div class="intro-spacer"></div>
      <p class="general-text">${config.joinText}</p>
  `;
}

export function showEnding() {
  appDiv.innerHTML = `
      <p class="ending">${config.endingText}</p>
  `;
}

function selectOption(index) {
  userSelectionCallback(index)
}
