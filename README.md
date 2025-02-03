# Crowd Slides

**Crowd Slides** is a crowd-interactive slideshow system designed for mass audiences watching a shared screen, often in settings like theaters, conferences, or live events. It allows presenters to create rich media slideshows with multiple narratives, dynamically influenced by the audience using their mobile devices.


## Features
- **MacOS Master Client** – Runs the slideshow displayed on a shared screen for the audience and is controlled by an operator.  
- **Lightweight HTML Client** – A web-based client accessible via any browser, allowing audience members to participate in real-time.  
- **Rich Media Slideshow** – Configured and edited via JSON files, supporting images, videos, sounds, and text.  
- **Decision Slides** – Interactive slides where the audience votes on different options, each leading to a unique narrative path.  
- **Live Voting Display** – Real-time voting results are shown on the main screen, enhancing audience engagement.  
- **Operator-Controlled Slideshow** – The operator navigates through slides, moves forward or backward, and resolves tie votes when needed.  

## Use Cases  

Crowd Slides can be used in various scenarios where audience participation enhances the experience:  

- **Interactive Plays, Sketches, or Improv Performances** – The audience decides what happens next on stage, making each show unique.  
- **Interactive Storytelling (No Live Performance)** – Develop dynamic stories that change based on crowd input, using images, sounds, speech, and videos to enhance the narrative.  
- **City Hall Meetings & Public Polling** – Facilitates voting on different agendas in meetings or town halls.  
  - *Note:* The current system is designed for entertainment and does not include security features such as vote authentication or preventing multiple votes from the same user. Additional development would be required for secure decision-making scenarios.  

## How It Works  

 - The **MacOS Master Client** runs the slideshow, controlled by an operator.  
 - Audience members connect to the **HTML Client** on their mobile devices by scanning a QR code displayed in the slideshow.  
 - The operator navigates through the slideshow and pauses when a decision is required.  
 - Audience members vote using their phones, while live voting results are displayed on the slideshow.  
 - Once voting is complete, the slideshow continues along a path based on the majority decision.  
 - If the vote is tied, the operator manually decides the outcome.

## System Architecture  

Crowd Slides consists of three main components:

### MacOS Master Client (Single Instance)  
- The **MacOS client** is the central system running the slideshow, connected to a **shared screen** that the entire audience watches.  
- Reads **local JSON files** that configure the slideshow and HTML client’s content and settings.  
- Uses **Firebase Realtime Database** to write content and configurations for the HTML clients and to collect audience votes.  
- The operator controls the **MacOS client**, navigating forward or backward through slides and resolving tie votes.  

### HTML Client (Multiple Instances)
- A lightweight **web-based client** accessible via mobile devices.  
- Allows audience members to vote and influence the slideshow’s narrative.  
- Fetches its settings and content from **Firebase Realtime Database** and sends votes back to Firebase.  

### Firebase Realtime Database  
- Acts as the **communication bridge** between the MacOS client and HTML clients.  
- Handles synchronization of slideshow state and live voting updates.  
- Ensures all connected devices are updated instantly as votes are cast and slides progress.  


## Technologies

### Mac Client:
- **Programming Language:** Swift
- **Architecture:** MVVM (Model-View-ViewModel)
- **Frameworks:** SwiftUI, Combine
- **External Packages (SPM)**: FirebaseCore, FirebaseDatabase
- **Minimum Version:** MacOS 11.0 (Big Sur)

### HTML Client:
- **Programming Language:** JavaScript, HTML, CSS
- **Frameworks & Libraries**: Firebase
- **Hosting:** Local web server or cloud-based hosting

### Backend (Firebase)
- **Database:** Firebase Realtime Database

----

## Setup  

First, you need to clone the repository / download and unzip code.

Crowd Slides offers two setup options based on your needs:  

### **1. Simple Setup (Quick Start - No Hosting Required)**  
This setup is meant for **testing and experimenting** with the system to understand how it works. It allows you to modify the slideshow and client’s content and configurations and see the system in action **without setting up your own database or hosting**.  

- Uses the **demo Firebase database** (shared with other users).  
- Uses the **hosted demo HTML client** (fixed URL).  
- You **only need to modify JSON files** to customize the slideshow.  
- **Occasional Use** – Ideal for quick demonstrations or testing but not recommended for long-term or private use.  
- **Limitations:**  
  - Since the database is shared, multiple users may **overwrite each other’s data**.  
  - If database usage exceeds Firebase's **free tier limit**, it will stop functioning.  

