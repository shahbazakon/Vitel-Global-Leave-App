#  Employee leave approval management

A new Flutter project for employee leave approval management.


![Image](https://github.com/user-attachments/assets/329d6e7b-0252-49a2-a33a-8df23c559514)

## 📌 Overview

This Flutter application provides a seamless experience for employee leave approval management. It includes a login system and a dashboard with two main sections: **Profile** and **Leave Approval**. The app integrates a GET API to fetch employee leave requests and categorizes them into three lists: **Pending, Approved, and Rejected**. The Pending list allows bulk approval with checkboxes.

## 📲 Screens & Functionality

### 1️⃣ Login Screen
- Users log in using their credentials.
- Upon successful authentication, they are redirected to the **Dashboard**.
- Basic validation is implemented for better security and user experience.

### 2️⃣ Profile Screen
- Displays basic user details such as:
  - First Name
  - Last Name
  - Official Email Address
  - Phone Number
  - Profile Image
- Allows users to view their information in a clean UI.

### 3️⃣ Leave Approval Screen
- Fetches a list of employees requiring leave approval using a GET API.
- Categorizes leave requests into three tabs:
  - **Pending**: Requests awaiting approval.
  - **Approved**: Successfully approved leave requests.
  - **Rejected**: Requests that were denied.
- Pending List Features:
  - Checkboxes for selecting multiple requests.
  - "Select All" option for bulk approval.
  - Intuitive UI for quick decision-making.

## ⚙️ Installation & Setup

### Step-by-Step Guide to Download and Run the Application

1. **Install Flutter**: If you haven't already, download and install Flutter from [Flutter's official site](https://flutter.dev/docs/get-started/install).
2. **Clone the repository**:
   ```sh
   git clone https://github.com/your-repo/demo.git
   ```
3. **Navigate to the project folder**:
   ```sh
   cd demo
   ```
4. **Install dependencies**:
   ```sh
   flutter pub get
   ```
5. **Open the project in your IDE**:
   - Open **Android Studio** or **VS Code**.
   - Select "Open an Existing Project" and navigate to the `demo` folder.
   - Ensure the Flutter plugin is installed in your IDE.
6. **Connect a Device or Emulator**:
   - Run `flutter doctor` to check for any issues.
   - Connect a physical device via USB or start an emulator from your IDE.
7. **Run the application**:
   ```sh
   flutter run
   ```

## 🛠️ Technologies Used
- **Flutter**: UI framework
- **Dart**: Programming language
- **API Integration**: Fetching employee leave data
- **State Management**: Provider / Riverpod (if applicable)

## 📌 Features Summary
✅ Secure login system  
✅ User profile section  
✅ Leave approval system  
✅ Categorization of leave requests  
✅ Multi-selection & bulk approval  
✅ Responsive and intuitive UI  


---
**Made with ❤️ using Flutter**
