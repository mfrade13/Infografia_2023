'''
    Miguel Frade Flores
    Codigo: 26207
'''

import numpy as np
# import matplotlib.pyplot as plt
import pandas as pd
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import confusion_matrix,accuracy_score, recall_score, precision_score
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier


# Import data sets into the program
dataset = pd.read_csv('test.csv')
training_set = pd.read_csv("train.csv")
sobrevivientes = pd.read_csv("gender_submission.csv")

#Variables adicionales para preservar los resultados
lista_de_modelos = []

# Funcion auxiliar para obtener un promedio de las edades presentes ignorando las vacias
def fill_age_empty(cp, row):
    df = cp.copy()
    r = df.iloc[:, row]
    r.fillna(0, inplace=True)
    suma1 = 0
    invalidos = 0
    for i, el in enumerate(r.values):
        if (el==0.0):
            invalidos+=1
        else:
            suma1+=round(el)
    promedio = suma1/(len(r.values) -invalidos)
    print("Promedio ", promedio, " invalidos", invalidos, "Suma", suma1)
    return promedio

# Primero utilizaremos la funcion auxiliar para llenar los espacios vacios de Edad con el valor calculado del promedio
prom = fill_age_empty(dataset, 4)
dataset["Age"].fillna(round(prom,1), inplace = True)

prom_train = fill_age_empty(training_set, 5)
training_set["Age"].fillna(round(prom_train,1), inplace = True)

# Manipular los datos de genero a valores binarios y no cadenas de texto
dataset["Sex"] = dataset["Sex"].replace("female", 1)
dataset["Sex"] = dataset["Sex"].replace("male", 0)

training_set["Sex"] = training_set["Sex"].replace("female", 1)
training_set["Sex"] = training_set["Sex"].replace("male", 0)

# Modificar los valores de embarcacion a valores numericos
training_set["Embarked"].fillna(0, inplace=True)
training_set["Embarked"] = training_set["Embarked"].replace("S", 0)
training_set["Embarked"] = training_set["Embarked"].replace("C", 1)
training_set["Embarked"] = training_set["Embarked"].replace("Q", 2)

dataset["Embarked"].fillna(0, inplace=True)
dataset["Embarked"] = dataset["Embarked"].replace("S", 0)
dataset["Embarked"] = dataset["Embarked"].replace("C", 1)
dataset["Embarked"] = dataset["Embarked"].replace("Q", 2)

# Modificar los valores del fare, llenar los vacios con la media
training_set['Fare'].fillna(training_set['Fare'].dropna().median(), inplace=True)
dataset['Fare'].fillna(dataset['Fare'].dropna().median(), inplace=True)

# Manipular la cantidad de familiares que tiene la persona.

training_set['family'] = training_set.apply(lambda row: row.SibSp + row.Parch +1, axis=1)
dataset['family'] = dataset.apply(lambda row: row.SibSp + row.Parch +1, axis=1)


## print(training_set.iloc[:,12].values)

# Seleccionar las columnas que se van a utilizar para el entrenamiento
x_train = training_set.iloc[:, [2,4,5,9,11,12]].values
y_train = training_set.iloc[:,1].values
# Dividir la informacion para el entrenamiento
x_train, x_test, y_train, y_test = train_test_split(x_train, y_train, test_size = 0.20, random_state = 0)

forecast_x = dataset.iloc[:, [1,3,4,8,10,11]].values

# esatndarizar los datos
sc_X = StandardScaler()
x_train = sc_X.fit_transform(x_train)
x_test = sc_X.fit_transform(x_test)
forecast_x = sc_X.fit_transform(forecast_x)


# Testing models
# 1 kneighbors
neighbors_classifier = KNeighborsClassifier(n_neighbors = 5, metric = 'minkowski', p = 3)
neighbors_classifier.fit(x_train, y_train)

lista_de_modelos.append(dict() )
lista_de_modelos[0]["name"] = "k_vecinos"
lista_de_modelos[0]["y_pred"] = neighbors_classifier.predict(x_test)
lista_de_modelos[0]["forecast_y"] = neighbors_classifier.predict(forecast_x)
# Obtener las metricas del modelo de k neighbors
lista_de_modelos[0]["cm_test"] = confusion_matrix(y_test, lista_de_modelos[0]["y_pred"] )
lista_de_modelos[0]["acc_test"] = accuracy_score(y_test, lista_de_modelos[0]["y_pred"] )
lista_de_modelos[0]["recall_test"] = recall_score(y_test, lista_de_modelos[0]["y_pred"] )
lista_de_modelos[0]["prec_test"] = precision_score(y_test, lista_de_modelos[0]["y_pred"] )
lista_de_modelos[0]["score"] = round(neighbors_classifier.score(x_train, y_train) * 100, 2)

