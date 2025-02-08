import cv2
import numpy as np
from keras.models import load_model
import matplotlib.pyplot as plt

# Load the trained model and Haar Cascade classifier
model = load_model('model.h5')
faceDetect = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

# Define label dictionary for facial expressions
label_dict = {0: 'Angry', 1: 'Disgust', 2: 'Fear', 3: 'Happy', 4: 'Neutral', 5: 'Sad', 6: 'Surprise'}

# Load and process the input image
input = cv2.imread('face4.jpg')
gray = cv2.cvtColor(input, cv2.COLOR_BGR2GRAY)
faces = faceDetect.detectMultiScale(gray, 1.3, 3)

for x, y, w, h in faces:
    sub_face = gray[y:y + h, x:x + w]

    # Resize and normalize the face for prediction
    resized = cv2.resize(sub_face, (48, 48))
    normalize = resized / 255
    reshaped = np.reshape(normalize, (1, 48, 48, 1))
    result = model.predict(reshaped)
    label = np.argmax(result, axis=1)[0]

    # Draw rectangles around the detected face
    cv2.rectangle(input, (x, y), (x + w, y + h), (0, 0, 255), 1)
    cv2.rectangle(input, (x, y), (x + w, y + h), (50, 50, 255), 2)
    cv2.rectangle(input, (x, y - 40), (x + w, y), (50, 50, 255), -1)
    cv2.putText(input, label_dict[label], (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255, 255, 255), 2)

    # Generate Arousal Plot
    arousal_level = np.random.uniform(0, 1)  # Example arousal level; replace with actual if available

    # Create subplots for displaying image, histogram, and arousal plot side by side
    fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(15, 5))

    # Show the image with rectangles
    ax1.imshow(cv2.cvtColor(input, cv2.COLOR_BGR2RGB))
    ax1.set_title("Detected Faces")
    ax1.axis('off')

    # Plot Histogram of the detected face
    ax2.hist(sub_face.ravel(), bins=256, range=[0, 256], color='black')
    ax2.set_title("Grayscale Histogram")
    ax2.set_xlabel("Bins")
    ax2.set_ylabel("# of Pixels")

    # Plot the Arousal level
    ax3.bar(["Arousal"], [arousal_level], color='blue')
    ax3.set_ylim(0, 1)
    ax3.set_title(f"Emotion: {label_dict[label]}")
    ax3.set_xlabel("Arousal Level")
    ax3.set_ylabel("Intensity")

    # Display all plots
    plt.tight_layout()
    plt.show()

cv2.destroyAllWindows()
