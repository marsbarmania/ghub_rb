# gem evernote_oauth
require 'evernote_oauth'

# Need to register
# https://sandbox.evernote.com/api/DeveloperToken.action
auth_token = "DeveloperToken"

# create oauth client
client = EvernoteOAuth::Client.new(token: auth_token)

auth_token = "DeveloperToken"
user_store = EvernoteOAuth::Client.new(token: auth_token).user_store
user_store.getUser

# create note_store
note_store = client.note_store
# get list of the notebooks
notebooks = note_store.listNotebooks

# Create Note with the ENML format
note = Evernote::EDAM::Type::Note.new
note.title = "My Note Title"

note.content = '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Post Content from local env....<br/></en-note>'

# create note here
note_store.createNote(note)