# print("Probabilidad de prediccion para los k vecinos", lista_de_modelos[0]["acc_test"])
# print(lista_de_modelos[0]["cm_test"], lista_de_modelos[0]["acc_test"], lista_de_modelos[0]["recall_test"], lista_de_modelos[0]["prec_test"] )
# print("score = ", lista_de_modelos[0]["score"] )

# Testing model 2 naive bayes
nb_classifier = GaussianNB()
nb_classifier.fit(x_train, y_train)

lista_de_modelos.append(dict() )
lista_de_modelos[1]["name"] = "naive bayes"
lista_de_modelos[1]["y_pred"] = nb_classifier.predict(x_test)
lista_de_modelos[1]["forecast_y"] = nb_classifier.predict(forecast_x)
# Validar metricas del naive bayes
lista_de_modelos[1]["cm_test"] = confusion_matrix(y_test, lista_de_modelos[1]["y_pred"] )
lista_de_modelos[1]["acc_test"] = accuracy_score(y_test, lista_de_modelos[1]["y_pred"] )
lista_de_modelos[1]["recall_test"] = recall_score(y_test, lista_de_modelos[1]["y_pred"] )
lista_de_modelos[1]["prec_test"] = precision_score(y_test, lista_de_modelos[1]["y_pred"] )
lista_de_modelos[1]["score"] = round(nb_classifier.score(x_train, y_train) * 100, 2)

# print("Probabilidad de prediccion para naive bayes", lista_de_modelos[0]["acc_test"])
# print(lista_de_modelos[1]["cm_test"], lista_de_modelos[1]["acc_test"], lista_de_modelos[1]["recall_test"], lista_de_modelos[1]["prec_test"] )
# print("score = ", lista_de_modelos[1]["score"] )

# Testing model 3 Decition tree classifier
dtree_classifier = DecisionTreeClassifier(
    criterion="gini",
    min_samples_leaf=4,     # tener menos objetos en cada hoja, sobre estima y sobre ajusta el arbol creando zonas
    random_state=0
)
dtree_classifier.fit(x_train, y_train)

lista_de_modelos.append(dict() )
lista_de_modelos[2]["name"] = "Decition tree"
lista_de_modelos[2]["y_pred"] = dtree_classifier.predict(x_test)
lista_de_modelos[2]["forecast_y"] = dtree_classifier.predict(forecast_x)

# Calculo de Metricas para el decition tree
lista_de_modelos[2]["cm_test"] = confusion_matrix(y_test, lista_de_modelos[2]["y_pred"] )
lista_de_modelos[2]["acc_test"] = accuracy_score(y_test, lista_de_modelos[2]["y_pred"] )
lista_de_modelos[2]["recall_test"] = recall_score(y_test, lista_de_modelos[2]["y_pred"] )
lista_de_modelos[2]["prec_test"] = precision_score(y_test, lista_de_modelos[2]["y_pred"] )
lista_de_modelos[2]["score"] = round(dtree_classifier.score(x_train, y_train) * 100, 2)

# print("Probabilidad de prediccion para el decision tree", lista_de_modelos[2]["acc_test"])
# print(lista_de_modelos[1]["cm_test"], lista_de_modelos[1]["acc_test"], lista_de_modelos[1]["recall_test"], lista_de_modelos[1]["prec_test"] )
# print("score = ", lista_de_modelos[2]["score"] )

# Modelo numero 4 Random Forest
rf_classifier = RandomForestClassifier(n_estimators = 200, criterion = "entropy", min_samples_leaf = 2, random_state = 0)
rf_classifier.fit(x_train, y_train)
 
lista_de_modelos.append(dict() )
lista_de_modelos[3]["name"] = "Random  Forest con entropy"
lista_de_modelos[3]["y_pred"] = rf_classifier.predict(x_test)
lista_de_modelos[3]["forecast_y"] = rf_classifier.predict(forecast_x)

