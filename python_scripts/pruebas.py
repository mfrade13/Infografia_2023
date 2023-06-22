import cv2 
import numpy as np

print("hello world")

variable_char = 's'
variable_int = 1231
variable_float = 1232.43
variable_bool = True
variable_string = "str123"

variable_dictionarios = dict()
otra_variante_diccionarios = {
    "llave": "valor" ,
    "llave2": 1231
}

variable_lista = [32,43,"sdfs", 243, False, None, 34]

print(otra_variante_diccionarios)
print(variable_lista[4])

for key, value in otra_variante_diccionarios.items():
    print(key,value)

def sumar(a,b):
    '''
    Funcion que me permite sumar variable a y b y dar un resultado
    '''
    return a+b

if variable_lista[4] == True:
    print("bloque if")

else:
    print("bloque else")

print(sumar(45, 22))

## Bloque de procesamiento de imagenes con cv2
# img = cv2.imread("1.jpg", cv2.IMREAD_COLOR)

# img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

# height, width, _ = img.shape

# cw = int(width/2)
# ch = int(height/2)

# cv2.circle( img, (int(width/2), int(height/2)), 4, (255,0,0),3)
# cv2.imshow("frame", img)
# cv2.imshow("gray_panel", img_gray)
# cv2.imshow("panel hsv", img_hsv)
# cv2.waitKey(9000)




cap = cv2.VideoCapture(0)
texto_color = "Indefinida"

limite_inferior = np.array([0,100,20])
limite_superior = np.array([20, 255,255])

while True:
    _, frame = cap.read()

    frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    height, width, _ = frame.shape
    cw = int(width/2)
    ch = int(height/2)

    frame_hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(frame_hsv, limite_inferior, limite_superior)

    pixel_center = frame_hsv[cw, ch]
    valor_color_de_la_imagen = pixel_center[0]

    if valor_color_de_la_imagen <= 5:
        texto_color = "red"
    elif valor_color_de_la_imagen <= 22:
        texto_color = "naranja"
    elif valor_color_de_la_imagen <= 33:
        texto_color = "amarillo"
    elif valor_color_de_la_imagen <= 78:
        texto_color = "verde"
    elif valor_color_de_la_imagen <= 133:
        texto_color = "azul"

    cv2.putText(frame, texto_color, (10, 70), 0, 1.5, (255,0,0), 5)
    cv2.circle( frame, (cw, ch), 4, (255,0,0),3)

    frame_mask = cv2.bitwise_and(frame, frame, mask=mask)

    cv2.imshow("video", frame)
    cv2.imshow("mascara", mask)
    cv2.imshow("mascara_colores", frame_mask)
    key = cv2.waitKey(1)
    if key == 27:
        break

cap.release()
cv2.destroyAllWindows()