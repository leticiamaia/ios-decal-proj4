# Ditango

## Authors
- Leticia Maia Teixeira
- Lucas de Matos Figuredo 

## Purpose
Ditango is an app that transforms documents (PDF, DOC, TXT) into audio. That
way, you can listen to a paper in the gym, riding the bus, etc.

## Features
- Upload a file from device
- Upload a file from Google Drive
- Write text and convert
- Convert uploaded file
- Choose Audio Options:
  - Gender of voice
  - Time of pause between pages
  - Language of Text
  - Part of the document that you want to convert
- Save in the cloud 
- Listen to MP3 Audio
- Download MP3 Audio
- Search Audios by name
- Order Audios by:
  - Name
  - Date

## Control Flow
- User presented with a screen, in which they can fill a form and sign in or
click in the sign up button.
- If they click in the sign up button, they will be presented with a sign up
page with text fields and a button. They user should fill the fields and click
the button to create an account.
- If they fill the form and sign in, they will go to a page with their list of
audios and documents (main page) 
- They can start typing the name of an audio that they want to listen in the
top of the page to in order to search audios and documents by name.
- They can select a sorting option in order to sort audios and documents.
- If they click in an add button, a new view will appear. 
- The user can choose to create a new text document by typing a text and choosing 
a name for the new document.
- The user can click a button to select a file from the device to be uploaded.
- The user can click a button to select a file from google drive to be uploaded.
- For the two options above, the user can type in a text field to change the name
of the document that will be uploaded.
- The user can click cancel and go back to the documents list.
- The user can click save, and then a new view will appear.
- In the new view, the user can choose the name of the audio, the gender of the voice
and can click to open document text selection.
- Text selection?
- The user can click cancel, and the new document will appear in the documents/audios
list, but no audio will be made.
- The user can click convert, and the new document will appear in the 
documents/audios list, along with a new audio.
- There will be a side menu with options to sign out and go to the main page
- If the user clicks in the main page button, they main page will appear
- If the user click in sign out, they will go back to the login page. 

## Implementation

### Model
- Document
- Audio
- User

### View
- SideMenuView
- DocumentsTableView

### Controller
- LoginViewController
- SignUpViewController
- DocumentsTableViewController
- SideMenuViewController
- UploadDocumentViewController
- ConvertDocumentViewController