# Calculo de metricas para el random forest
lista_de_modelos[3]["cm_test"] = confusion_matrix(y_test, lista_de_modelos[3]["y_pred"] )
lista_de_modelos[3]["acc_test"] = accuracy_score(y_test, lista_de_modelos[3]["y_pred"] )
lista_de_modelos[3]["recall_test"] = recall_score(y_test, lista_de_modelos[3]["y_pred"] )
lista_de_modelos[3]["prec_test"] = precision_score(y_test, lista_de_modelos[3]["y_pred"] )
lista_de_modelos[3]["score"] = round(rf_classifier.score(x_train, y_train) * 100, 2)

# print("Probabilidad de prediccion para el random forest", lista_de_modelos[3]["acc_test"])
# print(lista_de_modelos[3]["cm_test"], lista_de_modelos[3]["acc_test"], lista_de_modelos[3]["recall_test"], lista_de_modelos[3]["prec_test"] )
# print("score = ", lista_de_modelos[3]["score"] )

# Modelo numero 5 SVM sigmoid

svm_classifier = SVC(kernel="sigmoid", degree=3, random_state=0)
svm_classifier.fit(x_train, y_train)

lista_de_modelos.append(dict() )
lista_de_modelos[4]["name"] = "Sub Vector Machine con sigmoid"
lista_de_modelos[4]["y_pred"] = svm_classifier.predict(x_test)
lista_de_modelos[4]["forecast_y"] = svm_classifier.predict(forecast_x)

# Calculo de metricas para el svm
lista_de_modelos[4]["cm_test"] = confusion_matrix(y_test, lista_de_modelos[4]["y_pred"] )
lista_de_modelos[4]["acc_test"] = accuracy_score(y_test, lista_de_modelos[4]["y_pred"] )
lista_de_modelos[4]["recall_test"] = recall_score(y_test, lista_de_modelos[4]["y_pred"] )
lista_de_modelos[4]["prec_test"] = precision_score(y_test, lista_de_modelos[4]["y_pred"] )
lista_de_modelos[4]["score"] = round(svm_classifier.score(x_train, y_train) * 100, 2)

# print("Probabilidad de prediccion para el SVM", lista_de_modelos[4]["acc_test"])
# print(lista_de_modelos[4]["cm_test"], lista_de_modelos[4]["acc_test"], lista_de_modelos[4]["recall_test"], lista_de_modelos[4]["prec_test"] )
# print("score = ", lista_de_modelos[4]["score"] )

# Modelo numero 6 SVM rbf

svm_classifier2 = SVC(kernel="rbf", degree=3, random_state=0)
svm_classifier2.fit(x_train, y_train)

lista_de_modelos.append(dict() )
lista_de_modelos[5]["name"] = "Sub Vector Machine con rbf"
lista_de_modelos[5]["y_pred"] = svm_classifier2.predict(x_test)
lista_de_modelos[5]["forecast_y"] = svm_classifier2.predict(forecast_x)

# Calculo de metricas para el svm
lista_de_modelos[5]["cm_test"] = confusion_matrix(y_test, lista_de_modelos[5]["y_pred"] )
lista_de_modelos[5]["acc_test"] = accuracy_score(y_test, lista_de_modelos[5]["y_pred"] )
lista_de_modelos[5]["recall_test"] = recall_score(y_test, lista_de_modelos[5]["y_pred"] )
lista_de_modelos[5]["prec_test"] = precision_score(y_test, lista_de_modelos[5]["y_pred"] )
lista_de_modelos[5]["score"] = round(svm_classifier2.score(x_train, y_train) * 100, 2)

# Modelo numero 7 SVM rbf

svm_classifier3 = SVC(kernel="poly", degree=3, random_state=0)
svm_classifier3.fit(x_train, y_train)

lista_de_modelos.append(dict() )
lista_de_modelos[6]["name"] = "Sub Vector Machine con poly"
lista_de_modelos[6]["y_pred"] = svm_classifier3.predict(x_test)
lista_de_modelos[6]["forecast_y"] = svm_classifier3.predict(forecast_x)

# Calculo de metricas para el svm
lista_de_modelos[6]["cm_test"] = confusion_matrix(y_test, lista_de_modelos[6]["y_pred"] )
lista_de_modelos[6]["acc_test"] = accuracy_score(y_test, lista_de_modelos[6]["y_pred"] )
lista_de_modelos[6]["recall_test"] = recall_score(y_test, lista_de_modelos[6]["y_pred"] )
lista_de_modelos[6]["prec_test"] = precision_score(y_test, lista_de_modelos[6]["y_pred"] )
lista_de_modelos[6]["score"] = round(svm_classifier3.score(x_train, y_train) * 100, 2)

