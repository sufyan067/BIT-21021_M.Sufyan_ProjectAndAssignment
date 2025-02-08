import cv2
import numpy as np
from keras.models import load_model

model = load_model('model.h5')

video = cv2.VideoCapture(0)

faceDetect = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

label_dict = {0:'Angry', 1:'Disgust', 2:'Fear', 3:'Happy', 4:'Neutral', 5:'Sad', 6:'Surprise',}


while True:
    ret, input = video.read()
    gray = cv2.cvtColor(input, cv2.COLOR_BGR2GRAY)
    faces = faceDetect.detectMultiScale(gray, 1.3, 3)

    for x, y, w, h in faces:
        sub_face = gray[y:y + h, x:x + w]
        resized = cv2.resize(sub_face, (48, 48))
        normalize = resized / 255
        reshaped = np.reshape(normalize, (1, 48, 48, 1))
        result = model.predict(reshaped)
        label = np.argmax(result, axis=1)[0]
        print(label)
        cv2.rectangle(input, (x, y), (x + w, y + h), (0, 0, 255), 1)
        cv2.rectangle(input, (x, y), (x + w, y + h), (50, 50, 255), 2)
        cv2.rectangle(input, (x, y - 40), (x + w, y), (50, 50, 255), -1)
        cv2.putText(input, label_dict[label], (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255, 255, 255), 2)
    cv2.imshow("Frame:", input)
    k = cv2.waitKey(1)
    if k == ord('q'):
        break


video.release()
cv2.destroyAllWindows()

