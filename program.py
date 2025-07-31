from flask import Flask, Response, request
import webbrowser
import cv2
import face_recognition
import numpy as np
import os
import mysql.connector
import signal
import threading
from datetime import datetime

app = Flask(__name__)

SPRING_BOOT_URL = "http://localhost:8080/camera"

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Tharunk043",
    database="attendance_db"
)
cursor = conn.cursor()

# ✅ Load Known Faces Efficiently
IMAGE_DIR = "/home/velamakuru/Downloads/OS_Lab/exam"
known_faces = []
known_names = []

for file in os.listdir(IMAGE_DIR):
    if file.endswith(".jpg"):
        name = os.path.splitext(file)[0]
        image = face_recognition.load_image_file(os.path.join(IMAGE_DIR, file))
        encodings = face_recognition.face_encodings(image)

        if encodings:
            known_faces.append(encodings[0])
            known_names.append(name)

# ✅ Initialize Webcam with Smaller Frame Size
video_capture = cv2.VideoCapture(0)
video_capture.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
video_capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

frame_lock = threading.Lock()
latest_frame = None

def check_attendance_status(name):
    current_date = datetime.now().strftime("%Y-%m-%d")
    cursor.execute("SELECT COUNT(*) FROM attendance WHERE name = %s AND DATE(timestamp) = %s", (name, current_date))
    return cursor.fetchone()[0] > 0

def mark_attendance(name):
    if not check_attendance_status(name):
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        cursor.execute("INSERT INTO attendance (name, timestamp) VALUES (%s, %s)", (name, timestamp))
        conn.commit()
        return "Present"
    return "Already Present"

def process_frame():
    global latest_frame
    while True:
        success, frame = video_capture.read()
        if success:
            with frame_lock:
                latest_frame = frame.copy()

threading.Thread(target=process_frame, daemon=True).start()

def generate_frames():
    global latest_frame
    while True:
        with frame_lock:
            if latest_frame is None:
                continue
            frame = latest_frame.copy()

        rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        face_locations = face_recognition.face_locations(rgb_frame, model="hog")
        face_encodings = face_recognition.face_encodings(rgb_frame, face_locations)

        face_names = []
        attendance_status_list = []

        for face_encoding in face_encodings:
            matches = face_recognition.compare_faces(known_faces, face_encoding, tolerance=0.4)
            name = "Unknown"
            status = "Unknown"

            if True in matches:
                best_match_index = np.argmin(face_recognition.face_distance(known_faces, face_encoding))
                name = known_names[best_match_index]
                status = mark_attendance(name)

            face_names.append(name)
            attendance_status_list.append(status)

        for (top, right, bottom, left), name, status in zip(face_locations, face_names, attendance_status_list):
            color = (0, 255, 0) if status == "Present" else (0, 165, 255) if status == "Already Present" else (0, 0, 255)
            label = f"{name} ({status})"
            cv2.rectangle(frame, (left, top), (right, bottom), color, 2)
            cv2.rectangle(frame, (left, bottom - 30), (right, bottom), color, cv2.FILLED)
            cv2.putText(frame, label, (left + 6, bottom - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255, 255, 255), 2)

        ret, buffer = cv2.imencode('.jpg', frame)
        frame = buffer.tobytes()
        yield (b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

@app.route('/video_feed')
def video_feed():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/shutdown', methods=['POST', 'GET'])
def shutdown():
    global video_capture
    if video_capture.isOpened():
        video_capture.release()
        cv2.destroyAllWindows()
    os.kill(os.getpid(), signal.SIGTERM)
    return "Flask server stopped", 200

if __name__ == '__main__':
    webbrowser.open(SPRING_BOOT_URL)
    app.run(host='localhost', port=5001, threaded=True)