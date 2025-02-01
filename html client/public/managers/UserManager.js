// UserManager.js
import { v4 as uuidv4 } from "https://jspm.dev/uuid";

export function getOrCreateUserId() {
    let userId = localStorage.getItem('userId');
    if (!userId) {
        userId = uuidv4();
        localStorage.setItem('userId', userId);
        console.log(`New userId created: ${userId}`);
    } else {
        console.log(`Existing userId found: ${userId}`);
    }
    return userId;
}
