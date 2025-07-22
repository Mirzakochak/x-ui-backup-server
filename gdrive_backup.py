import os
import datetime
from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.http import MediaFileUpload
from google.auth.transport.requests import Request

SCOPES = ['https://www.googleapis.com/auth/drive.file']

def upload_to_drive(file_path):
    creds = None
    token_path = '/root/gdrive-backup/token.json'
    creds_path = '/root/gdrive-backup/credentials.json'

    if os.path.exists(token_path):
        creds = Credentials.from_authorized_user_file(token_path, SCOPES)

    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(creds_path, SCOPES)
            creds = flow.run_console()
        with open(token_path, 'w') as token:
            token.write(creds.to_json())

    service = build('drive', 'v3', credentials=creds)
    file_metadata = {'name': os.path.basename(file_path)}
    media = MediaFileUpload(file_path, resumable=True)
    file = service.files().create(body=file_metadata, media_body=media, fields='id').execute()
    print(f"✅ Uploaded to Google Drive. File ID: {file.get('id')}")

def backup_and_upload():
    now = datetime.datetime.now().strftime('%Y-%m-%d-%H-%M')
    backup_file = f"/root/gdrive-backup/xui-backup-{now}.tar.gz"
    os.system(f"tar -czf {backup_file} /etc/x-ui")
    upload_to_drive(backup_file)
    os.remove(backup_file)

if __name__ == '__main__':
    backup_and_upload()