# Modelo numero 8 Random Forest
rf_classifier2 = RandomForestClassifier(n_estimators = 200, criterion = "gini", min_samples_leaf = 2, random_state = 0)
rf_classifier2.fit(x_train, y_train)
 
lista_de_modelos.append(dict() )
lista_de_modelos[7]["name"] = "Random  Forest con gini"
lista_de_modelos[7]["y_pred"] = rf_classifier2.predict(x_test)
lista_de_modelos[7]["forecast_y"] = rf_classifier2.predict(forecast_x)

# Calculo de metricas para el random forest
lista_de_modelos[7]["cm_test"] = confusion_matrix(y_test, lista_de_modelos[7]["y_pred"] )
lista_de_modelos[7]["acc_test"] = accuracy_score(y_test, lista_de_modelos[7]["y_pred"] )
lista_de_modelos[7]["recall_test"] = recall_score(y_test, lista_de_modelos[7]["y_pred"] )
lista_de_modelos[7]["prec_test"] = precision_score(y_test, lista_de_modelos[7]["y_pred"] )
lista_de_modelos[7]["score"] = round(rf_classifier2.score(x_train, y_train) * 100, 2)


# # Modelo con red neuronal
# neural_classifier = Sequential()
# #Agregar Capa Entrada y Primera Capa Oculta
# neural_classifier.add(Dense(units = 7, activation = 'relu', input_dim = 7))

# #Agregar la Segunda Capa Oculta
# neural_classifier.add(Dense(units = 7, activation = 'relu'))

# #Agregar Capa de Salida
# neural_classifier.add(Dense(units = 1, activation = 'sigmoid'))

# #Compilar la Red Neuronal
# neural_classifier.compile(optimizer ='adam', loss = 'binary_crossentropy', metrics = ['accuracy'])

# #Entrenar la Red Neuronal sobre Datos Training
# neural_classifier.fit(x_train, y_train, batch_size = 100, epochs = 20)

# #Predecir Resultados de los Datos Test
# rn_y_pred = neural_classifier.predict(x_test)
# rn_y_pred = (rn_y_pred > 0.5)

#Evaluar Resultados del Test (Matriz de Confusion)

# cm_test = confusion_matrix(y_test, rn_y_pred)
# acc_test = accuracy_score(y_test, rn_y_pred)
# recall_test = recall_score(y_test, rn_y_pred)
# prec_test = precision_score(y_test, rn_y_pred)

# print("Resultado de la red neuronal", acc_test)


# Reordenar la lista para obtener el modelo con el mejor puntaje
newlist = sorted(lista_de_modelos, key=lambda k: k['score']) 

for row in newlist:
    print("El modelo " + row["name"] + " tiene un score de: " + str(row["score"]) + " con un accuracy de " + str(row["acc_test"]) + " y una precision de " + str(row["prec_test"]) )


# Crear el csv para el submit de kaggle en base al modelo con el mejor score que seria el ultimo de la lista ordenada
passangerd_ids = sobrevivientes.iloc[:,0].values

output_csv = pd.DataFrame({
    "PassengerId": passangerd_ids,
    "Survived": newlist[len(newlist)-1]["forecast_y"]  # Obtener el ultimo elemento de la lista ordenada
    })
compression_opts = dict(method='zip',archive_name='out.csv')  
output_csv.to_csv('output.csv', index=False) 


# Comentarios adicionales
'''
    En el registro de submisiones se puede apreciar un puntaje mas alto, personalmente fue raro ver que mientras mas "pre-procesaba" la informacion de las columnas, 
    el resultado disminuyo en relacion al primer intento que abarcaba menos columnas, tambien el resultado vario en relacion a los valores que se usaron para llenar los valores vacios.
    Aparentemente tambien hubo una variacion, un modelo que aparentaba tener un mejor score obtuvo resultado menor al de otro modelo con menor score, quizas es ahi que la cantidad de
    falsos positivos (prec_test) denoto que se tenia un valor mas alto en uno que otro que mostro claramente que ese tipo de errores si afecta al resultado final.
    El modelo de redes neuronales fue excluido ya que presentaba resultados poco satisfactorios, probablemente en el como la red neuronal fue creada repercutia en ese resultado,
    algo mas de practica en ese ambito podria haber generado un mejor modelo para la red neuronal. (sus librerias fueron excluidas tambien del programa)
'''

