# task_manager

Cross Platform Application Development (Merged - SEZG585/SSZG585)(S1-23)
Assignment 1 <br />
Flutter App with Back4App Integration

#### Assignment Description:
In this assignment, you will create a Flutter app that connects to Back4App, a Backend-as-a-Service (BaaS) platform, to manage tasks. You will be responsible for setting up the Back4App backend, creating the Flutter app, and implementing the necessary functionality to interact with the backend.

## Getting Started

### Setting up Flutter
Please follow steps on
https://docs.flutter.dev/get-started/install

Windows: https://docs.flutter.dev/get-started/install/windows <br />
Mac: https://docs.flutter.dev/get-started/install/macos <br />
Linux: https://docs.flutter.dev/get-started/install/linux <br />

## Running Task Manager
To run Task Manager, clone this repository.<br />
Open Terminal/Command Prompt to the path of this repository. <br />
Run the command 'flutter run' <br />
Then select the target device to run it on web, mobile, emulator, simulator, etc.

### Landing Screen
**Web** <br />
![img.png](img.png)

**Mobile** <br />
![img_9.png](img_9.png)

The application opens on the tab of DEFINED tasks. <br />
The task name can be seen in bold and its corresponding description can be seen just below it.

There are 2 other states that a task can have, IN-PROGRESS and COMPLETED which are seen in the remaining 2 tabs.
<br />
<br /> <strong> IN-PROGRESS Tab </strong> <br />
![img_1.png](img_1.png)

![img_12.png](img_12.png)

<br /> <strong> COMPLETED Tab </strong> <br />
![img_2.png](img_2.png)

![img_13.png](img_13.png)
<br />
<br />

----------
#### NOTE:

The tasks in the DEFINED tab are sorted in the descending order of their creation. <br />
The tasks that created recently show up at the top of the screen.
<br />
<br />
The tasks in the IN-PROGRESS and COMPLETED tabs are sorted in the descending order of their modification.
The tasks that were modified recently show up at the top of the screen.<br />
---------

### New Task Screen
**Web** <br />
![img_3.png](img_3.png)

**Mobile** <br />
![img_10.png](img_10.png)

One can add a task name and a task description. <br />
On clicking the 'CREATE' button, the data gets saved to the Back4App database. <br />

**_Validation_** has been added, the task won't be created unless it has a name and a description <br />
The user is prompted with 'Some Data Missing' text in a snackbar at the bottom of the screen. <br />
![img_4.png](img_4.png)

![img_14.png](img_14.png)

Clicking the 'CREATE' button also takes the user back to the landing screen, where the user can then view the created task under the DEFINED tab. <br />

### Update Task Screen
**Web** <br />
![img_5.png](img_5.png)

**Mobile** <br />
![img_11.png](img_11.png)

The user is presented with the task details alongwith the ID of the task he/she is editing. <br />
The user may edit the task name, the task description as well as the state of the task to **ONE** of the **THREE** available states, _DEFINED_, _IN-PROGRESS_ or _COMPLETED_ <br />

States:
![img_7.png](img_7.png)

![img_15.png](img_15.png)

Similar **_validations_** are in place when editing the task.<br />
![img_6.png](img_6.png)

![img_16.png](img_16.png)

On clicking the 'UPDATE' button, the data is updated in the Back4App database. <br />
Clicking the 'UPDATE' button also takes the user back to the landing screen, where the user can then view the updated task under the respective tab. <br />

### Delete Task
On clicking the trash can icon next to the task name, the task gets deleted.<br />
The user is notified in a snackbar at the bottom of the screen with a message that contains the deleted task ID. <br />
![img_8.png](img_8.png)

![img_17.png](img_17.png)

## References:
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
