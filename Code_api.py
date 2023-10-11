import cv2
import numpy as np
from flask import Flask, request, jsonify
import time
import io

app = Flask(__name__)


@app.route("/process_video", methods=["POST"])
def process_video():
    if "video" not in request.files:
        return jsonify({"error": "No video file provided"}), 400

    video_file = request.files["video"]

    if video_file.filename == "":
        return jsonify({"error": "No selected file"}), 400

    # Check if the uploaded file is a valid video format (e.g., .mp4, .mov, etc.)
    allowed_extensions = {"mp4", "mov", "avi"}  # Add more extensions if needed
    if not allowed_file(video_file.filename, allowed_extensions):
        return jsonify({"error": "Invalid file format"}), 400

    video_file_path = video_file.filename
    cap = cv2.VideoCapture(video_file_path)

    if not cap.isOpened():
        raise Exception("Could not open video file: {}".format(video_file))
    number_of_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    start_time = time.time()
    timer = 0
    count = 0
    n = 0
    dictionary1 = {}
    dictionary2 = {}
    time_dict = {}
    shit = 0
    shit2 = 0
    new_dict = {}
    new = {}
    pus = 0
    t = 0

    result = []

    while True:
        count += 1
        timer = 0
        nim, frame = cap.read()
        k = 640 / 1080
        h = 1920 * k
        img = cv2.resize(frame, (int(h), 640))
        frame2 = img[292:382, 80:390]
        gray = cv2.cvtColor(frame2, cv2.COLOR_BGR2GRAY)
        gray_blurred = cv2.blur(gray, (3, 3))
        detected_circles = cv2.HoughCircles(
            gray_blurred,
            cv2.HOUGH_GRADIENT,
            1,
            20,
            param1=50,
            param2=30,
            minRadius=1,
            maxRadius=40,
        )

        circle_dim = {}
        circle_dim["dim"] = (0, 0, 0)

        if detected_circles is not None:
            detected_circles = np.uint16(np.around(detected_circles))

            for pt in detected_circles[0, :]:
                a, b, r = pt[0], pt[1], pt[2]
                circle_dim["dim"] = (a, b, r)
                n += 1
                cv2.circle(frame2, (a, b), 1, (0, 0, 255), 1)
                cv2.waitKey(1)
        canny = cv2.Canny(frame2, 30, 60)
        contours, heirarchies = cv2.findContours(
            canny, cv2.RETR_LIST, cv2.CHAIN_APPROX_NONE
        )

        blank = np.zeros(frame2.shape, dtype="uint8")
        # cv2.drawContours(blank,contours,-1,(0,255,255),1)

        if n == 1:
            (x, y, r) = circle_dim["dim"]

        frame3 = blank[:, y + r :]
        for i in range(0, 200, 20):
            new_frame = frame3[:, i : i + 20]
            new_dict[i] = new_frame
        pixelr, pixelb, pixelg = new_dict[0][45, 2]
        if (pixelr + pixelb + pixelg) > 250 and t == 0:
            new[0] = count / 25
            t = 1

        pixelr, pixelb, pixelg = new_dict[20][45, 1]
        if (pixelr + pixelb + pixelg) > 250 and t == 1:
            new[1] = count / 25
            t = 2

        pixelr, pixelb, pixelg = new_dict[40][45, 1]
        if (pixelr + pixelb + pixelg) > 250 and t == 2:
            new[2] = count / 25
            t = 3

        pixelr, pixelb, pixelg = new_dict[60][45, 1]
        if (pixelr + pixelb + pixelg) > 250 and t == 3:
            new[3] = count / 25
            t = 4

        pixelr, pixelb, pixelg = new_dict[80][45, 1]
        if (pixelr + pixelb + pixelg) > 250 and t == 4:
            new[4] = count / 25
            t = 5

        pixelr, pixelb, pixelg = new_dict[100][45, 1]
        if (pixelr + pixelb + pixelg) > 250 and t == 5:
            new[5] = count / 25
            t = 6

        pixelr, pixelb, pixelg = new_dict[120][45, 1]
        if (pixelr + pixelb + pixelg) > 250 and t == 6:
            new[6] = count / 25
            t = 7

        pixelr, pixelb, pixelg = new_dict[140][45, 1]
        if (pixelr + pixelb + pixelg) > 250 and t == 7:
            new[7] = count / 25
            t = 8

        pixelr, pixelb, pixelg = new_dict[160][45, 1]
        if (pixelr + pixelb + pixelg) > 250 and t == 8:
            new[8] = count / 25
            t = 9

        if t == 7:
            distance = 2.5
            for i in range(6):
                velocity = distance / (new[i + 1] - new[i])
                result.append({"distance": distance, "velocity": velocity})
                distance += 2.5
    cap.release()
    return jsonify(result)


def allowed_file(filename, allowed_extensions):
    return "." in filename and filename.rsplit(".", 1)[1].lower() in allowed_extensions


if __name__ == "__main__":
    app.run()