#### **How to Use the Simple Setup:**  
- Open the **MacOS project** in Xcode, build and run it. It includes a sample interactive story.
- Use the hosted demo HTML client to interact with the slideshow: [Crowd Slides Demo](https://crowdslides-demo.web.app/). The link is also available through the **QR Code** in the first slide of the demo presentation.  
- Edit the JSON files (`slides.json`, `client_config.json`) to customize the slideshow.  

---

### **2. Advanced Setup (Your Own Database & HTML Hosting)**  
If you want a **stable and private setup**, you **must** set up your **own Firebase database** and **host your own HTML client**, as the client must connect to the correct database.  

This setup is recommended for users who:  
- Want a **secure and private** system that no one else can change.  
- Need to **customize the HTML client** beyond what the hosted version allows.  
- Want full control over the **database, settings, and hosting**.  

---

#### **Step 1: Set Up Your Own Firebase Database** *(Has a free tier, no payments required.)*  
- Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.  
- Enable Firebase **Realtime Database**.  

---

#### **Step 2: Configure MacOS <-> Database Connection**  
- In Firebase Console **Project Settings**, add an **Apple app**.  
- The **Bundle ID** must match CrowdSlides **MacOS app’s Bundle ID** in Xcode.  
- Download the `GoogleService-Info.plist` file and **replace** it in the **Xcode project**.  

---

#### **Step 3: Configure and Deploy HTML Client <-> Database Connection**  
- In Firebase Console **Project Settings**, add a **Web App**.  
- If you want **Firebase to host your HTML client** (*recommended and free*), check **"also set up Firebase Hosting for this app"**.  
- In the **"Add Firebase SDK"** step, copy the `firebaseConfig` constant and replace it in:  
   - `FirebaseManager.js` inside the **HTML client**.  
- If you chose **Firebase Hosting**, follow the instructions in:  
   - **"Install Firebase CLI"** step.  
   - **"Deploy to Firebase Hosting"** step to upload your HTML client.  
- If you are using **another web server**, deploy the HTML client there.  

---

#### **Step 4: Hosting the HTML Client Locally (Optional)**  
If you want to **host the HTML client locally** on a simple web server, use **Python**:  
- Open **Terminal**.  
- Navigate to the **HTML client folder**.  
- Run:  
    ```sh
    python3 -m http.server 8000
    ```  
    (*If Python 3 is not installed, install it first.*)  
- Find your local IP address by running:  
    ```sh
    ipconfig getifaddr en0
    ```  
- To open the HTML client from a **mobile device** (must be on the same Wi-Fi network as your computer), navigate to:  
    ```
    http://YOUR_LOCAL_IP:8000
    ```
    *(Example: `http://192.168.1.3:8000`)*  

---

#### **Step 5: Update QR Code in the Slideshow**  
- Replace the **QR Code image** in the **Intro Slide** with a new one that redirects to your HTML client (cloud hosted or local).  

#### **Step 6: Run the Slideshow**  
- Build and run the MacOS app in XCode. It includes a sample interactive story.
- Use your hosted HTML client to interact with the slideshow: Scan the new QR code you have just updated.
- Edit the JSON files (`slides.json`, `client_config.json`) to customize the slideshow.

---

## Operating Instructions  

The operator controls the slideshow using the keyboard.  

- **Advance to the next slide** – Press the **Right Arrow (→)** key or **Spacebar**.  
- **Go back to the previous slide** – Press the **Left Arrow (←)** key.  
- **During Selection Slides (Decision Points):**  
  - A selection slide consists of **three phases**:  
    1. **Presentation Phase** – The available choices are displayed to the audience.  
    2. **Voting Phase** – The audience votes using their mobile devices. A **countdown timer** limits this phase.  
    3. **Show Results Phase** – Voting results are displayed.  
  - Phase navigation follows the same controls as regular slides.
  - Pressing **Right Arrow (→) or Spacebar** during voting **ends the voting early** and advances to the results phase.  
  - If the results are a tie, the operator must **manually select the outcome** by pressing the corresponding **number key (1, 2, 3, ...)**.  
    - Each number key represents a voting choice, ordered **from left to right** on the screen.  


## Slideshow Editing  

The slideshow is configured using two main JSON files:  

- **`slideshow.json`** – Defines the slides and overall settings.  
- **`client_config.json`** – Primarily contains textual content for the HTML client.  

### slideshow.json Structure  

The `slideshow.json` file consists of two main sections:  
- **Slides Array** – Defines the slideshow content, consisting of multiple slide types.  
- **Settings** – General properties applied to all slides, such as fonts, colors, predefined texts, and selection settings.  

#### Slide Types in `slides` Array

Each slide has specific properties and functions within the slideshow. There are **four types** of slides:  

- **Intro Slide**  
  - Displays the **QR code** for audience members to scan and join.  

- **Story Slide**  
  - Contains **a background image or video, sounds, and text** for storytelling.  

- **Selection Slide** *(Decision-Based Slide)*  
  - A slide where a **decision point** occurs.  
  - Contains **text and data for each choice**, including:  
    - The **displayed text** for each choice.  
    - The **next slide ID**, determining where each choice leads.  
  - This structure allows for **branching narratives**, where different choices result in different slideshow paths.  


- **Ending Slide**  
  - Marks the **end of the slideshow path**.  
  - The operator **cannot advance beyond this slide**.  


### Further Details

Each property within these files is explained in detail in the **Model** section of the project.  

## Assets  

This project uses various asset types:  

- **JSON Files** – Configuration and slideshow content.  
- **Fonts** – Custom fonts used in the slideshow.  
- **Images** – Backgrounds and visual elements.  
- **Sounds** – Audio effects and background music.  
- **Videos** – Embedded video content for slides.  

### Assets Folder Structure  

All assets are stored in an **`assets`** folder (**case-sensitive**). Inside this folder, there are dedicated subfolders for each asset type:  

    /assets
    ├── json/
    ├── fonts/
    ├── images/
    ├── sounds/
    ├── videos/


### Referencing Assets in JSON Files  

- Asset references in **JSON files must include the file extension** (e.g., `.mp3`, `.png`).  
- If assets are placed in **subfolders**, the filename must include the relative path.  
  - Example:  
    ```
    "backgroundImage": "/Part1/house.png"
    ```  

### Asset Folder Placement  

- **During Development (Xcode Build & Run):**  
  - The `assets` folder should be in the **same directory** as the Xcode project file (`.xcodeproj`).  

- **In a Release Build:**  
  - The `assets` folder should be placed in the **same directory** as the `.app` file.

## License  

This project is licensed under the **Creative Commons Attribution-NonCommercial 4.0 International License**.  

- ✅ You may use, modify, and share this project for **personal and educational purposes** as long as you **credit the author**.  
- 🚫 **Commercial use is strictly prohibited** without explicit permission.  
- 📩 **For commercial use inquiries, please contact nyizhar@gmail.com**.

For full license details, see the [`LICENSE`](LICENSE) file.   
